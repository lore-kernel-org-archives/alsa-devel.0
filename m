From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Tascam US-224 progress report (was: USB224_usbsnoop1.log captured
 on WinXP)
Date: Sat, 3 Apr 2004 02:24:16 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32789.192.168.1.5.1080955456.squirrel@www.rncbc.org>
References: <200404021434.26528.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20040403022416_13406"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200404021434.26528.annabellesgarden@yahoo.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_20040403022416_13406
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

I have news, and they're good this time.

After some juggling and persistance around compiling and patching the
snd-usb-usx2y module, I've finally got that dreaded INPUT MONITOR LED come
to light and, as Karsten rightly predicted, playback has shown its ugly
head on my Tascam US-224. Hip, hip, hurray!

Like a miracle, the MUTE and SELECT LED lights of the mixer strips 1-4 are
lightning up too. Again, Karsten tips are quite cirurgical :)

However, I don't get the SOLO, REC, NULL, nor all other transport LEDs to
lit. But that's yet another step, I think the next.

We're getting near and I'm quite happier now.

Karsten Wiese wrote:
>
> So please try the following patch:
>>>>
> --- alsa-driver/usb/usx2y/usbusx2yaudio.c	30 Mar 2004 08:27:16 -0000	1.9
> +++ alsa-driver/usb/usx2y/usbusx2yaudio.c	2 Apr 2004 11:55:21 -0000
> @@ -1245,7 +1245,7 @@
>  	    					     snd_dma_continuous_data(GFP_KERNEL),
>  						     usX2Y_capt_substream->endpoints * 64*1024,
>  						     usX2Y_capt_substream->endpoints * 128*1024)) ||
> -	    (usX2Y(card)->chip.dev->descriptor.idProduct == USB_ID_US428 &&
> +	    (usX2Y(card)->chip.dev->descriptor.idProduct != USB_ID_US122 &&
>  	     0 > (err = usX2Y_rate_set(usX2Y_stream, 44100)))) {	// Lets us428
> recognize output-volume settings, disturbs us122.
>  		snd_usX2Y_audio_stream_free(usX2Y_stream);
>  		return err;
> <<<
>
> if the us428 doesn't get the "usX2Y_rate_set(usX2Y_stream, 44100)" at
> startup, it later behaves ignorant to light & volume setting. like
> us224 behaves now.
>

That was it. Although I only got it working after one last
alsa-driver-1.0.3 rebuild and when set --with-debug=full on ./configure.
Kind of strange. My literal patch applied to stock alsa-driver-1.0.3 is on
attachment. It is just the same of Karsten's supplied above, just for
reference.

> If we get the INPUT MONITOR Led enlightened, the Volume settings should
> also work with respect to direct monitoring at least. US224 Master Fader
> seams to b where US428's Fader5 is. That needs adjustment in
> s428control.
>
> The data sent to set us224 internal mixers is filtered out with
> 	grep -n "00: 0[0123456789] .. .. .. ..$" USB224_usbsnoop1.log
> it gives i. e.:
> 	11721:    00000000: 00 00 25 00 25
> 	11732:    00000000: 01 00 25 00 25
> 	11743:    00000000: 02 00 25 00 25
> 	11754:    00000000: 03 00 25 00 25
> 	11831:    00000000: 04 00 42 00 42
>
> look at struct usX2Y_volume and its methods. it should fit the us224.
> But lets get that Leds enlighted first :-)
>

The master fader works, at least while on playback. I don't seem to get
fader strips 1-4 to have any audible effect. But now's too early to judge
my experiments.

Other issues are now just emerging... rest assured ;)

Thanks a lot Karsten, your help and advice is priceless.

CU
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
------=_20040403022416_13406
Content-Type: application/x-gzip; name="alsa-driver-1.0.3p2.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="alsa-driver-1.0.3p2.patch.gz"

H4sICKMFbkAAA2Fsc2EtZHJpdmVyLTEuMC4zcDIucGF0Y2gAlVJtb9MwEP7c/IpjH6Z2qVPHyUYX
1KqjKwixVVWzIhAgK43dYpEmke2Ut/HfuSQFDcE+9BRHl9zd89w9PqE2GyCiWsw1JJlJiNBqLzXx
PeoFJR1UZo3nK/tWe42TVEIVXvqfbPZ4tkMIOQ6/wygNCfWJfwn+MAqDiA09+tvArd+O67rH9XFA
xScA6kfsIjq/9ILAp/RpyEJERc+ZTID4LKR9PwC3dc5hMnGgA2gUxtCVWsMITC54me54pta81DLJ
siJNrORlspWmixEyNhb/78z7eH69fMMX01se3y1nV7d8erW4Wy1nHz1TrdukPhK0Vpm37B1Pk9Ly
P1EylrkoC5VbA2dwEZ75lIXHlPhs2NbAyxcL/nq2nM9uej24v3dIM1e3geimiRY9Mk4/qdITck/G
QppUq9IW2lNioQtRpRZGI1jFz/mra76KQzaE01PHPR7lyQMUn7EapdX4ocjtZLrW1Ujb4vODYhCG
eGE9NPjRGQzgRuKolak70jIttrn6LqGobFlZsi+yaicBMazKt6YPQhlb6XVdgOReLWV9oS1Bsy8H
Gr7RUv5F3HtWZ2uJ9Tlgm/XnTzz/Dl+vBwpgXBdzUKNmZTReyefuySNsufwSQRtb82Z5QeXKRhCv
ptNZHHsf8hNswEW+QwcUsZHe+QXQn+hhzQMAAA==
------=_20040403022416_13406--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
