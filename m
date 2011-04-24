From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH] alsa-lib - HDA-Intel.conf - Fix low mic volume
 due to pulseaudio server
Date: Sun, 24 Apr 2011 12:06:46 +0800
Message-ID: <BANLkTikz4ZO2-K61oHko9bb9jLNThchWrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00151747849e30b24604a1a238ae
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A3A601037F2
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Apr 2011 06:06:48 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1093008fxm.38
	for <alsa-devel@alsa-project.org>; Sat, 23 Apr 2011 21:06:46 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--00151747849e30b24604a1a238ae
Content-Type: text/plain; charset=ISO-8859-1

Fix low mic volume due to pulseaudio server use "front" device for playback
and capture since "PCM Playback Volume" softvol control in front device
affect both playback and capture streams

--00151747849e30b24604a1a238ae
Content-Type: application/octet-stream;
	name="0001-alsa-lib-HDA-Intel.conf-Fix-low-mic-volume-due-to-pulseaudio-server.patch"
Content-Disposition: attachment;
	filename="0001-alsa-lib-HDA-Intel.conf-Fix-low-mic-volume-due-to-pulseaudio-server.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gmvgfrup0

RnJvbSA0NWY3OTg0MmQzODA2ZDI4OTQwZTBjMTRjOThkMDRiMDQ0ZGU3NGMyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBTdW4sIDI0IEFwciAyMDExIDExOjU2OjQ0ICswODAwClN1YmplY3Q6IFtQQVRD
SF0gYWxzYS1saWIgLSBIREEtSW50ZWwuY29uZiAtIEZpeCBsb3cgbWljIHZvbHVtZSBkdWUgdG8g
cHVsc2VhdWRpbyB1c2luZyAiZnJvbnQiIGRldmljZSBmb3IgcGxheWJhY2sgYW5kIGNhcHR1cmUK
CgpTaWduZWQtb2ZmLWJ5OiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwuY29t
PgoKZGlmZiAtLWdpdCBhL3NyYy9jb25mL2NhcmRzL0hEQS1JbnRlbC5jb25mIGIvc3JjL2NvbmYv
Y2FyZHMvSERBLUludGVsLmNvbmYKaW5kZXggZjdlZWNiNC4uYmM4MmRiZiAxMDA2NDQKLS0tIGEv
c3JjL2NvbmYvY2FyZHMvSERBLUludGVsLmNvbmYKKysrIGIvc3JjL2NvbmYvY2FyZHMvSERBLUlu
dGVsLmNvbmYKQEAgLTksMTMgKzksMjAgQEAgSERBLUludGVsLnBjbS5mcm9udC4wIHsKIAlAYXJn
cy5DQVJEIHsKIAkJdHlwZSBzdHJpbmcKIAl9Ci0JdHlwZSBzb2Z0dm9sCi0Jc2xhdmUucGNtIHsK
LQkJdHlwZSBodwotCQljYXJkICRDQVJECisJdHlwZSBhc3ltCisJcGxheWJhY2sucGNtIHsKKwkJ
dHlwZSBzb2Z0dm9sCisJCXNsYXZlLnBjbSB7CisJCQl0eXBlIGh3CisJCQljYXJkICRDQVJECisJ
CX0KKwkJY29udHJvbCB7CisJCQluYW1lICJQQ00gUGxheWJhY2sgVm9sdW1lIgorCQkJY2FyZCAk
Q0FSRAorCQl9CiAJfQotCWNvbnRyb2wgewotCQluYW1lICJQQ00gUGxheWJhY2sgVm9sdW1lIgor
CWNhcHR1cmUucGNtIHsKKwkJdHlwZSBodwogCQljYXJkICRDQVJECiAJfQogfQkKLS0gCjEuNi4w
LjYKCg==
--00151747849e30b24604a1a238ae
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--00151747849e30b24604a1a238ae--
