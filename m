From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Oops in snd_emu10k1_efx_playback_prepare
Date: Thu, 10 Mar 2005 16:35:45 -0500
Message-ID: <1110490545.14297.9.camel@mindpipe>
References: <1110347780.7123.21.camel@mindpipe>
	 <s5hbr9t5efx.wl@alsa2.suse.de> <s5h8y4x5btl.wl@alsa2.suse.de>
	 <s5his40wx9t.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5his40wx9t.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-03-09 at 18:21 +0100, Takashi Iwai wrote:
> At Wed, 09 Mar 2005 11:54:30 +0100,
> I wrote:
> > 
> > At Wed, 09 Mar 2005 10:57:54 +0100,
> > I wrote:
> > > 
> > > At Wed, 09 Mar 2005 00:56:19 -0500,
> > > Lee Revell wrote:
> > > > 
> > > > I got an Oops again that seems to be caused by something in mu
> > > > multichannel patch.  But, I don't really know what to make of it.
> > > > 
> > > > ksymoops seems broken for 2.6 kernels, but it was able to disassemble
> > > > the offending code.
> > > > 
> > > > Any ideas?
> > > 
> > > In snd_emu10k1_pcm_channel_alloc(), epcm->voices[2..NUM_EFX_PLAYBACK]
> > > are not freed correctly.  Possibly did this hit?
> > 
> > Or maybe I misread the code.  Need more coffee now... :)
> > 
> > Anyway, snd_emu10k1_pcm_channel_alloc() should return immediately at
> > the second or later call when all voices have been already allocated.
> 
> The quick fix patch is below.
> But I'm not sure whether this is really related with the given bug.
> 

Thanks, I'll try this.  Unfortunately the bug is very hard to hit (I
have only triggered it twice) and I have no idea how to reproduce it.
It's somwhow associated with restarting JACK.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
