From: Krivenok Dmitry <_asr_@inbox.ru>
Subject: Re: =?koi8-r?b?VmlydHVhbCBzb3VuZCBjYXJk?=
Date: Thu, 03 Aug 2006 19:45:06 +0400
Message-ID: <E1G8fNi-000OkH-00._asr_-inbox-ru@f52.mail.ru>
References: <s5hvep9g7sr.wl%tiwai=40suse.de>
Reply-To: Krivenok Dmitry <_asr_@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: =?koi8-r?Q?<s5hvep9g7sr.wl%tiwai=40suse.de>?=
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



-----Original Message-----
From: Takashi Iwai <tiwai@suse.de>
To: Krivenok Dmitry <_asr_@inbox.ru>
Date: Thu, 03 Aug 2006 17:25:56 +0200
Subject: Re: Re[10]: [Alsa-devel] Virtual sound card

> 
> At Thu, 03 Aug 2006 19:22:57 +0400,
> Krivenok Dmitry wrote:
> > 
> > 
> > 
> > -----Original Message-----
> > From: Takashi Iwai <tiwai@suse.de>
> > To: Krivenok Dmitry <_asr_@inbox.ru>
> > Date: Thu, 03 Aug 2006 16:41:46 +0200
> > Subject: Re: Re[8]: [Alsa-devel] Virtual sound card
> > 
> > > 
> > > At Thu, 03 Aug 2006 18:36:32 +0400,
> > > Krivenok Dmitry wrote:
> > > > 
> > > > > > This is mplayer's log:
> > > > > > krivenok-home ~ # strace mplayer Uno_momento.mp3  2>log2
> > > > > > krivenok-home ~ # grep  snd log2
> > > > > > open("/dev/snd/controlC0", O_RDWR)      = 5
> > > > > > open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK) = 6
> > > > > > 
> > > > > > OK :)
> > > > > > 
> > > > > > P.S.
> > > > > > Is there a way to use separate files for in/out?
> > > > > 
> > > > > You can define different PCMs for playback and capture and bind them
> > > > > using asym plugin, such as:
> > > > > 
> > > > > pcm.!hw {
> > > > > 	type asym
> > > > > 	playback.pcm {
> > > > > 		type file
> > > > > 		slave.pcm {
> > > > > 			type hw
> > > > > 			card 0
> > > > > 		}
> > > > > 		file "foo.out"
> > > > > 	}
> > > > > 	capture.pcm {
> > > > > 		type file
> > > > > 		slave.pcm {
> > > > > 			type hw
> > > > > 			card 0
> > > > > 		}
> > > > > 		file "foo.in"
> > > > > 	}
> > > > > }
> > > > > 
> > > > 
> > > > It works with skype and mplayer, but aplay crashs (SegFault):
> > > 
> > > Ouch.  Could you get a backtrace via gdb?
> > > 
> > 
> > aplay.c:921 snd_pcm_name(handle) == NULL, hence SegFault :(
> 
> Yep, try the patch below.
> 

It works!
Thanks!

> 
> Takashi
> 
> diff -r 821d98a655de aplay/aplay.c
> --- a/aplay/aplay.c	Thu Jul 27 11:02:00 2006 +0200
> +++ b/aplay/aplay.c	Thu Aug 03 17:21:25 2006 +0200
> @@ -918,8 +918,9 @@ static void set_params(void)
>  	if ((float)rate * 1.05 < hwparams.rate || (float)rate * 0.95 > hwparams.rate) {
>  		if (!quiet_mode) {
>  			char plugex[64];
> +			const char *pcmname = snd_pcm_name(handle);
>  			fprintf(stderr, _("Warning: rate is not accurate (requested = %iHz, got = %iHz)\n"), rate, hwparams.rate);
> -			if (strchr(snd_pcm_name(handle), ':'))
> +			if (! pcmname || strchr(snd_pcm_name(handle), ':'))
>  				*plugex = 0;
>  			else
>  				snprintf(plugex, sizeof(plugex), "(-Dplug:%s)",
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
