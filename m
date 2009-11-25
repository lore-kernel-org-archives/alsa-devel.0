From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: intel8x0: Mute External Amplifier by
	default for Gateway 4525GZ
Date: Tue, 24 Nov 2009 22:55:46 -0500
Message-ID: <604760770911241955l704c0a0al5682efb894ac47b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636e0b9659e4b0904792a0880
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f179.google.com (mail-pz0-f179.google.com
	[209.85.222.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FFF42434F
	for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2009 04:55:48 +0100 (CET)
Received: by pzk9 with SMTP id 9so473580pzk.16
	for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2009 19:55:47 -0800 (PST)
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--001636e0b9659e4b0904792a0880
Content-Type: text/plain; charset=UTF-8

Hi,

Attached please find a patch against current sound-2.6 HEAD setting
the inv_eapd quirk for the Gateway 4525GZ.

Thanks,
Dan

--001636e0b9659e4b0904792a0880
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ALSA-intel8x0-Mute-External-Amplifier-by-default-for.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-intel8x0-Mute-External-Amplifier-by-default-for.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g2fkaved0

RnJvbSBkMmRkZDIwZWM2ZTI3MjRiMDZjMmNhYzYyMGI0YmFmN2I2NDk2ZGU0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFR1ZSwgMjQgTm92IDIwMDkgMjI6NTE6MDUgLTA1MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBpbnRlbDh4MDogTXV0ZSBFeHRlcm5hbCBBbXBsaWZpZXIgYnkgZGVmYXVsdCBmb3IgR2F0ZXdh
eSA0NTI1R1oKCkJ1Z0xpbms6IGh0dHBzOi8vYnVncy5sYXVuY2hwYWQubmV0L2J1Z3MvNDg3ODg0
CgpUaGlzIEdhdGV3YXkgbW9kZWwgbmVlZHMgRXh0ZXJuYWwgQW1wbGlmaWVyIG11dGVkIGZvciBh
dWRpYmxlIHBsYXliYWNrLApzbyBzZXQgdGhlIGludl9lYXBkIHF1aXJrIGZvciBpdC4KClNpZ25l
ZC1vZmYtYnk6IERhbmllbCBUIENoZW4gPGNyaW1zdW5AdWJ1bnR1LmNvbT4KLS0tCiBzb3VuZC9w
Y2kvaW50ZWw4eDAuYyB8ICAgIDYgKysrKysrCiAxIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9u
cygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaW50ZWw4eDAuYyBi
L3NvdW5kL3BjaS9pbnRlbDh4MC5jCmluZGV4IGFhYzIwZmIuLmI5OTAxNDMgMTAwNjQ0Ci0tLSBh
L3NvdW5kL3BjaS9pbnRlbDh4MC5jCisrKyBiL3NvdW5kL3BjaS9pbnRlbDh4MC5jCkBAIC0yMDYz
LDYgKzIwNjMsMTIgQEAgc3RhdGljIHN0cnVjdCBhYzk3X3F1aXJrIGFjOTdfcXVpcmtzW10gX19k
ZXZpbml0ZGF0YSA9IHsKIAkJLnR5cGUgPSBBQzk3X1RVTkVfSFBfT05MWQogCX0sCiAJeworCQku
c3VidmVuZG9yID0gMHgxNjFmLAorCQkuc3ViZGV2aWNlID0gMHgyMDNhLAorCQkubmFtZSA9ICJH
YXRld2F5IDQ1MjVHWiIsCQkvKiBBRDE5ODFCICovCisJCS50eXBlID0gQUM5N19UVU5FX0lOVl9F
QVBECisJfSwKKwl7CiAJCS5zdWJ2ZW5kb3IgPSAweDE3MzQsCiAJCS5zdWJkZXZpY2UgPSAweDAw
ODgsCiAJCS5uYW1lID0gIkZ1aml0c3UtU2llbWVucyBEMTUyMiIsCS8qIEFEMTk4MSAqLwotLSAK
MS42LjMuMwoK
--001636e0b9659e4b0904792a0880
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636e0b9659e4b0904792a0880--
