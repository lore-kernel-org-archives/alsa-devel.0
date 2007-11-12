From: "Giovanni Maruzzelli" <gmaruzz.lists@gmail.com>
Subject: No sound from usb on Motorola C350 cellphone
Date: Mon, 12 Nov 2007 14:34:54 +0100
Message-ID: <7c5010d60711120534l13376fc9gc71228ca84322ddc@mail.gmail.com>
References: <7c5010d60711120528u16bef715ua48f440c49d962d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_8954_11884866.1194874494770"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by alsa0.perex.cz (Postfix) with ESMTP id BBDB0245FC
	for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2007 14:34:55 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id b15so192172ana
	for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2007 05:34:54 -0800 (PST)
In-Reply-To: <7c5010d60711120528u16bef715ua48f440c49d962d1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_Part_8954_11884866.1194874494770
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi list participants,

I am using cellphones connected to soundcards as cheap gsm gateways
(more complex than that, actually. You can see the whole GPL project
at www.celliax.org).

Maybe there is a way to not using soundcards, that would be *so* much
better: I found that Motorola c350 phones after receiving an AT+MODE=8
command via USB, make available an usb sound device.

That would be wonderful (less cables, more robustness, etc). Problem
is: the usb sound device do not plays or captures samples.

I suspect that the usb audio has to be activated, maybe by an AT or a
P2K command.

Or that a quirk has to be added to the alsa driver (snd_usb_audio).

Do you know anything about (maybe the quirk to be added to ALSA driver...)?

Do you have any hint?

I'm available to do all the research-testing-debugging that may be useful.

What happens is as follow:
1) attach the c350 to usb
2) is recognized as acm0
3) send at+mode=8 to c350 (via minicom, for eg)
4) it changes its usbid, disconnect from usb, reconnect, is recognized
as acm1, makes available a sound device
5) at commands work on the new acm1
6) trying to use the audio device directly (eg aplay -Dhw:1) do not
give errors on play (but no sound is head on the phone), gives error
pcm_read 1349 on record (eg arecord -Dhw:1)
7) trying to use the audiodevice through alsalib does not gives errors
at all (eg -Dplughw:1) but does not caputeres samples, and no sound is
heard on the phone


In the tgz archive attached you can find the following files:

lusb_without -> result of lusb -vv with no device attached

lsusb_with_ACM0 -> result of lusb -vv with c350 just attached,
recognized as acm modem

lsusb_with_ACM1 -> result of lusb -vv with c350 after sending
at+mode=8 to him, he has disconnected and was recognized again, this
time as ACM1, with a lot of additional usb interfaces

dmesg-acm0 -> result of dmesg after first c350 attachment

dmesg-acm1 -> result of dmesg after at+mode=8 was sent to the c350

aplay-l -> result of aplay -l showing the c350 as an alsa device

stream0_pstop_cstop -> result of cat /proc/asound/C350/stream0 while not active

stream0_pstop_crun -> result of cat /proc/asound/C350/stream0 while
arecord -vv -Dplughw:1 -fS16_LE ciapa.raw (if using -Dhw:1 it fails
with error: "pcm_read:1349: read error: Input/output error"). arecord
does not gives errors, but do not write samples

stream0_prun_crun -> result of cat /proc/asound/C350/stream0 while
aplay and arecord -vv -Dplughw:1 -fS16_LE ciapa.raw (if using -Dhw:1
arecord fails with error: "pcm_read:1349: read error: Input/output
error", aplay works but no audio) arecord does not gives errors, but
do not write samples

aplay_play -> results of aplay

arecord_rec -> results of arecord

Thank you all in advance,

Giovanni Maruzzelli

------=_Part_8954_11884866.1194874494770
Content-Type: application/x-gzip; name=c350_usb_sound.tgz
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f8x3hrtp0
Content-Disposition: attachment; filename=c350_usb_sound.tgz

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
voH+ElLysvZAqul8cHoJujJmUI0AoeFFqcr/7+jTr5LWxX9as5H5/2ZDl/4f47+XIRjiepPWGZtz
m9Kx2UGymPup7Mr0plan+i48o55mJ/HnSZ4xTt1a5RnpMs+oN3VAi9a/84yBax2D8LEh90m/AVe1
bP43Ej92WMaa8c8Ypdn3v5ku4z+VaTj+X4L6TnQrjuy208POMO4EyItBB4/J0YA2RhdnH2vnYUAC
HkYzYssVokBuN09WrNqkf9H5+0un+3/AMeRuyIxz9dfo/HJ4dnVx1vnz7BT4N3IveMa/Fq9lYHKY
P26TwVAImsUN4G25BgzuIF9ZbKf7r/mjCDcSXvyUHImfn6lYiZsG43wLbVtuuBlHNzfcHwVy+bFN
tDifGfdtz8qe0tJT+QFR8ZTp8fPQNu+Sp4U8QrCn6Wwkwhvx9PL75Vkh55DP0qYEDucgZ7txcpHW
uDdsJ3+UlP8oamo49q1bfCrMNhyFE3CjE8+xCjUIQm9WZBQ4tsNdk+fMuNj0sWx3/GgsvIHh/0pU
xpSTJtVF7FqTX3hpk2+Gbz0YPpdGEi8ikN+WLh/8lq0eFJYAlKfbU6/X6a+2qNhkX9iq5PFtNKun
mtUbgNKDpDn8j0ehMprJ3jbFz+3LWLf+owLmp+u/TKeA/02mIP6/CJU+/rf8A3/iQ4gi5i1uzTtm
n4rBfmFduFbrQ/Q4Nsw74dXTl0EDMKRa8dVz/MK444SAAcnb3fiMWFt8+FD+nZ7/aif89PVnOz7s
BKHJ35fd+E3bFTjpIHPcFaWwuVKo/izFqPPFaNsUU+saM7EnY6Uy1W2UKS7n2qSR6la6fFIp/1qV
q0rZ90h7nbTa//uRu4My1vl/Xdcy/99UxPpPE2aC6P9fgtD/H57/v4pcNz18n1fi97Lv/D0p5/rq
SwB/tMgPmKGV//sZ71KRG3GI3Inze3oLVc8THxIVkfqNz/8r0ovZz7d/yJHy2KoLS/iICPQWEKjK
/4Pn35X7X+v/m3q2/q8qDJ7TRkPT0f+/BL2Q/69yWdoal9Wa+2+HLgsRCBEIEWjO/zuB+P3BDide
FO7Kx6z2/0wB35+9/9WYJvy/eIT+/wUoOWSj7feQDYu/7/qMh2wouBf31uFkKG7JOYTzNXyT8zVn
W5yvEWcP8HwNnq/JtYfna972+RpNnq/RNrsSg7JnPV8jnOKzn6+BXhiScCKu4ZNvVFvk64CI17a1
irM3VDnMszcpS61madUsvZrVeIZzPknMoeLB3mwwvKbA49kP9jIMPJIOxMADA4/3EHjgwV5J7/Vg
L97k9b4BH2/ySjsQAR8BHwEfAf99AD5e3fVOAR+v7ko7EAEfAR8BHwH/jQP+vrcxID2R5s9/+2C0
vjWCf3ZXxpr9n0xV8vPfqtYQ57813P/5MnQl+1s4wL86f56R30zbmBl133j4TWzqdAP71gUsbYmX
pp/kVrJ0H94n0vNcr7ar8+PdTn94fSXOtOLx8T2d85W5voWz45W2hEfH35xJYeSxHVXu/x2JG8V2
U8aa/b8N1szO/8H/VO7/Zbj/90UI9/++1kU63P+Li3QZHxfpcJFOEO7/xf2/2+7/jYNv3PmL7wVx
5y+GHBhyYMhRJnwviO8Fn2/nryYBn7Fxq622lML33fvdAemqqvK502wp5I9BL14J3n88wOSniyPX
NmO4WhkarAwKqsMA+VZhaRggNFVSUlVIILW5TIEVUYLo6BVRAiWlq0FWhgRL1+5XxASxJl5THNBo
rowD2BZxQOET7yU7KnyGuyJGMCtjhIp4gL3leGDJMCyLl0cjy79DcSS/NfFxTZBASWd4bMYfKQ/I
0X2d6SCXpqqKFfSq3s3kkwy6p13yjRsWL4YQpiUel4nG4zJN0zUgcoExCiAsLkQpJJ52jZkxth07
tDOzAe9cDAhMkXiaJS5wIGqSAD5fTdH/xceL/SMqde1CEwtVAfAB+YVESi4hX/0t5kpJIddOt7e+
eazQCMd2xfdm5etr8VWBIHY3AcBV2p69hXAnMoQ7OfwQjioyhKONDZeNlL15oMyDPNEDsYX8Sx4I
FCGstKCzraclq50LqDxzLqLUBZ+yL+NW0vnJ9+vhWutmm1j3l8i5e+WGnZnP3lwKk1pnm7iUN6T0
qjkInZ+D4CnD9724iKcM0w7ExUVcXMTFRVxcfJ2Li2qiBi7XCEnyiTk8dJj0D+I/HjokiP8JH/G/
RIj/iP+Hjv946BAJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJaUv6fz/Rgw4A
GAEA
------=_Part_8954_11884866.1194874494770
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_8954_11884866.1194874494770--
