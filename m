From: BlackEnvil <blackenvil@gmail.com>
Subject: pcm_jack.c jack_client_new() to jack_client_open()
Date: Mon, 1 Nov 2010 16:15:06 +0100
Message-ID: <AANLkTimgCdHbZVUKaYa6pw-SZ3dj_GcRwUFFMVM_w_9W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015177fd0243092920493ff4709
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DA0EA10381C
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 16:15:27 +0100 (CET)
Received: by eyg24 with SMTP id 24so2952695eyg.38
	for <alsa-devel@alsa-project.org>; Mon, 01 Nov 2010 08:15:27 -0700 (PDT)
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

--0015177fd0243092920493ff4709
Content-Type: text/plain; charset=UTF-8

Hi.
pcm_jack.c uses jack_client_new() to open a client session with jack server.

in agreement with jack documentation:
"THIS FUNCTION IS DEPRECATED AND SHOULD NOT BE USED IN NEW JACK
CLIENTS"    http://jackaudio.org/files/docs/html/group__ClientFunctions.html#ga97482adad8116b76635a63f646a2d2f5

This patch simply replace it with jack_client_open(): it's only a
working draft, need to add jack status checking and so other, for
eventually using jack_client_open() capabilities.
Works well with jack2 too.

--0015177fd0243092920493ff4709
Content-Type: text/x-patch; charset=US-ASCII; name="jack_client_open.patch"
Content-Disposition: attachment; filename="jack_client_open.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gfzjszfr0

LS0tIG9yL3BjbV9qYWNrLmMJMjAxMC0wNC0xNiAxMzoxMToxMC4wMDAwMDAwMDAgKzAyMDAKKysr
IHBjbV9qYWNrLmMJMjAxMC0xMS0wMSAxNjoxNTowNS4wMDAwMDAwMDAgKzAxMDAKQEAgLTMxNyw2
ICszMTcsOCBAQAogCWludCBmZFsyXTsKIAlzdGF0aWMgdW5zaWduZWQgaW50IG51bSA9IDA7CiAJ
Y2hhciBqYWNrX2NsaWVudF9uYW1lWzMyXTsKKwlqYWNrX3N0YXR1c190IGphY2tfc3RhdHVzOwor
CWphY2tfb3B0aW9uc190ICBqYWNrX29wdGlvbnMgPSBKYWNrTnVsbE9wdGlvbjsKIAkKIAlhc3Nl
cnQocGNtcCk7CiAJamFjayA9IGNhbGxvYygxLCBzaXplb2YoKmphY2spKTsKQEAgLTM0OCw3ICsz
NTAsNyBAQAogCQkJX19mdW5jX18sIGphY2tfY2xpZW50X25hbWUsIChpbnQpc3RybGVuKGphY2tf
Y2xpZW50X25hbWUpKTsKIAl9CiAKLQlqYWNrLT5jbGllbnQgPSBqYWNrX2NsaWVudF9uZXcoamFj
a19jbGllbnRfbmFtZSk7CisJamFjay0+Y2xpZW50ID0gamFja19jbGllbnRfb3BlbihqYWNrX2Ns
aWVudF9uYW1lLCBqYWNrX29wdGlvbnMsICZqYWNrX3N0YXR1cyk7CiAKIAlpZiAoamFjay0+Y2xp
ZW50ID09IDApIHsKIAkJc25kX3BjbV9qYWNrX2ZyZWUoamFjayk7Cg==
--0015177fd0243092920493ff4709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0015177fd0243092920493ff4709--
