From: Dan Chen <crimsunkg@yahoo.com>
Subject: [PATCH] ALSA: hda: Use 3stack quirk for some broken
	Dell models
Date: Wed, 4 Nov 2009 17:36:51 -0800 (PST)
Message-ID: <730569.68030.qm@web112605.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2127800005-1257385011=:68030"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web112605.mail.gq1.yahoo.com (web112605.mail.gq1.yahoo.com
	[98.137.27.185]) by alsa0.perex.cz (Postfix) with SMTP id 31A82103814
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 02:36:54 +0100 (CET)
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
Cc: crimsun@ubuntu.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0-2127800005-1257385011=:68030
Content-Type: text/plain; charset=us-ascii

Hi,

In triaging bugs for Ubuntu 9.10, I've seen several Dell models that
are behaving strangely with the current driver. Attached please find
a patch against current sound-2.6 HEAD that allows these models
to have somewhat more sane behaviour when headphones are
inserted.

Thanks,
Dan



      
--0-2127800005-1257385011=:68030
Content-Type: application/octet-stream; name="0001-ALSA-hda-Use-3stack-quirk-for-some-broken-Dell-model.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-ALSA-hda-Use-3stack-quirk-for-some-broken-Dell-model.patch"

RnJvbSAyZWNjOGRlM2NiZDk1ZjlhMzJhOWY1MzZjNWYxNTRmMmZkNDI2NjVj
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVu
IDxjcmltc3VuQHVidW50dS5jb20+CkRhdGU6IFdlZCwgNCBOb3YgMjAwOSAy
MDoyNDoyMSAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6IGhkYTogVXNl
IDNzdGFjayBxdWlyayBmb3Igc29tZSBicm9rZW4gRGVsbCBtb2RlbHMKCkJ1
Z0xpbms6IGh0dHBzOi8vYnVncy5sYXVuY2hwYWQubmV0L2J1Z3MvMjc5NDc4
CgpUaGUgb3JpZ2luYWwgKGN1cnJlbnQpIHF1aXJrcyByZWx5IG9uIHRoZSBi
aW9zZXMgYmVpbmcgY29ycmVjdCwgd2hpY2gKc2FkbHkgaXMgbm90IHRoZSBj
YXNlIGVtcGlyaWNhbGx5LiBVc2VycyBhcmUgcmVwb3J0aW5nIG9uZSBvZiB0
aGUKZm9sbG93aW5nIGFmdGVyIGluc2VydGluZyBoZWFkcGhvbmVzOgoKKiBh
dWRpbyBmYWRlcyB1bnRpbCBpbmF1ZGlibGUKKiBpbnRlcm5hbCBzcGVha2Vy
cyBkbyBub3QgbXV0ZQoKVW50aWwgd2UgY2FuIHBpbnBvaW50IHRoZSByZWFs
IGN1bHByaXQsIGxldCdzIGp1c3QgdXNlIGEgd29ya2luZwpxdWlyay4KClNp
Z25lZC1vZmYtYnk6IERhbmllbCBUIENoZW4gPGNyaW1zdW5AdWJ1bnR1LmNv
bT4KLS0tCiBzb3VuZC9wY2kvaGRhL3BhdGNoX3NpZ21hdGVsLmMgfCAgICA4
ICsrKystLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL3Bh
dGNoX3NpZ21hdGVsLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3NpZ21hdGVs
LmMKaW5kZXggYjUxM2ViYS4uM2IzNDZjNCAxMDA2NDQKLS0tIGEvc291bmQv
cGNpL2hkYS9wYXRjaF9zaWdtYXRlbC5jCisrKyBiL3NvdW5kL3BjaS9oZGEv
cGF0Y2hfc2lnbWF0ZWwuYwpAQCAtMjA1MCwxMyArMjA1MCwxMyBAQCBzdGF0
aWMgc3RydWN0IHNuZF9wY2lfcXVpcmsgc3RhYzkyN3hfY2ZnX3RibFtdID0g
ewogCQkJICAgIkludGVsIEQ5NjUiLCBTVEFDX0Q5NjVfM1NUKSwKIAlTTkRf
UENJX1FVSVJLX01BU0soUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHhmZjAwLCAw
eDIwMDAsCiAJCQkgICAiSW50ZWwgRDk2NSIsIFNUQUNfRDk2NV8zU1QpLAor
CVNORF9QQ0lfUVVJUksoUENJX1ZFTkRPUl9JRF9ERUxMLCAgMHgwMWRkLCAi
RGVsbCBEaW1lbnNpb24gRTUyMCIsIFNUQUNfRDk2NV8zU1QpLAorCVNORF9Q
Q0lfUVVJUksoUENJX1ZFTkRPUl9JRF9ERUxMLCAgMHgwMWVkLCAiRGVsbCBE
aW1lbnNpb24gRTUyMSIsIFNUQUNfRDk2NV8zU1QpLAorCVNORF9QQ0lfUVVJ
UksoUENJX1ZFTkRPUl9JRF9ERUxMLCAgMHgwMWYzLCAiRGVsbCBJbnNwaXJv
biAxNDIwIiwgU1RBQ19EOTY1XzNTVCksCisJU05EX1BDSV9RVUlSSyhQQ0lf
VkVORE9SX0lEX0RFTEwsICAweDAxZjQsICJEZWxsIERpbWVuc2lvbiBDNTIx
IiwgU1RBQ19EOTY1XzNTVCksCiAJLyogRGVsbCAzIHN0YWNrIHN5c3RlbXMg
Ki8KIAlTTkRfUENJX1FVSVJLKFBDSV9WRU5ET1JfSURfREVMTCwgIDB4MDFm
NywgIkRlbGwgWFBTIE0xNzMwIiwgU1RBQ19ERUxMXzNTVCksCi0JU05EX1BD
SV9RVUlSSyhQQ0lfVkVORE9SX0lEX0RFTEwsICAweDAxZGQsICJEZWxsIERp
bWVuc2lvbiBFNTIwIiwgU1RBQ19ERUxMXzNTVCksCi0JU05EX1BDSV9RVUlS
SyhQQ0lfVkVORE9SX0lEX0RFTEwsICAweDAxZWQsICJEZWxsICAgICAiLCBT
VEFDX0RFTExfM1NUKSwKLQlTTkRfUENJX1FVSVJLKFBDSV9WRU5ET1JfSURf
REVMTCwgIDB4MDFmNCwgIkRlbGwgICAgICIsIFNUQUNfREVMTF8zU1QpLAog
CS8qIERlbGwgMyBzdGFjayBzeXN0ZW1zIHdpdGggdmVyYiB0YWJsZSBpbiBC
SU9TICovCi0JU05EX1BDSV9RVUlSSyhQQ0lfVkVORE9SX0lEX0RFTEwsICAw
eDAxZjMsICJEZWxsIEluc3Bpcm9uIDE0MjAiLCBTVEFDX0RFTExfQklPUyks
CiAJU05EX1BDSV9RVUlSSyhQQ0lfVkVORE9SX0lEX0RFTEwsICAweDAyMjcs
ICJEZWxsIFZvc3RybyAxNDAwICAiLCBTVEFDX0RFTExfQklPUyksCiAJU05E
X1BDSV9RVUlSSyhQQ0lfVkVORE9SX0lEX0RFTEwsICAweDAyMmUsICJEZWxs
ICAgICAiLCBTVEFDX0RFTExfQklPUyksCiAJU05EX1BDSV9RVUlSSyhQQ0lf
VkVORE9SX0lEX0RFTEwsICAweDAyMmYsICJEZWxsIEluc3Bpcm9uIDE1MjUi
LCBTVEFDX0RFTExfQklPUyksCi0tIAoxLjYuMy4zCgo=

--0-2127800005-1257385011=:68030
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0-2127800005-1257385011=:68030--
