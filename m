From: ANDREI LAHUN <zhirnyi@yahoo.com>
Subject: Patch for ali5451 (ATI IGP chipset) "ali_codec_ready: codec is not ready"
Date: Sat, 29 Mar 2003 08:25:02 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030329162502.21778.qmail@web21512.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1434480658-1048955102=:21462"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--0-1434480658-1048955102=:21462
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Hello.
Since i bought new laptop (Packard bell igo 3xxx) (ATI
IGP chipset, ALI 5451 sound) i had a problems with a
sound .Trident from OSS worked but quality was not
good. Alsa always hunged with messages (during
modprobe) -
"ali_codec_ready: codec is not ready" all over the
place. Finally i found a fix - to make it work like in
trident OSS driver. For me now alsa works perfectly
in native mode and in OSS emulation. Thank u for great
drivers!

Andrei

__________________________________________________
Do you Yahoo!?
Yahoo! Platinum - Watch CBS' NCAA March Madness, live on your desktop!
http://platinum.yahoo.com
--0-1434480658-1048955102=:21462
Content-Type: application/octet-stream; name="ali5451_codec_ready.patch"
Content-Transfer-Encoding: base64
Content-Description: ali5451_codec_ready.patch
Content-Disposition: attachment; filename="ali5451_codec_ready.patch"

LS0tIGFsc2EtZHJpdmVyLTAuOS4yL2Fsc2Eta2VybmVsL3BjaS9hbGk1NDUx
L2FsaTU0NTEuYwlUdWUgRmViIDI1IDE0OjM1OjQzIDIwMDMKKysrIGFsc2Et
ZHJpdmVyLTAuOS4yLW1vZC9hbHNhLWtlcm5lbC9wY2kvYWxpNTQ1MS9hbGk1
NDUxLmMJVHVlIE1hciAyNSAwMDoyNjo1MyAyMDAzCkBAIC0zNzYsMTYgKzM3
NiwxOSBAQAogCQkJCWludCBzY2hlZCApCiB7CiAJc2lnbmVkIGxvbmcgZW5k
X3RpbWU7CisJdW5zaWduZWQgbG9uZyByZXM7CiAJCiAJZW5kX3RpbWUgPSBq
aWZmaWVzICsgMTAgKiAoSFogPj4gMik7CiAJZG8gewotCQlpZiAoIShzbmRf
YWxpXzU0NTFfcGVlayhjb2RlYyxwb3J0KSAmIDB4ODAwMCkpCisJCXJlcyA9
IHNuZF9hbGlfNTQ1MV9wZWVrKGNvZGVjLHBvcnQpOworCQlpZiAoIShyZXMg
JiAweDgwMDApKQogCQkJcmV0dXJuIDA7CiAJCWlmIChzY2hlZCkgewogCQkJ
c2V0X2N1cnJlbnRfc3RhdGUoVEFTS19VTklOVEVSUlVQVElCTEUpOwogCQkJ
c2NoZWR1bGVfdGltZW91dCgxKTsKIAkJfQogCX0gd2hpbGUgKGVuZF90aW1l
IC0gKHNpZ25lZCBsb25nKWppZmZpZXMgPj0gMCk7CisJc25kX2FsaV81NDUx
X3Bva2UoY29kZWMscG9ydCwgcmVzICYgMHg3ZmZmKTsKIAlzbmRfcHJpbnRr
KCJhbGlfY29kZWNfcmVhZHk6IGNvZGVjIGlzIG5vdCByZWFkeS5cbiAiKTsK
IAlyZXR1cm4gLUVJTzsKIH0KQEAgLTQwOCw2ICs0MTEsOSBAQAogCQkJc2No
ZWR1bGVfdGltZW91dCgxKTsKIAkJfQogCX0gd2hpbGUgKGVuZF90aW1lIC0g
KHNpZ25lZCBsb25nKWppZmZpZXMgPj0gMCk7CisJCisJCisJCiAJc25kX3By
aW50aygiYWxpX3N0aW1lcl9yZWFkOiBzdGltZXIgaXMgbm90IHJlYWR5Llxu
Iik7CiAJcmV0dXJuIC1FSU87CiB9Cg==

--0-1434480658-1048955102=:21462--


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
