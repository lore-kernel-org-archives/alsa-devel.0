From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: aplay: pcm_write:1025: write error &	SNDRV_PCM_IOCTL_PREPAREfailed:device or resource busy
Date: Mon, 2 Jun 2003 07:33:47 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGCELMCFAB.mknecht@controlnet.com>
References: <s5hznl0o8u1.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hznl0o8u1.wl@alsa2.suse.de>
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

>
> just add the following line to the end of /etc/modules.conf:
>
> 	options snd-via82xx dxs_support=2
>
> (or dxs_support=3)
>
> and run "/etc/init.d/alsasound restart".
>
> note that the option above is available only on the very recent ALSA
> version.
>
>
> ciao,
>
> Takashi

Thanks. That's very clear. I'll try it this evening. (At work right now.)

As for Alsa versions, this is a Gentoo ebuild of Alsa. It identifies itself
as '0.9.3c-r1'. (Is that right? I might have thought 0.9.3-rc1?) Anyway,
that's what it says. New enough for these options?

Thanks much!

Mark




-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
