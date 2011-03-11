From: Chih-Wei Huang <cwhuang@linux.org.tw>
Subject: Re: Fix for recording issue of ASUS N82JV
Date: Fri, 11 Mar 2011 09:34:22 +0800
Message-ID: <4D797C1E.5060609@linux.org.tw>
References: <4D672B85.9020603@linux.org.tw>	<4D6CA1AB.30403@linux.org.tw>
	<s5hvd03feva.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000101090106090506030905"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.linux.org.tw (n201.enc.hlc.edu.tw [210.240.39.201])
	by alsa0.perex.cz (Postfix) with SMTP id 944BE1037EE
	for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2011 02:34:44 +0100 (CET)
In-Reply-To: <s5hvd03feva.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Kailang Yang <kailang@realtek.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000101090106090506030905
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Takashi,
Thank you for the help.

Here are more patches for realtek codec
to support old Eee PC models 900 and 1004.

Regards,
--
Chih-Wei
Android-x86 project
http://www.android-x86.org

=E6=96=BC =E8=A5=BF=E5=85=832011=E5=B9=B403=E6=9C=8801=E6=97=A5 16:02, Ta=
kashi Iwai =E6=8F=90=E5=88=B0:
> At Tue, 01 Mar 2011 15:35:07 +0800,
> Chih-Wei Huang wrote:
>> Hi,
>> This small patch fixes the unable to record issue
>> on ASUS N82JV. Thanks.
>>
>> Tested OK on android-x86 2.2 &  2.3 with kernel 2.6.38-rc4.
>
> Thanks, applied now.

--------------000101090106090506030905
Content-Type: text/plain;
 name="0001-ALSA-add-audio-support-for-Eee-PC-900.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-ALSA-add-audio-support-for-Eee-PC-900.patch"

RnJvbSA2MjMzMTdhNDExMTE2ZmJlMjQ4NDVmODA5YTE0ZmJhYjQ2YzRiMzY3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaGloLVdlaSBIdWFuZyA8Y3dodWFuZ0BsaW51eC5v
cmcudHc+CkRhdGU6IFRodSwgMTYgSnVsIDIwMDkgMTA6MDU6MjIgKzA4MDAKU3ViamVjdDog
W1BBVENIIDEvMl0gQUxTQTogSERBOiBhdWRpbyBzdXBwb3J0IGZvciBFZWUgUEMgOTAwCgot
LS0KIHNvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIHwgICAxNyArKysrKysrKysrKysr
KysrKwogMSBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIGIvc291bmQv
cGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKaW5kZXggMzMyOGEyNS4uMmRkNTJjNiAxMDA2NDQK
LS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMKKysrIGIvc291bmQvcGNpL2hk
YS9wYXRjaF9yZWFsdGVrLmMKQEAgLTE4MCw2ICsxODAsNyBAQCBlbnVtIHsKIAlBTEM2NjJf
NVNUX0RJRywKIAlBTEM2NjJfTEVOT1ZPXzEwMUUsCiAJQUxDNjYyX0FTVVNfRUVFUENfUDcw
MSwKKwlBTEM2NjJfQVNVU19FRUVQQ19QOTAwLAogCUFMQzY2Ml9BU1VTX0VFRVBDX0VQMjAs
CiAJQUxDNjYzX0FTVVNfTTUxVkEsCiAJQUxDNjYzX0FTVVNfRzcxViwKQEAgLTE4NzI3LDYg
KzE4NzI4LDcgQEAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBhbGM2NjJfbW9kZWxzW0FM
QzY2Ml9NT0RFTF9MQVNUXSA9IHsKIAlbQUxDNjYyXzVTVF9ESUddCT0gIjZzdGFjay1kaWci
LAogCVtBTEM2NjJfTEVOT1ZPXzEwMUVdCT0gImxlbm92by0xMDFlIiwKIAlbQUxDNjYyX0FT
VVNfRUVFUENfUDcwMV0gPSAiZWVlcGMtcDcwMSIsCisJW0FMQzY2Ml9BU1VTX0VFRVBDX1A5
MDBdID0gImVlZXBjLXA5MDAiLAogCVtBTEM2NjJfQVNVU19FRUVQQ19FUDIwXSA9ICJlZWVw
Yy1lcDIwIiwKIAlbQUxDNjYyX0VDU10gPSAiZWNzIiwKIAlbQUxDNjYzX0FTVVNfTTUxVkFd
ID0gIm01MXZhIiwKQEAgLTE4ODA5LDYgKzE4ODExLDcgQEAgc3RhdGljIHN0cnVjdCBzbmRf
cGNpX3F1aXJrIGFsYzY2Ml9jZmdfdGJsW10gPSB7CiAJU05EX1BDSV9RVUlSSygweDEwNDMs
IDB4MTlmMywgIkFTVVMgTkIiLCBBTEM2NjNfQVNVU19NT0RFNCksCiAJU05EX1BDSV9RVUlS
SygweDEwNDMsIDB4ODI5MCwgIkFTVVMgUDVHQy1NWCIsIEFMQzY2Ml8zU1RfNmNoX0RJRyks
CiAJU05EX1BDSV9RVUlSSygweDEwNDMsIDB4ODJhMSwgIkFTVVMgRWVlcGMiLCBBTEM2NjJf
QVNVU19FRUVQQ19QNzAxKSwKKwlTTkRfUENJX1FVSVJLKDB4MTA0MywgMHg4MzM3LCAiQVNV
UyBFZWVwYyBQOTAwIiwgQUxDNjYyX0FTVVNfRUVFUENfUDkwMCksCiAJU05EX1BDSV9RVUlS
SygweDEwNDMsIDB4ODJkMSwgIkFTVVMgRWVlcGMgRVAyMCIsIEFMQzY2Ml9BU1VTX0VFRVBD
X0VQMjApLAogCVNORF9QQ0lfUVVJUksoMHgxMDViLCAweDBjZDYsICJGb3hjb25uIiwgQUxD
NjYyX0VDUyksCiAJU05EX1BDSV9RVUlSSygweDEwNWIsIDB4MGQ0NywgIkZveGNvbm4gNDVD
TVgvNDVHTVgvNDVDTVgtSyIsCkBAIC0xODg5Nyw2ICsxODkwMCwyMCBAQCBzdGF0aWMgc3Ry
dWN0IGFsY19jb25maWdfcHJlc2V0IGFsYzY2Ml9wcmVzZXRzW10gPSB7CiAJCS5zZXR1cCA9
IGFsYzY2Ml9lZWVwY19zZXR1cCwKIAkJLmluaXRfaG9vayA9IGFsYzY2Ml9lZWVwY19pbml0
aG9vaywKIAl9LAorCVtBTEM2NjJfQVNVU19FRUVQQ19QOTAwXSA9IHsKKwkJLm1peGVycyA9
IHsgYWxjNjYyX2VlZXBjX3A3MDFfbWl4ZXIgfSwKKwkJLmluaXRfdmVyYnMgPSB7IGFsYzY2
Ml9pbml0X3ZlcmJzLAorCQkJCWFsYzY2Ml9lZWVwY19zdWVfaW5pdF92ZXJicyB9LAorCQku
bnVtX2RhY3MgPSBBUlJBWV9TSVpFKGFsYzY2Ml9kYWNfbmlkcyksCisJCS5kYWNfbmlkcyA9
IGFsYzY2Ml9kYWNfbmlkcywKKwkJLm51bV9hZGNfbmlkcyA9IEFSUkFZX1NJWkUoYWxjODYx
dmRfYWRjX25pZHMpLAorCQkuYWRjX25pZHMgPSBhbGM2NjJfYWRjX25pZHMsCisJCS5udW1f
Y2hhbm5lbF9tb2RlID0gQVJSQVlfU0laRShhbGM2NjJfM1NUXzJjaF9tb2RlcyksCisJCS5j
aGFubmVsX21vZGUgPSBhbGM2NjJfM1NUXzJjaF9tb2RlcywKKwkJLnVuc29sX2V2ZW50ID0g
YWxjNjYyX2VlZXBjX3Vuc29sX2V2ZW50LAorCQkuc2V0dXAgPSBhbGM2NjJfZWVlcGNfc2V0
dXAsCisJCS5pbml0X2hvb2sgPSBhbGM2NjJfZWVlcGNfaW5pdGhvb2ssCisJfSwKIAlbQUxD
NjYyX0FTVVNfRUVFUENfRVAyMF0gPSB7CiAJCS5taXhlcnMgPSB7IGFsYzY2Ml9lZWVwY19l
cDIwX21peGVyLAogCQkJICAgIGFsYzY2Ml9jaG1vZGVfbWl4ZXIgfSwKLS0gCjEuNy40Cgo=
--------------000101090106090506030905
Content-Type: text/plain;
 name="0002-ALSA-add-audio-support-for-Eee-PC-1004.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0002-ALSA-add-audio-support-for-Eee-PC-1004.patch"

RnJvbSBhMWM3Y2I3N2U4ZWRiMGY2Yzg3OTU0NGZkZjQ1NDU4NDE2NzgxZjgxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaGloLVdlaSBIdWFuZyA8Y3dodWFuZ0BsaW51eC5v
cmcudHc+CkRhdGU6IFRodSwgMTYgSnVsIDIwMDkgMTQ6NDM6MDkgKzA4MDAKU3ViamVjdDog
W1BBVENIIDIvMl0gQUxTQTogSERBOiBhdWRpbyBzdXBwb3J0IGZvciBFZWUgUEMgMTAwNAoK
LS0tCiBzb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYyB8ICAgIDEgKwogMSBmaWxlcyBj
aGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
c291bmQvcGNpL2hkYS9wYXRjaF9yZWFsdGVrLmMgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3Jl
YWx0ZWsuYwppbmRleCAyZGQ1MmM2Li5lMWZlMGQxIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kv
aGRhL3BhdGNoX3JlYWx0ZWsuYworKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsu
YwpAQCAtMTUwNDcsNiArMTUwNDcsNyBAQCBzdGF0aWMgc3RydWN0IHNuZF9wY2lfcXVpcmsg
YWxjMjY5X2NmZ190YmxbXSA9IHsKIAkJICAgICAgQUxDMjY5X0RNSUMpLAogCVNORF9QQ0lf
UVVJUksoMHgxMDQzLCAweDgzNGEsICJBU1VTIEVlZXBjIFMxMDEiLAogCQkgICAgICBBTEMy
NjlfRE1JQyksCisJU05EX1BDSV9RVUlSSygweDEwNDMsIDB4ODNhNSwgIkFTVVMgRWVlcGMg
UDEwMDQiLCBBTEMyNjlfRE1JQyksCiAJU05EX1BDSV9RVUlSSygweDEwNDMsIDB4ODM5OCwg
IkFTVVMgUDEwMDVIQSIsIEFMQzI2OV9ETUlDKSwKIAlTTkRfUENJX1FVSVJLKDB4MTA0Mywg
MHg4M2NlLCAiQVNVUyBQMTAwNUhBIiwgQUxDMjY5X0RNSUMpLAogCVNORF9QQ0lfUVVJUkso
MHgxMDRkLCAweDkwNzEsICJTb255IFZBSU8iLCBBTEMyNjlfQVVUTyksCi0tIAoxLjcuNAoK

--------------000101090106090506030905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000101090106090506030905--
