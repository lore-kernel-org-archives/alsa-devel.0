From: "Rich Rattanni" <rattanni@gmail.com>
Subject: Re: ALSA driver problem after standby/resume
Date: Mon, 19 Mar 2007 15:30:33 -0400
Message-ID: <3187bd480703191230n628ed4fbtd368aa02a70e858c@mail.gmail.com>
References: <3187bd480703190931t919183ej9a54ff4fc3cba89b@mail.gmail.com>
	<s5hk5xdi0zd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hk5xdi0zd.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 3/19/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 19 Mar 2007 12:31:16 -0400,
> Rich Rattanni wrote:
> >
> > All:
> >
> > I have noticed a strange behaviour in the ALSA driver that seems to be
> > occur after initiating a power standby and resume.  I am working on an
> > application that uses FusionSound to playback OGG audio files.  When
> > the application recognizes it is idle, it tells the OS to enter
> > standby mode.  Upon resuming from standby, the ALSA API call made by
> > fusionsound no longer acts as a blocking read, instead it returns
> > immediately.  I have confirmed this with Denis Oliver Kropp of the
> > DirectFB / FusionSound project.  He suggested that the ALSA driver
> > should be repaired to prevent this problem from occuring.
>
> It's not clear what is happening there.
> Do you have a small testcase?
>
> When the suspend/resume happens, the apps is usually requested to call
> snd_pcm_resume() and/or snd_pcm_prepare() appropriately to reset the
> stream.  Otherwise the PCM status is kept as SUSPENDED.
>
>
> Takashi
>
> >
> > The system specifications are...
> > Linux            -   Openembedded distro linux kernel 2.6.20
> > GCC             -    4.1.1
> > ALSA            -    1.0.13-r1
> > FusionSound - 0.9.26-r0
> >
> > I guess I am looking for confirmation of this behavior with ALSA and
> > any possible suggestions to patch the driver to operate correctly with
> > power management functions under linux.
> >
> > Thanks in advance,
> > Rich
> >
> > -------------------------------------------------------------------------
> > Take Surveys. Earn Cash. Influence the Future of IT
> > Join SourceForge.net's Techsay panel and you'll get the chance to share your
> > opinions on IT & business topics through brief surveys-and earn cash
> > http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> >
>

Takashi:
  I received a reply from Denis Kropp.  Here is the source code of
FusionSound where the problem occurs.


Rich Rattanni schrieb:
>  I have a post going on the alsa developers mailing list addressing
> this issue, they are asking for the specific source code of the
> problem.  Could you tell me where in the code to look for that loop
> that reads the sound device?

It starts in src/core/core_sound.c at line 459:

static void *
sound_thread( DirectThread *thread, void *arg )


The (most likely) non-blocking write is done at line 654:

          fs_device_write( core->device, output, mixed >> 1 );


Which is ending up in drivers/alsa.c at line 255:

static void
device_write( void *device_data, void *samples, unsigned int size )
{
     AlsaDeviceData    *data   = device_data;
     snd_pcm_uframes_t  frames = size;
     snd_pcm_sframes_t  r;
     u8                *src;

     src = samples;
     while (frames) {
          r = snd_pcm_writei( data->handle, src, frames );
          if (r < 0) {
               r = snd_pcm_prepare( data->handle );
               if (r < 0) {
                    D_WARN( "FusionSound/Device/ALSA: snd_pcm_writei()
failed: %s\n",
                            snd_strerror( r ) );
                    break;
               }
               continue;
          }
          frames -= r;
          src += snd_pcm_frames_to_bytes( data->handle, r );
     }
}



I don't know about these APIs, but at least one of snd_pcm_writei()
and snd_pcm_prepare() should block, otherwise the mixer loop has no
sleep...

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
