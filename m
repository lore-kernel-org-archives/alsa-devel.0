From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH] ALSA ymfpci - Add "Playback" to FM Legacy
	Volume control
Date: Fri, 9 Sep 2011 19:25:46 +0800
Message-ID: <CAN8cciZ=vOBPK-EFKpX8f7tsUYqPZ5bZk1F_4nYYoDf_yGia-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00151744841844496104ac8070d6
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8791B1037FC
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Sep 2011 13:25:46 +0200 (CEST)
Received: by fxe22 with SMTP id 22so193109fxe.38
	for <alsa-devel@alsa-project.org>; Fri, 09 Sep 2011 04:25:46 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--00151744841844496104ac8070d6
Content-Type: text/plain; charset=ISO-8859-1

Add "Playback" to "FM Legacy Volume" control since

- YDSXGR_LEGACYOUTVOL is a Playback Volume control for OPL3 FM Synth

--00151744841844496104ac8070d6
Content-Type: application/octet-stream;
	name="0001-ALSA-ymfpci-Add-Playback-to-FM-Legacy-Volume-cont.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-ymfpci-Add-Playback-to-FM-Legacy-Volume-cont.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gsd2um020

RnJvbSBhNTIzZWJlZjcxYjBhMGE2ZTRiYzJlMDdmZmQ2MTZlOGM2NTEwNzE3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBGcmksIDkgU2VwIDIwMTEgMTk6MTU6MDEgKzA4MDAKU3ViamVjdDogW1BBVENI
XSBBTFNBIHltZnBjaSAtIEFkZCAiUGxheWJhY2siIHRvIEZNIExlZ2FjeSBWb2x1bWUgY29udHJv
bAoKWURTWEdSX0xFR0FDWU9VVFZPTCBpcyBhIFBsYXliYWNrIFZvbHVtZSBjb250cm9sIGZvciBP
UEwzIEZNIFN5bnRoCgpTaWduZWQtb2ZmLWJ5OiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRl
eDJAZ21haWwuY29tPgoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS95bWZwY2kveW1mcGNpX21haW4u
YyBiL3NvdW5kL3BjaS95bWZwY2kveW1mcGNpX21haW4uYwppbmRleCBmMzI2MGU2Li5lYmZiYjI4
IDEwMDY0NAotLS0gYS9zb3VuZC9wY2kveW1mcGNpL3ltZnBjaV9tYWluLmMKKysrIGIvc291bmQv
cGNpL3ltZnBjaS95bWZwY2lfbWFpbi5jCkBAIC0xNjE1LDcgKzE2MTUsNyBAQCBZTUZQQ0lfRE9V
QkxFKCJBREMgUGxheWJhY2sgVm9sdW1lIiwgMCwgWURTWEdSX1BSSUFEQ09VVFZPTCksCiBZTUZQ
Q0lfRE9VQkxFKCJBREMgQ2FwdHVyZSBWb2x1bWUiLCAwLCBZRFNYR1JfUFJJQURDTE9PUFZPTCks
CiBZTUZQQ0lfRE9VQkxFKCJBREMgUGxheWJhY2sgVm9sdW1lIiwgMSwgWURTWEdSX1NFQ0FEQ09V
VFZPTCksCiBZTUZQQ0lfRE9VQkxFKCJBREMgQ2FwdHVyZSBWb2x1bWUiLCAxLCBZRFNYR1JfU0VD
QURDTE9PUFZPTCksCi1ZTUZQQ0lfRE9VQkxFKCJGTSBMZWdhY3kgVm9sdW1lIiwgMCwgWURTWEdS
X0xFR0FDWU9VVFZPTCksCitZTUZQQ0lfRE9VQkxFKCJGTSBMZWdhY3kgUGxheWJhY2sgVm9sdW1l
IiwgMCwgWURTWEdSX0xFR0FDWU9VVFZPTCksCiBZTUZQQ0lfRE9VQkxFKFNORFJWX0NUTF9OQU1F
X0lFQzk1OCgiQUM5NyAiLCBQTEFZQkFDSyxWT0xVTUUpLCAwLCBZRFNYR1JfWlZPVVRWT0wpLAog
WU1GUENJX0RPVUJMRShTTkRSVl9DVExfTkFNRV9JRUM5NTgoIiIsIENBUFRVUkUsVk9MVU1FKSwg
MCwgWURTWEdSX1pWTE9PUFZPTCksCiBZTUZQQ0lfRE9VQkxFKFNORFJWX0NUTF9OQU1FX0lFQzk1
OCgiQUM5NyAiLFBMQVlCQUNLLFZPTFVNRSksIDEsIFlEU1hHUl9TUERJRk9VVFZPTCksCi0tIAox
LjYuMC42Cgo=
--00151744841844496104ac8070d6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--00151744841844496104ac8070d6--
