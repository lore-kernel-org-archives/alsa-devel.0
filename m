From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: Re: [PATCH] sparc dbri: recording is back
Date: Fri, 25 Aug 2006 19:58:05 +0200
Message-ID: <44ef3a2db031c@wp.pl>
References: <44ec9a1bf3034@wp.pl>
Content-Type: multipart/mixed; boundary="===============0907351649=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--===============0907351649==

<s5hirkjwc4w.wl%tiwai@suse.de>
<44ed42960731f@wp.pl> <s5hhd02v69h.wl%tiwai@suse.de>
In-reply-to: <44ec9a1bf3034@wp.pl>
<s5hirkjwc4w.wl%tiwai@suse.de>
<44ed42960731f@wp.pl> <s5hhd02v69h.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="part44ef3a2db03f0"
X-Mailer: Interfejs WWW poczty Wirtualnej Polski
Organization: Poczta Wirtualnej Polski S.A. http://www.wp.pl/
X-User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4a) Gecko/20030401
X-WP-IP: 213.76.90.126
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO AS1=NO AS2=NO(0.502872) AS3=NO AS4=NO AS5=NO                                                             

This is a multi-part message in MIME format.

--part44ef3a2db03f0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

From: Krzysztof Helt (krzysztof.h1@wp.pl)

This patch fixes sound recording after the driver convertion to
ring buffered version. It also contains small clean ups to the
driver. 

Signed-off-by: Krzysztof Helt (krzysztof.h1@wp.pl)
---

This is repost of the patch against current HG tree. It contains
part of the 13th patch as it really belong to this one.

The 12th patch is the same as I posted it (there is no need to
change it). Should I repost it as well?

Regards,
Krzysztof

----------------------------------------------------
Radio Zet Platinum - Blue Eyes to dwup³ytowy zestaw 
utworów przywo³uj±cy nastrój wakacyjnego lenistwa.
Ju¿ w sprzeda¿y!!
http://klik.wp.pl/?adr=http%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fradio_zet_platinum.html&sid=855

--part44ef3a2db03f0
Content-Type: application/octet-stream; name="dbri-patch11.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dbri-patch11.diff"

LS0tIGFsc2EtZHJpdmVyLTEuMC4xMnJjMi9hbHNhLWtlcm5lbC9zcGFyYy9kYnJpLmMJMjAwNi0w
OC0yNSAxOToyNDo0My4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4xN2Evc291bmQvc3Bh
cmMvZGJyaS5jCTIwMDYtMDgtMjUgMTk6Mjk6NDYuMDAwMDAwMDAwICswMjAwCkBAIC0xMDcsNyAr
MTA3LDcgQEAgc3RhdGljIGNoYXIgKmNtZHNbXSA9IHsKICNkZWZpbmUgZHByaW50ayhhLCB4Li4u
KSBpZihkYnJpX2RlYnVnICYgYSkgcHJpbnRrKEtFUk5fREVCVUcgeCkKIAogI2Vsc2UKLSNkZWZp
bmUgZHByaW50ayhhLCB4Li4uKQorI2RlZmluZSBkcHJpbnRrKGEsIHguLi4pIGRvIHsgfSB3aGls
ZSAoMCkKIAogI2VuZGlmCQkJCS8qIERCUklfREVCVUcgKi8KIApAQCAtNjEwLDEwICs2MTAsMTAg
QEAgQ1BVIGludGVycnVwdCB0byBzaWduYWwgY29tcGxldGlvbi4KIAogU2luY2UgdGhlIERCUkkg
Y2FuIHJ1biBpbiBwYXJhbGxlbCB3aXRoIHRoZSBDUFUsIHNldmVyYWwgbWVhbnMgb2YKIHN5bmNo
cm9uaXphdGlvbiBwcmVzZW50IHRoZW1zZWx2ZXMuIFRoZSBtZXRob2QgaW1wbGVtZW50ZWQgaGVy
ZSBpcyBvbmx5Ci10byB1c2UgdGhlIGRicmlfY21kd2FpdCgpIHRvIHdhaXQgZm9yIGV4ZWN1dGlv
biBvZiBiYXRjaCBvZiBzZW50IGNvbW1hbmRzLgordXNlIG9mIHRoZSBkYnJpX2NtZHdhaXQoKSB0
byB3YWl0IGZvciBleGVjdXRpb24gb2YgYmF0Y2ggb2Ygc2VudCBjb21tYW5kcy4KIAogQSBjaXJj
dWxhciBjb21tYW5kIGJ1ZmZlciBpcyB1c2VkIGhlcmUuIEEgbmV3IGNvbW1hbmQgaXMgYmVpbmcg
YWRkZWQgCi13aGlsZSBvdGhlciBjYW4gYmUgZXhlY3V0ZWQuIFRoZSBzY2hlbWUgd29ya3MgYnkg
YWRkaW5nIHR3byBXQUlUIGNvbW1hbmRzCit3aGlsZSBhbm90aGVyIGNhbiBiZSBleGVjdXRlZC4g
VGhlIHNjaGVtZSB3b3JrcyBieSBhZGRpbmcgdHdvIFdBSVQgY29tbWFuZHMKIGFmdGVyIGVhY2gg
c2VudCBiYXRjaCBvZiBjb21tYW5kcy4gV2hlbiB0aGUgbmV4dCBiYXRjaCBpcyBwcmVwYXJlZCBp
dCBpcwogYWRkZWQgYWZ0ZXIgdGhlIFdBSVQgY29tbWFuZHMgdGhlbiB0aGUgV0FJVHMgYXJlIHJl
cGxhY2VkIHdpdGggc2luZ2xlIEpVTVAKIGNvbW1hbmQgdG8gdGhlIG5ldyBiYXRjaC4gVGhlIHRo
ZSBEQlJJIGlzIGZvcmNlZCB0byByZXJlYWQgdGhlIGxhc3QgV0FJVCAKQEAgLTYyOCw3ICs2Mjgs
NyBAQCB0byBzZW5kIHRoZW0gdG8gdGhlIERCUkkuCiAKICovCiAKLSNkZWZpbmUgTUFYTE9PUFMg
MTAKKyNkZWZpbmUgTUFYTE9PUFMgMjAKIC8qCiAgKiBXYWl0IGZvciB0aGUgY3VycmVudCBjb21t
YW5kIHN0cmluZyB0byBleGVjdXRlCiAgKi8KQEAgLTY5Miw5ICs2OTIsOCBAQCBzdGF0aWMgdm9p
ZCBkYnJpX2NtZHNlbmQoc3RydWN0IHNuZF9kYnJpCiAJaWYgKGNtZCA+IGRicmktPmNtZHB0cikg
ewogCQlzMzIgKnB0cjsKIAotCQlmb3IgKHB0ciA9IGRicmktPmNtZHB0cjsgcHRyIDwgY21kKzI7
IHB0cisrKSB7CisJCWZvciAocHRyID0gZGJyaS0+Y21kcHRyOyBwdHIgPCBjbWQrMjsgcHRyKysp
CiAJCQlkcHJpbnRrKERfQ01ELCAiY21kOiAlbHg6JTA4eFxuIiwgKHVuc2lnbmVkIGxvbmcpcHRy
LCAqcHRyKTsKLQkJfQogCX0gZWxzZSB7CiAJCXMzMiAqcHRyID0gZGJyaS0+Y21kcHRyOwogCkBA
IC0xMTQxLDEzICsxMTQwLDkgQEAgc3RhdGljIGludCBzZXR1cF9kZXNjcyhzdHJ1Y3Qgc25kX2Ri
cmkgKgogCQlyZXR1cm4gLTE7CiAJfQogCi0JaWYgKHN0cmVhbW5vID09IERCUklfUExBWSkgewot
CQlkYnJpLT5kbWEtPmRlc2NbbGFzdF9kZXNjXS53b3JkMSB8PQotCQkgICAgREJSSV9URF9GIHwg
REJSSV9URF9COwotCQlkYnJpLT5kbWEtPmRlc2NbbGFzdF9kZXNjXS5uZGEgPQotCQkgICAgZGJy
aS0+ZG1hX2R2bWEgKyBkYnJpX2RtYV9vZmYoZGVzYywgZmlyc3RfZGVzYyk7Ci0JCWRicmktPm5l
eHRfZGVzY1tsYXN0X2Rlc2NdID0gZmlyc3RfZGVzYzsKLQl9CisJZGJyaS0+ZG1hLT5kZXNjW2xh
c3RfZGVzY10ubmRhID0KKwkgICAgZGJyaS0+ZG1hX2R2bWEgKyBkYnJpX2RtYV9vZmYoZGVzYywg
Zmlyc3RfZGVzYyk7CisJZGJyaS0+bmV4dF9kZXNjW2xhc3RfZGVzY10gPSBmaXJzdF9kZXNjOwog
CWRicmktPnBpcGVzW2luZm8tPnBpcGVdLmZpcnN0X2Rlc2MgPSBmaXJzdF9kZXNjOwogCWRicmkt
PnBpcGVzW2luZm8tPnBpcGVdLmRlc2MgPSBmaXJzdF9kZXNjOwogCkBAIC0xNjM5LDcgKzE2MzQs
NiBAQCBzdGF0aWMgdm9pZCB4bWl0X2Rlc2NzKHN0cnVjdCBzbmRfZGJyaSAqCiAJaWYgKGRicmkg
PT0gTlVMTCkKIAkJcmV0dXJuOwkJLyogRGlzYWJsZWQgKi8KIAotCS8qIEZpcnN0IGNoZWNrIHRo
ZSByZWNvcmRpbmcgc3RyZWFtIGZvciBidWZmZXIgb3ZlcmZsb3cgKi8KIAlpbmZvID0gJmRicmkt
PnN0cmVhbV9pbmZvW0RCUklfUkVDXTsKIAlzcGluX2xvY2tfaXJxc2F2ZSgmZGJyaS0+bG9jaywg
ZmxhZ3MpOwogCkBAIC0xNjQ5LDI3ICsxNjQzLDIwIEBAIHN0YXRpYyB2b2lkIHhtaXRfZGVzY3Mo
c3RydWN0IHNuZF9kYnJpICoKIAkJZHByaW50ayhEX0RFU0MsICJ4bWl0X2Rlc2NzIHJlYyBAIFRE
ICVkXG4iLCBmaXJzdF90ZCk7CiAKIAkJLyogU3RyZWFtIGNvdWxkIGJlIGNsb3NlZCBieSB0aGUg
dGltZSB3ZSBydW4uICovCi0JCWlmIChmaXJzdF90ZCA8IDApIHsKLQkJCWdvdG8gcGxheTsKLQkJ
fQotCi0JCWNtZCA9IGRicmlfY21kbG9jayhkYnJpLCAyKTsKLQkJKihjbWQrKykgPSBEQlJJX0NN
RChEX1NEUCwgMCwKLQkJCQkgICAgZGJyaS0+cGlwZXNbaW5mby0+cGlwZV0uc2RwCi0JCQkJICAg
IHwgRF9TRFBfUCB8IERfU0RQX0VWRVJZIHwgRF9TRFBfQyk7Ci0JCSooY21kKyspID0gZGJyaS0+
ZG1hX2R2bWEgKyBkYnJpX2RtYV9vZmYoZGVzYywgZmlyc3RfdGQpOwotCQlkYnJpX2NtZHNlbmQo
ZGJyaSwgY21kLCAyKTsKKwkJaWYgKGZpcnN0X3RkID49IDApIHsKKwkJCWNtZCA9IGRicmlfY21k
bG9jayhkYnJpLCAyKTsKKwkJCSooY21kKyspID0gREJSSV9DTUQoRF9TRFAsIDAsCisJCQkJCSAg
ICBkYnJpLT5waXBlc1tpbmZvLT5waXBlXS5zZHAKKwkJCQkJICAgIHwgRF9TRFBfUCB8IERfU0RQ
X0VWRVJZIHwgRF9TRFBfQyk7CisJCQkqKGNtZCsrKSA9IGRicmktPmRtYV9kdm1hICsgZGJyaV9k
bWFfb2ZmKGRlc2MsIGZpcnN0X3RkKTsKKwkJCWRicmlfY21kc2VuZChkYnJpLCBjbWQsIDIpOwog
Ci0JCS8qIFJlc2V0IG91ciBhZG1pbiBvZiB0aGUgcGlwZSAmIGJ5dGVzIHJlYWQuICovCi0JCWRi
cmktPnBpcGVzW2luZm8tPnBpcGVdLmRlc2MgPSBmaXJzdF90ZDsKKwkJCS8qIFJlc2V0IG91ciBh
ZG1pbiBvZiB0aGUgcGlwZS4gKi8KKwkJCWRicmktPnBpcGVzW2luZm8tPnBpcGVdLmRlc2MgPSBm
aXJzdF90ZDsKKwkJfQogCX0KIAotcGxheToKLQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkYnJp
LT5sb2NrLCBmbGFncyk7Ci0KLQkvKiBOb3cgY2hlY2sgdGhlIHBsYXliYWNrIHN0cmVhbSBmb3Ig
YnVmZmVyIHVuZGVyZmxvdyAqLwogCWluZm8gPSAmZGJyaS0+c3RyZWFtX2luZm9bREJSSV9QTEFZ
XTsKLQlzcGluX2xvY2tfaXJxc2F2ZSgmZGJyaS0+bG9jaywgZmxhZ3MpOwogCiAJaWYgKGluZm8t
PnBpcGUgPj0gMCkgewogCQlmaXJzdF90ZCA9IGRicmktPnBpcGVzW2luZm8tPnBpcGVdLmZpcnN0
X2Rlc2M7CkBAIC0xNjg1LDcgKzE2NzIsNyBAQCBwbGF5OgogCQkJKihjbWQrKykgPSBkYnJpLT5k
bWFfZHZtYSArIGRicmlfZG1hX29mZihkZXNjLCBmaXJzdF90ZCk7CiAJCQlkYnJpX2NtZHNlbmQo
ZGJyaSwgY21kLCAyKTsKIAotCQkJLyogUmVzZXQgb3VyIGFkbWluIG9mIHRoZSBwaXBlICYgYnl0
ZXMgd3JpdHRlbi4gKi8KKwkJCS8qIFJlc2V0IG91ciBhZG1pbiBvZiB0aGUgcGlwZS4gKi8KIAkJ
CWRicmktPnBpcGVzW2luZm8tPnBpcGVdLmRlc2MgPSBmaXJzdF90ZDsKIAkJfQogCX0KQEAgLTE3
NTUsNyArMTc0Miw2IEBAIHN0YXRpYyB2b2lkIHJlY2VwdGlvbl9jb21wbGV0ZV9pbnRyKHN0cnUK
IAkJcmV0dXJuOwogCX0KIAotCWRicmktPmRtYS0+ZGVzY1tyZF0uYmEgPSAwOwogCWRicmktPnBp
cGVzW3BpcGVdLmRlc2MgPSBkYnJpLT5uZXh0X2Rlc2NbcmRdOwogCXN0YXR1cyA9IGRicmktPmRt
YS0+ZGVzY1tyZF0ud29yZDE7CiAJZGJyaS0+ZG1hLT5kZXNjW3JkXS53b3JkMSA9IDA7CS8qIFJl
c2V0IGl0IGZvciBuZXh0IHRpbWUuICovCkBAIC0xNzY4LDE4ICsxNzU0LDYgQEAgc3RhdGljIHZv
aWQgcmVjZXB0aW9uX2NvbXBsZXRlX2ludHIoc3RydQogCWRwcmludGsoRF9JTlQsICJSZWN2IFJE
ICVkLCBzdGF0dXMgMHglMDJ4LCBsZW4gJWRcbiIsCiAJCXJkLCBEQlJJX1JEX1NUQVRVUyhzdGF0
dXMpLCBEQlJJX1JEX0NOVChzdGF0dXMpKTsKIAotCS8qIE9uIHRoZSBsYXN0IFRELCB0cmFuc21p
dCB0aGVtIGFsbCBhZ2Fpbi4gKi8KLSNpZiAwCi0JaWYgKGRicmktPm5leHRfZGVzY1tyZF0gPT0g
LTEpIHsKLQkJaWYgKGluZm8tPmxlZnQgPiBpbmZvLT5zaXplKSB7Ci0JCQlwcmludGsoS0VSTl9X
QVJOSU5HCi0JCQkgICAgICAgIiVkIGJ5dGVzIHJlY29yZGVkIGluICVkIHNpemUgYnVmZmVyLlxu
IiwKLQkJCSAgICAgICBpbmZvLT5sZWZ0LCBpbmZvLT5zaXplKTsKLQkJfQotCQl0YXNrbGV0X3Nj
aGVkdWxlKCZ4bWl0X2Rlc2NzX3Rhc2spOwotCX0KLSNlbmRpZgotCiAJLyogTm90aWZ5IEFMU0Eg
Ki8KIAlpZiAoc3Bpbl9pc19sb2NrZWQoJmRicmktPmxvY2spKSB7CiAJCXNwaW5fdW5sb2NrKCZk
YnJpLT5sb2NrKTsKQEAgLTIxMTMsNiArMjA4Nyw3IEBAIHN0YXRpYyBpbnQgc25kX2RicmlfcHJl
cGFyZShzdHJ1Y3Qgc25kX3AKIAkJaW5mby0+cGlwZSA9IDY7CS8qIFJlY2VpdmUgcGlwZSAqLwog
CiAJc3Bpbl9sb2NrX2lycSgmZGJyaS0+bG9jayk7CisJaW5mby0+b2Zmc2V0ID0gMDsKIAogCS8q
IFNldHVwIHRoZSBhbGwgdGhlIHRyYW5zbWl0L3JlY2VpdmUgZGVzY2lwdG9ycyB0byBjb3ZlciB0
aGUKIAkgKiB3aG9sZSBETUEgYnVmZmVyLgo=

--part44ef3a2db03f0--




--===============0907351649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0907351649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0907351649==--
