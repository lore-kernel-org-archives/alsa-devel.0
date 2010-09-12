From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] alsactl init: Add db entry for Compaq nx6110
	quirk
Date: Sat, 11 Sep 2010 22:13:40 -0400
Message-ID: <AANLkTi=Vq5b_hOSgYC7U4VuhYPyUSE36H9NEsHPMSDjT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e65b5ee0402a480490068740
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 8CF97245B1
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Sep 2010 04:13:40 +0200 (CEST)
Received: by wyb32 with SMTP id 32so4549329wyb.38
	for <alsa-devel@alsa-project.org>; Sat, 11 Sep 2010 19:13:40 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--0016e65b5ee0402a480490068740
Content-Type: text/plain; charset=UTF-8

Hi,

Attached please find a patch for alsa-utils that adds a necessary
control quirk for the Compaq nx6110 (the 'Headphone Jack Sense'
control needs to be unmuted).

Thanks,
Dan

--0016e65b5ee0402a480490068740
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-alsactl-init-Add-db-entry-for-Compaq-nx6110-quirk.patch"
Content-Disposition: attachment;
	filename="0001-alsactl-init-Add-db-entry-for-Compaq-nx6110-quirk.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gdz9qglr0

RnJvbSBmNmZkNDRjZjVjZWNhOTU5MTVjYmVhZGM1NTFjMjJlMzgyZGU3NTk3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFNhdCwgMTEgU2VwIDIwMTAgMjI6MDI6MjggLTA0MDAKU3ViamVjdDogW1BBVENIXSBhbHNh
Y3RsIGluaXQ6IEFkZCBkYiBlbnRyeSBmb3IgQ29tcGFxIG54NjExMCBxdWlyawoKQnVnTGluazog
aHR0cHM6Ly9sYXVuY2hwYWQubmV0L2J1Z3MvNTg1Nzc3CgpUaGUgcmVwb3J0ZXIgaGFzIHZlcmlm
aWVkIHRoYXQgJ0hlYWRwaG9uZSBKYWNrIFNlbnNlJyBzaG91bGQgYmUgdW5tdXRlZApzbyB0aGF0
IGF1ZGlvIGlzIGF1ZGlibGUgYnkgZGVmYXVsdC4gIFRvIGRvIHNvLCBJJ3ZlIGFkZGVkIGEgc2Vw
YXJhdGUKZmlsZSBmb3IgdGhlIElDSDQvNS82IGNvbmZpZ3VyYXRpb24uCgpSZXBvcnRlZC1hbmQt
VGVzdGVkLWJ5OiBBbnRvbmlvClNpZ25lZC1vZmYtYnk6IERhbmllbCBUIENoZW4gPGNyaW1zdW5A
dWJ1bnR1LmNvbT4KLS0tCiBhbHNhY3RsL2luaXQvMDBtYWluICAgICAgfCAgICAxICsKIGFsc2Fj
dGwvaW5pdC9NYWtlZmlsZS5hbSB8ICAgIDIgKy0KIGFsc2FjdGwvaW5pdC9pY2g0ICAgICAgICB8
ICAgMTIgKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgYWxzYWN0bC9pbml0L2ljaDQKCmRpZmYg
LS1naXQgYS9hbHNhY3RsL2luaXQvMDBtYWluIGIvYWxzYWN0bC9pbml0LzAwbWFpbgppbmRleCA2
NjBkZjM4Li5iZWI3MmExIDEwMDY0NAotLS0gYS9hbHNhY3RsL2luaXQvMDBtYWluCisrKyBiL2Fs
c2FjdGwvaW5pdC8wMG1haW4KQEAgLTMxLDYgKzMxLDcgQEAgUkVTVUxUPT0ic2tpcCIsIEdPVE89
ImluaXRfZW5kIgogCiAjIHJlYWwgQUxTQSBjb25maWd1cmF0aW9uIGRhdGFiYXNlCiBDQVJESU5G
T3tkcml2ZXJ9PT0iSERBLUludGVsIiwgSU5DTFVERT0iaGRhIiwgR09UTz0iaW5pdF9lbmQiCitD
QVJESU5GT3tkcml2ZXJ9PT0iSUNINCIsIElOQ0xVREU9ImljaDQiLCBHT1RPPSJpbml0X2VuZCIK
IENBUkRJTkZPe2RyaXZlcn09PSJDQTAxMDYiLCBJTkNMVURFPSJjYTAxMDYiLCBHT1RPPSJpbml0
X2VuZCIKIENBUkRJTkZPe2RyaXZlcn09PSJUZXN0IiwgSU5DTFVERT0idGVzdCIsIEdPVE89Imlu
aXRfZW5kIgogCmRpZmYgLS1naXQgYS9hbHNhY3RsL2luaXQvTWFrZWZpbGUuYW0gYi9hbHNhY3Rs
L2luaXQvTWFrZWZpbGUuYW0KaW5kZXggOWUyYjgzZC4uMzk2ZDM5OCAxMDA2NDQKLS0tIGEvYWxz
YWN0bC9pbml0L01ha2VmaWxlLmFtCisrKyBiL2Fsc2FjdGwvaW5pdC9NYWtlZmlsZS5hbQpAQCAt
MSw2ICsxLDYgQEAKIAogaW5pdF9maWxlcyA9IFwKLQkwMG1haW4gZGVmYXVsdCBoZWxwIGluZm8g
dGVzdCBcCisJMDBtYWluIGRlZmF1bHQgaGVscCBpY2g0IGluZm8gdGVzdCBcCiAJaGRhCiBFWFRS
QV9ESVNUID0gJChpbml0X2ZpbGVzKQogYWxzYWluaXRkaXIgPSAkKGRhdGFkaXIpL2Fsc2EvaW5p
dApkaWZmIC0tZ2l0IGEvYWxzYWN0bC9pbml0L2ljaDQgYi9hbHNhY3RsL2luaXQvaWNoNApuZXcg
ZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi5lY2NiYTJmCi0tLSAvZGV2L251bGwKKysr
IGIvYWxzYWN0bC9pbml0L2ljaDQKQEAgLTAsMCArMSwxMiBAQAorIyBDb25maWd1cmF0aW9uIGZv
ciBJbnRlbCBJQ0g0LzUvNgorCitDQVJESU5GT3ttaXhlcm5hbWV9PT0iQW5hbG9nIERldmljZXMg
QUQxOTgxQiIsIFwKKyAgQVRUUntzdWJzeXN0ZW1fdmVuZG9yfT09IjB4MTAzYyIsIEFUVFJ7c3Vi
c3lzdGVtX2RldmljZX09PSIweDA5OWMiLCBcCisgIEdPVE89IkNvbXBhcSBueDYxMTAiCitSRVNV
TFQ9ImZhbHNlIiwgRVhJVD0icmV0dXJuIgorCitMQUJFTD0iQ29tcGFxIG54NjExMCIKKyMgcGxh
eWJhY2sKK0NUTHtyZXNldH09Im1peGVyIgorQ1RMe25hbWV9PSJIZWFkcGhvbmUgSmFjayBTZW5z
ZSIsIENUTHt2YWx1ZX09Im9uIgorUkVTVUxUPSJ0cnVlIiwgRVhJVD0icmV0dXJuIgotLSAKMS43
LjAuNAoK
--0016e65b5ee0402a480490068740
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0016e65b5ee0402a480490068740--
