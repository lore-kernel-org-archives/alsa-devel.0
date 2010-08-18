From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: intel8x0: Mute External Amplifier by
 default for ThinkPad X31
Date: Wed, 18 Aug 2010 19:39:17 -0400
Message-ID: <AANLkTikdfP1Z32hX7JTwzmZeFr3vd5PcLV04T+PC=hYt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0022154016faf372b5048e219215
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F6E8103813
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Aug 2010 01:39:18 +0200 (CEST)
Received: by wyb42 with SMTP id 42so1347379wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2010 16:39:17 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

--0022154016faf372b5048e219215
Content-Type: text/plain; charset=UTF-8

Hi,

Please apply the following patch (applicable to all stable linux
releases, too) against current sound-2.6 to make audio audible by
default for this model ThinkPad.

Best,
-Dan

--0022154016faf372b5048e219215
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-intel8x0-Mute-External-Amplifier-by-default-for.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-intel8x0-Mute-External-Amplifier-by-default-for.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gd0tpq3p0

RnJvbSBkM2M1MWIxY2ZkNmZmZGY1NmE0NmYxMDgxZDIwZTBlZGQ2ZDg4OTFjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFdlZCwgMTggQXVnIDIwMTAgMTk6MzM6NDMgLTA0MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBpbnRlbDh4MDogTXV0ZSBFeHRlcm5hbCBBbXBsaWZpZXIgYnkgZGVmYXVsdCBmb3IgVGhpbmtQ
YWQgWDMxCgpCdWdMaW5rOiBodHRwczovL2J1Z3MubGF1bmNocGFkLm5ldC9idWdzLzYxOTQzOQoK
VGhpcyBUaGlua1BhZCBtb2RlbCBuZWVkcyBFeHRlcm5hbCBBbXBsaWZpZXIgbXV0ZWQgZm9yIGF1
ZGlibGUgcGxheWJhY2ssCnNvIHNldCB0aGUgaW52X2VhcGQgcXVpcmsgZm9yIGl0LgoKUmVwb3J0
ZWQtYW5kLXRlc3RlZC1ieTogRGVubmlzIEJlbGwgPGRlbm5pcy5iZWxsQHBhcmtlcmcuY28udWs+
CkNjOiA8c3RhYmxlQGtlcm5lbC5vcmc+ClNpZ25lZC1vZmYtYnk6IERhbmllbCBUIENoZW4gPGNy
aW1zdW5AdWJ1bnR1LmNvbT4KLS0tCiBzb3VuZC9wY2kvaW50ZWw4eDAuYyB8ICAgIDYgKysrKysr
CiAxIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9zb3VuZC9wY2kvaW50ZWw4eDAuYyBiL3NvdW5kL3BjaS9pbnRlbDh4MC5jCmluZGV4
IDY0MzNlNjUuLjQ2Nzc0OTIgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9pbnRlbDh4MC5jCisrKyBi
L3NvdW5kL3BjaS9pbnRlbDh4MC5jCkBAIC0xNzc2LDYgKzE3NzYsMTIgQEAgc3RhdGljIHN0cnVj
dCBhYzk3X3F1aXJrIGFjOTdfcXVpcmtzW10gX19kZXZpbml0ZGF0YSA9IHsKICAgICAgICAgfSwK
IAl7CiAJCS5zdWJ2ZW5kb3IgPSAweDEwMTQsCisJCS5zdWJkZXZpY2UgPSAweDA1MzQsCisJCS5u
YW1lID0gIlRoaW5rUGFkIFgzMSIsCisJCS50eXBlID0gQUM5N19UVU5FX0lOVl9FQVBECisJfSwK
Kwl7CisJCS5zdWJ2ZW5kb3IgPSAweDEwMTQsCiAJCS5zdWJkZXZpY2UgPSAweDFmMDAsCiAJCS5u
YW1lID0gIk1TLTkxMjgiLAogCQkudHlwZSA9IEFDOTdfVFVORV9BTENfSkFDSwotLSAKMS43LjAu
NAoK
--0022154016faf372b5048e219215
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0022154016faf372b5048e219215--
