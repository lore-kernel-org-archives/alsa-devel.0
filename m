From: "Thomas Charbonnel" <thomas@undata.org>
Subject: hdsp driver status
Date: Thu, 3 Jul 2003 13:12:54 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32847.81.50.18.84.1057230774.squirrel@www.undata.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_20030703131254_39457"
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

------=_20030703131254_39457
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,

I've been off the net and busy for a long time. I apologize to anyone
whose mail I didn't answer during this period. I'm slowly catching up with
the huge activity that has been going on this list, focusing on the hdsp
driver issues. I'd like to summarize the driver status :

Fixed :
* Marcus, Jaroslav : thanks for having solved the long (ever ? :)
lasting hdsp midi bug !

Done:
* Takashi : I succesfully tested your memory preallocation patch (only
the hdsp part of it, actually), thanks for it. (Thanks too for the
addition of hdspconf to cvs, it is indeed the latest version).

Remaining:
* HDSP9652: the matrix mixer isn't yet handled right.
* Rev11 + Multiface: either the firmware file is wrong or the io-box
firmware upload scenario has changed for this card revision. Has anyone
ever had success with this combination (or rev11 + Digiface) ?

The attached patch :
* Reenables the hdsp_check_for_iobox function Paul bypassed in his
previous patch. This function is needed for mobile setups. It handles the
cases where the iobox has been unplugged/replugged or lost power supply.
* Fixes the channel limit Mark has reported on the HDSP9652 (24 instead of
26).
* Fixes a locking issue reported by Joshua N Pritikin.

David, Jesse and Patrick, I'm back at work on the totalmix clone. It
should be out for testing really soon. Sorry for having been so
unresponsive lately.

Thomas



------=_20030703131254_39457
Content-Type: application/octet-stream; name="hdsp-03-07-03.patch"
Content-Disposition: attachment; filename="hdsp-03-07-03.patch"
Content-Transfer-Encoding: base64

LS0tIGhkc3AuYy5vbGQJMjAwMy0wNy0wMyAxMjoyMzo1Mi4wMDAwMDAwMDAgKzAyMDAKKysrIGhk
c3AuYwkyMDAzLTA3LTAzIDEyOjI0OjA3LjAwMDAwMDAwMCArMDIwMApAQCAtNzYsOCArNzYsOCBA
QAogI2RlZmluZSBESUdJRkFDRV9EU19DSEFOTkVMUyAgICAgMTQKICNkZWZpbmUgTVVMVElGQUNF
X1NTX0NIQU5ORUxTICAgIDE4CiAjZGVmaW5lIE1VTFRJRkFDRV9EU19DSEFOTkVMUyAgICAxNAot
I2RlZmluZSBIOTY1Ml9EU19DSEFOTkVMUyAgICAgICAgMjQKLSNkZWZpbmUgSDk2NTJfU1NfQ0hB
Tk5FTFMgICAgICAgIDI0CisjZGVmaW5lIEg5NjUyX0RTX0NIQU5ORUxTICAgICAgICAyNgorI2Rl
ZmluZSBIOTY1Ml9TU19DSEFOTkVMUyAgICAgICAgMTQKIAogLyogV3JpdGUgcmVnaXN0ZXJzLiBU
aGVzZSBhcmUgZGVmaW5lZCBhcyBieXRlLW9mZnNldHMgZnJvbSB0aGUgaW9iYXNlIHZhbHVlLgog
ICovCkBAIC00OTcsMTUgKzQ5NywxNSBAQAogCiBzdGF0aWMgaW5saW5lIGludCBoZHNwX2NoZWNr
X2Zvcl9pb2JveCAoaGRzcF90ICpoZHNwKQogewotCXJldHVybiAwOwotI2lmIDAKKworCWlmICho
ZHNwLT5pb190eXBlID09IEg5NjUyKSByZXR1cm4gMDsKIAlpZiAoaGRzcF9yZWFkIChoZHNwLCBI
RFNQX3N0YXR1c1JlZ2lzdGVyKSAmIEhEU1BfQ29uZmlnRXJyb3IpIHsKIAkJc25kX3ByaW50ayAo
IkhhbW1lcmZhbGwtRFNQOiBubyBEaWdpZmFjZSBvciBNdWx0aWZhY2UgY29ubmVjdGVkIVxuIik7
CiAJCWhkc3AtPnN0YXRlICY9IH5IRFNQX0Zpcm13YXJlTG9hZGVkOwogCQlyZXR1cm4gLUVJTzsK
IAl9CiAJcmV0dXJuIDA7Ci0jZW5kaWYKKwogfQogCiBzdGF0aWMgaW50IHNuZF9oZHNwX2xvYWRf
ZmlybXdhcmVfZnJvbV9jYWNoZShoZHNwX3QgKmhkc3ApIHsKQEAgLTgzNSw2ICs4MzUsMTEgQEAK
IAlpbnQgY3VycmVudF9yYXRlOwogCWludCByYXRlX2JpdHM7CiAKKwkvKiBBU1NVTVBUSU9OOiBo
ZHNwLT5sb2NrIGlzIGVpdGhlciBoZWxwLCBvcgorCSAgIHRoZXJlIGlzIG5vIG5lZWQgZm9yIGl0
IChlLmcuIGR1cmluZyBtb2R1bGUKKwkgICBpbml0aWFsaXphdGlvbikuCisJKi8KKwkKIAlpZiAo
IShoZHNwLT5jb250cm9sX3JlZ2lzdGVyICYgSERTUF9DbG9ja01vZGVNYXN0ZXIpKSB7CQogCQlp
ZiAoY2FsbGVkX2ludGVybmFsbHkpIHsKIAkJCS8qIHJlcXVlc3QgZnJvbSBjdGwgb3IgY2FyZCBp
bml0aWFsaXphdGlvbiAqLwpAQCAtODY2LDggKzg3MSw2IEBACiAJICAgZXhpc3RzIGZvciBleHRl
cm5hbGx5LWRyaXZlbiByYXRlIGNoYW5nZXMuIEFsbCB3ZSBjYW4gZG8KIAkgICBpcyB0byBmbGFn
IHJhdGUgY2hhbmdlcyBpbiB0aGUgcmVhZC93cml0ZSByb3V0aW5lcy4gICovCiAKLQlzcGluX2xv
Y2tfaXJxKCZoZHNwLT5sb2NrKTsKLQogCXN3aXRjaCAocmF0ZSkgewogCWNhc2UgMzIwMDA6CiAJ
CWlmIChjdXJyZW50X3JhdGUgPiA0ODAwMCkgewpAQCAtOTA2LDcgKzkwOSw2IEBACiAJCXJhdGVf
Yml0cyA9IEhEU1BfRnJlcXVlbmN5OTZLSHo7CiAJCWJyZWFrOwogCWRlZmF1bHQ6Ci0JCXNwaW5f
dW5sb2NrX2lycSgmaGRzcC0+bG9jayk7CiAJCXJldHVybiAtRUlOVkFMOwogCX0KIApAQCAtOTE0
LDcgKzkxNiw2IEBACiAJCXNuZF9wcmludGsgKCJjYW5ub3QgY2hhbmdlIGJldHdlZW4gc2luZ2xl
LSBhbmQgZG91YmxlLXNwZWVkIG1vZGUgKGNhcHR1cmUgUElEID0gJWQsIHBsYXliYWNrIFBJRCA9
ICVkKVxuIiwKIAkJCSAgICBoZHNwLT5jYXB0dXJlX3BpZCwKIAkJCSAgICBoZHNwLT5wbGF5YmFj
a19waWQpOwotCQlzcGluX3VubG9ja19pcnEoJmhkc3AtPmxvY2spOwogCQlyZXR1cm4gLUVCVVNZ
OwogCX0KIApAQCAtOTQ1LDcgKzk0Niw2IEBACiAJCWhkc3BfdXBkYXRlX3NpbXBsZV9taXhlcl9j
b250cm9scyAoaGRzcCk7CiAJfQogCi0Jc3Bpbl91bmxvY2tfaXJxKCZoZHNwLT5sb2NrKTsKIAly
ZXR1cm4gMDsKIH0KIApAQCAtMzM0Niw5ICszMzQ2LDEzIEBACiAJLyogaG93IHRvIG1ha2Ugc3Vy
ZSB0aGF0IHRoZSByYXRlIG1hdGNoZXMgYW4gZXh0ZXJuYWxseS1zZXQgb25lID8KIAkgKi8KIAor
CXNwaW5fbG9ja19pcnEoJmhkc3AtPmxvY2spOwogCWlmICgoZXJyID0gaGRzcF9zZXRfcmF0ZSho
ZHNwLCBwYXJhbXNfcmF0ZShwYXJhbXMpLCAwKSkgPCAwKSB7CisJCXNwaW5fdW5sb2NrX2lycSgm
aGRzcC0+bG9jayk7CiAJCV9zbmRfcGNtX2h3X3BhcmFtX3NldGVtcHR5KHBhcmFtcywgU05EUlZf
UENNX0hXX1BBUkFNX1JBVEUpOwogCQlyZXR1cm4gZXJyOworCX0gZWxzZSB7CisJCXNwaW5fdW5s
b2NrX2lycSgmaGRzcC0+bG9jayk7CiAJfQogCiAJaWYgKChlcnIgPSBoZHNwX3NldF9pbnRlcnJ1
cHRfaW50ZXJ2YWwoaGRzcCwgcGFyYW1zX3BlcmlvZF9zaXplKHBhcmFtcykpKSA8IDApIHsK

------=_20030703131254_39457--



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
