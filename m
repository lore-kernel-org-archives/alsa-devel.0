From: Kaspar Bumke <kaspar.bumke@gmail.com>
Subject: usage of snd_seq_set_client_event_filter
Date: Sun, 8 Jul 2012 20:41:42 +0100
Message-ID: <CAB+dmjiXDs7u20T8HJJZAv47o-61kZStL2+=ZX5zLjBsH7VPdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf303bfc8807a4e004c456b107
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gg0-f179.google.com (mail-gg0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A02424699
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Jul 2012 21:42:03 +0200 (CEST)
Received: by ggnk3 with SMTP id k3so9254308ggn.38
	for <alsa-devel@alsa-project.org>; Sun, 08 Jul 2012 12:42:03 -0700 (PDT)
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

--20cf303bfc8807a4e004c456b107
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

I was trying to use snd_seq_set_client_event_filter in my application but I
can't seem to get it to work correctly.

I have attached a small test program which can be compiled with "g++ -o
test test.cpp -lasound".  My alsa-lib is at 1.0.25. It should simple print
the note number for any noteOn events.

I was under the impression that the way I have used it only noteOn events
would get through but it seems that only the first noteOn event I send it
gets through. I have been sending events using VMPK.

If I remove snd_seq_set_client_event_filter everything seems to work
(except the events aren't filtered of course).

What am I doing wrong?

All the Best,

Kaspar

--20cf303bfc8807a4e004c456b107
Content-Type: text/x-c++src; charset=US-ASCII; name="test.cpp"
Content-Disposition: attachment; filename="test.cpp"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h4eiw1tx0

I2luY2x1ZGUgPGFsc2EvYXNvdW5kbGliLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUg
PGlvc3RyZWFtPgp1c2luZyBuYW1lc3BhY2Ugc3RkOwoKc25kX3NlcV90ICogaGFuZGxlOwoKaW50
IG1haW4oKSAKewoJc25kX3NlcV9vcGVuKCZoYW5kbGUsICJkZWZhdWx0IiwgU05EX1NFUV9PUEVO
X0lOUFVULCAwKTsKCXNuZF9zZXFfc2V0X2NsaWVudF9uYW1lKGhhbmRsZSwgInRlc3QiKTsKCgkv
L3NuZF9zZXFfc2V0X2NsaWVudF9ldmVudF9maWx0ZXIoaGFuZGxlLCBTTkRfU0VRX0VWRU5UX05P
VEVPTik7CgoJc25kX3NlcV9jcmVhdGVfc2ltcGxlX3BvcnQoaGFuZGxlLCAiaW4iLCBTTkRfU0VR
X1BPUlRfQ0FQX1dSSVRFIHwgU05EX1NFUV9QT1JUX0NBUF9TVUJTX1dSSVRFLCBTTkRfU0VRX1BP
UlRfVFlQRV9BUFBMSUNBVElPTik7IAoJd2hpbGUgKDEpIHsKCQkvL3NsZWVwKDEpOwoJCXNuZF9z
ZXFfZXZlbnRfdCAqIGV2ZW50OwoJCWlmKHNuZF9zZXFfZXZlbnRfaW5wdXQoaGFuZGxlLCAmZXZl
bnQpID49IDApCgkJCWNvdXQgPDwgKGludCkoKmV2ZW50KS5kYXRhLm5vdGUubm90ZSA8PCBlbmRs
OwoJfQoKfQo=
--20cf303bfc8807a4e004c456b107
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--20cf303bfc8807a4e004c456b107--
