From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: alsa hw params on SB Pro
Date: Thu, 10 Feb 2005 18:29:07 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0502101823170.13289@denise.shiny.it>
References: <20050208053606.GB8616@dbz.icequake.net> <s5hacqc1gii.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <s5hacqc1gii.wl@alsa2.suse.de>
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
Cc: Ryan Underwood <nemesis-lists@icequake.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Thu, 10 Feb 2005, Takashi Iwai wrote:

> At Mon, 7 Feb 2005 23:36:06 -0600,
> Ryan Underwood wrote:
> >
> > I seem to have the following problem.  On snd-sb8 with a SBPro (which is
> > capable of stereo), the best stereo playback mode is 22KHz - going above
> > 22KHz implies that the output will be only one channel.
> >
> > If I call snd_pcm_hw_params_set_channels_near with argument of 2
> > channels, I get 2 channels as requested.  But then I call
> > snd_pcm_hw_params_set_rate_near with argument of 44100, and have 44100
> > returned.  Thus I end up with a hwparams that the hardware is not
> > capable of.

Are you sure ?  IIRC the sbpro can do 44100Hz stereo. It had a "double
speed" mode that must be activated to go above 22KHz. Well, I don't
rebember exactly because I never programmed one, but I'm quite sure it
can.


--
Giuliano.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
