From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: aplay: pcm_write:1025: write error &	SNDRV_PCM_IOCTL_PREPAREfailed:device or resource busy
Date: Mon, 2 Jun 2003 07:59:41 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGCEMBCFAB.mknecht@controlnet.com>
References: <s5hvfvoo7rl.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hvfvoo7rl.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> >
> > aplay hw:1 sound.wav???
>
> please use -D option, for example,
>
> 	% aplay -D hw:0,1 sound.wav
>
> for the second pcm device.  the first 0 means the first "card" and you
> cannot ommit it to specify the pcm device number.
>

Thanks. This explanation makes sense. I'll try it out this evening and get
back to you then.

Cheers,
Mark




-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
