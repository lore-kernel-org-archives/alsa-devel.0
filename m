From: Dan Chen <crimsunkg@yahoo.com>
Subject: Patches for alsactl init db
Date: Tue, 29 Sep 2009 22:45:43 -0700 (PDT)
Message-ID: <937485.7802.qm@web31808.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-854821505-1254289543=:7802"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web31808.mail.mud.yahoo.com (web31808.mail.mud.yahoo.com
	[68.142.207.71]) by alsa0.perex.cz (Postfix) with SMTP id 1C249103858
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Sep 2009 07:45:45 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0-854821505-1254289543=:7802
Content-Type: text/plain; charset=us-ascii

Hi,

Attached are two patches against alsa-utils.git HEAD that create an intel8x0 init db file for ICH4. This is necessary from bug reports in Debian and Ubuntu that state that External Amplifier must be muted to have audible (analog) playback by default on the Sony VAIO VGN-T350P.

Thanks,
Dan



      
--0-854821505-1254289543=:7802
Content-Type: application/octet-stream; name="0001-Mute-External-Amplifier-by-default-for-Sony-VAIO-VGN.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-Mute-External-Amplifier-by-default-for-Sony-VAIO-VGN.patch"

RnJvbSBhZjAwYjFhZjI4NWRjNmU2MzNjODQzNDAyZjdkMzJkMTZkZWQ0Y2Vh
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVu
IDxjcmltc3VuQHVidW50dS5jb20+CkRhdGU6IFdlZCwgMzAgU2VwIDIwMDkg
MDE6Mjc6MzYgLTA0MDAKU3ViamVjdDogW1BBVENIIDEvMl0gTXV0ZSBFeHRl
cm5hbCBBbXBsaWZpZXIgYnkgZGVmYXVsdCBmb3IgU29ueSBWQUlPIFZHTi1U
MzUwUAoKQnVnTGluazogaHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5uZXQvYnVn
cy80MTA5MzMKClRoaXMgU29ueSBWQUlPIG1vZGVsIG5lZWRzIEV4dGVybmFs
IEFtcGxpZmllciB1bm11dGVkIGZvciBhdWRpYmxlCnBsYXliYWNrLCBzbyBs
ZXQncyBzZXQgaXQgYXMgc3VjaCBpbiB0aGUgYWxzYWN0bCBpbml0IGRiLgoK
U2lnbmVkLW9mZi1ieTogRGFuaWVsIFQgQ2hlbiA8Y3JpbXN1bkB1YnVudHUu
Y29tPgotLS0KIGFsc2FjdGwvaW5pdC9pbnRlbDh4MCB8ICAgMTIgKysrKysr
KysrKysrCiAxIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDAg
ZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgYWxzYWN0bC9pbml0
L2ludGVsOHgwCgpkaWZmIC0tZ2l0IGEvYWxzYWN0bC9pbml0L2ludGVsOHgw
IGIvYWxzYWN0bC9pbml0L2ludGVsOHgwCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
CmluZGV4IDAwMDAwMDAuLmQ5YzEyM2IKLS0tIC9kZXYvbnVsbAorKysgYi9h
bHNhY3RsL2luaXQvaW50ZWw4eDAKQEAgLTAsMCArMSwxMiBAQAorIyBDb25m
aWd1cmF0aW9uIGZvciBJbnRlbDh4MCBkcml2ZXIKKworQ0FSRElORk97bWl4
ZXJuYW1lfT09IkFuYWxvZyBEZXZpY2VzIEFEMTk4MUIiLCBcCisgIEFUVFJ7
c3Vic3lzdGVtX3ZlbmRvcn09PSIweDEwNGQiLCBBVFRSe3N1YnN5c3RlbV9k
ZXZpY2V9PT0iMHg4MWMwIiwgXAorICBHT1RPPSJTb255IFZBSU8gVkdOLVQz
NTBQIgorUkVTVUxUPSJmYWxzZSIsIEVYSVQ9InJldHVybiIKKworTEFCRUw9
IlNvbnkgVkFJTyBWR04tVDM1MFAiCisjIHBsYXliYWNrCitDVEx7cmVzZXR9
PSJtaXhlciIKK0NUTHtuYW1lfT0iRXh0ZXJuYWwgQW1wbGlmaWVyIiwgQ1RM
e3ZhbHVlfT0ib2ZmIgorUkVTVUxUPSJ0cnVlIiwgRVhJVD0icmV0dXJuIgot
LSAKMS42LjMuMwoK

--0-854821505-1254289543=:7802
Content-Type: application/octet-stream; name="0002-Add-an-intel8x0-ICH4-configuration-file-and-use-it.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0002-Add-an-intel8x0-ICH4-configuration-file-and-use-it.patch"

RnJvbSAwYTE2ZmE3MjVmNWZkZjBmZjM2NWEzMmQ1NjE1NjRlZmY0ODM4NWNi
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVu
IDxjcmltc3VuQHVidW50dS5jb20+CkRhdGU6IFdlZCwgMzAgU2VwIDIwMDkg
MDE6MzU6MDggLTA0MDAKU3ViamVjdDogW1BBVENIIDIvMl0gQWRkIGFuIGlu
dGVsOHgwIElDSDQgY29uZmlndXJhdGlvbiBmaWxlIGFuZCB1c2UgaXQKClRv
IHVzZSB0aGUgd29ya2Fyb3VuZCBtaXhlciBzZXR0aW5nIGZvciB0aGUgU29u
eSBWQUlPIFZHTi1UMzUwUApyZWZlcmVuY2VkIGluIHRoZSBwcmV2aW91cyBj
b21taXQsIHdlIG5lZWQgdG8gYWRkIHRoZSBhcHByb3ByaWF0ZQppbmNsdXNp
b24gdG8gMDBtYWluLCB3aGljaCBpcyBkb25lIGJ5IHRoaXMgcGF0Y2guCgpT
aWduZWQtb2ZmLWJ5OiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5j
b20+Ci0tLQogYWxzYWN0bC9pbml0LzAwbWFpbiB8ICAgIDEgKwogMSBmaWxl
cyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvYWxzYWN0bC9pbml0LzAwbWFpbiBiL2Fsc2FjdGwvaW5p
dC8wMG1haW4KaW5kZXggMmQyNmJiZi4uMDU0YzExOCAxMDA2NDQKLS0tIGEv
YWxzYWN0bC9pbml0LzAwbWFpbgorKysgYi9hbHNhY3RsL2luaXQvMDBtYWlu
CkBAIC0zMiw2ICszMiw3IEBAIFJFU1VMVD09InNraXAiLCBHT1RPPSJpbml0
X2VuZCIKICMgcmVhbCBBTFNBIGNvbmZpZ3VyYXRpb24gZGF0YWJhc2UKIENB
UkRJTkZPe2RyaXZlcn09PSJIREEtSW50ZWwiLCBJTkNMVURFPSJoZGEiLCBH
T1RPPSJpbml0X2VuZCIKIENBUkRJTkZPe2RyaXZlcn09PSJDQTAxMDYiLCBJ
TkNMVURFPSJjYTAxMDYiLCBHT1RPPSJpbml0X2VuZCIKK0NBUkRJTkZPe2Ry
aXZlcn09PSJJQ0g0IiwgSU5DTFVERT0iaW50ZWw4eDAiLCBHT1RPPSJpbml0
X2VuZCIKIENBUkRJTkZPe2RyaXZlcn09PSJUZXN0IiwgSU5DTFVERT0idGVz
dCIsIEdPVE89ImluaXRfZW5kIgogCiBMQUJFTD0iaW5pdF9lbmQiCi0tIAox
LjYuMy4zCgo=

--0-854821505-1254289543=:7802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0-854821505-1254289543=:7802--
