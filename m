From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: ALSA driver problem after standby/resume
Date: Tue, 20 Mar 2007 00:59:26 +0200
Message-ID: <20070319225926.GA9072@sci.fi>
References: <3187bd480703190931t919183ej9a54ff4fc3cba89b@mail.gmail.com>
	<s5hk5xdi0zd.wl%tiwai@suse.de>
	<3187bd480703191230n628ed4fbtd368aa02a70e858c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3187bd480703191230n628ed4fbtd368aa02a70e858c@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Rich Rattanni <rattanni@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 19, 2007 at 03:30:33PM -0400, Rich Rattanni wrote:
> On 3/19/07, Takashi Iwai <tiwai@suse.de> wrote:
> > At Mon, 19 Mar 2007 12:31:16 -0400,
> > Rich Rattanni wrote:
> > >
> > > All:
> > >
> > > I have noticed a strange behaviour in the ALSA driver that seems to be
> > > occur after initiating a power standby and resume.  I am working on an
> > > application that uses FusionSound to playback OGG audio files.  When
> > > the application recognizes it is idle, it tells the OS to enter
> > > standby mode.  Upon resuming from standby, the ALSA API call made by
> > > fusionsound no longer acts as a blocking read, instead it returns
> > > immediately.  I have confirmed this with Denis Oliver Kropp of the
> > > DirectFB / FusionSound project.  He suggested that the ALSA driver
> > > should be repaired to prevent this problem from occuring.
> >
> > It's not clear what is happening there.
> > Do you have a small testcase?
> >
> > When the suspend/resume happens, the apps is usually requested to call
> > snd_pcm_resume() and/or snd_pcm_prepare() appropriately to reset the
> > stream.  Otherwise the PCM status is kept as SUSPENDED.
<snip>
> =

> static void
> device_write( void *device_data, void *samples, unsigned int size )
> {
>      AlsaDeviceData    *data   =3D device_data;
>      snd_pcm_uframes_t  frames =3D size;
>      snd_pcm_sframes_t  r;
>      u8                *src;
> =

>      src =3D samples;
>      while (frames) {
>           r =3D snd_pcm_writei( data->handle, src, frames );

Maybe we just need to add something like this here?

+          if (r =3D=3D -ESTRPIPE) {
+               while ((r =3D snd_pcm_resume( data->handle )) =3D=3D -EAGAI=
N)
+                    sleep( 1 );
+          }

>           if (r < 0) {
>                r =3D snd_pcm_prepare( data->handle );
>                if (r < 0) {
>                     D_WARN( "FusionSound/Device/ALSA: snd_pcm_writei()
> failed: %s\n",
>                             snd_strerror( r ) );
>                     break;
>                }
>                continue;
>           }
>           frames -=3D r;
>           src +=3D snd_pcm_frames_to_bytes( data->handle, r );
>      }
> }

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
