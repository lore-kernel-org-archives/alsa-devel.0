From: Tony Vroon <tony@linx.net>
Subject: #2 [ALC262 patch_realtek.c] Fujitsu Lifebook port
	replicator/dock	headphone jack sense
Date: Fri, 14 Mar 2008 15:15:08 +0000
Message-ID: <1205507708.5407.21.camel@localhost>
References: <1205501568.5407.19.camel@localhost> <s5hy78ls9o7.wl%tiwai@suse.de>
Reply-To: tony@linx.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6295105240847120233=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bronze.linx.net (bronze.linx.net [195.66.232.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FBE024481
	for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2008 16:16:20 +0100 (CET)
In-Reply-To: <s5hy78ls9o7.wl%tiwai@suse.de>
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


--===============6295105240847120233==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-77qir8Knn9U5dkCT4+/t"


--=-77qir8Knn9U5dkCT4+/t
Content-Type: multipart/mixed; boundary="=-EHpqs53SDMBVVSA8boqA"


--=-EHpqs53SDMBVVSA8boqA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Good afternoon,

Could you please consider the following patch for the 2.6.26 merge
window. The docking station headphone output had no audio and jack sense
was not considered.

Jack information from the laptop itself and the dock are combined, as
the dock does not obscure the connector. This is version 2 of this
patch, incorporating feedback by Takashi Iwai.

Signed-Off-By: Tony Vroon <tony@linx.net>

Regards,
Tony V.
LINX sysadmin

--=-EHpqs53SDMBVVSA8boqA
Content-Disposition: attachment; filename=fujitsu-alc262-dock.git.diff
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=fujitsu-alc262-dock.git.diff; charset=UTF-8

ZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jIGIvc291bmQvcGNpL2hk
YS9wYXRjaF9yZWFsdGVrLmMNCmluZGV4IDMzMjgyZjkuLmQzZjU2NTQgMTAwNjQ0DQotLS0gYS9z
b3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYw0KKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9y
ZWFsdGVrLmMNCkBAIC04NTg1LDcgKzg1ODUsOCBAQCBzdGF0aWMgdm9pZCBhbGMyNjJfaGlwcG8x
X3Vuc29sX2V2ZW50KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjLA0KIA0KIC8qDQogICogZnVqaXRz
dSBtb2RlbA0KLSAqICAweDE0ID0gaGVhZHBob25lL3NwZGlmLW91dCwgMHgxNSA9IGludGVybmFs
IHNwZWFrZXINCisgKiAgMHgxNCA9IGhlYWRwaG9uZS9zcGRpZi1vdXQsIDB4MTUgPSBpbnRlcm5h
bCBzcGVha2VyLA0KKyAqICAweDFiID0gcG9ydCByZXBsaWNhdG9yIGhlYWRwaG9uZSBvdXQNCiAg
Ki8NCiANCiAjZGVmaW5lIEFMQ19IUF9FVkVOVAkweDM3DQpAQCAtODU5Myw2ICs4NTk0LDggQEAg
c3RhdGljIHZvaWQgYWxjMjYyX2hpcHBvMV91bnNvbF9ldmVudChzdHJ1Y3QgaGRhX2NvZGVjICpj
b2RlYywNCiBzdGF0aWMgc3RydWN0IGhkYV92ZXJiIGFsYzI2Ml9mdWppdHN1X3Vuc29sX3ZlcmJz
W10gPSB7DQogCXsweDE0LCBBQ19WRVJCX1NFVF9VTlNPTElDSVRFRF9FTkFCTEUsIEFDX1VTUlNQ
X0VOIHwgQUxDX0hQX0VWRU5UfSwNCiAJezB4MTQsIEFDX1ZFUkJfU0VUX1BJTl9XSURHRVRfQ09O
VFJPTCwgUElOX0hQfSwNCisJezB4MWIsIEFDX1ZFUkJfU0VUX1VOU09MSUNJVEVEX0VOQUJMRSwg
QUNfVVNSU1BfRU4gfCBBTENfSFBfRVZFTlR9LA0KKwl7MHgxYiwgQUNfVkVSQl9TRVRfUElOX1dJ
REdFVF9DT05UUk9MLCBQSU5fSFB9LA0KIAl7fQ0KIH07DQogDQpAQCAtODYzMywxMiArODYzNiwx
NiBAQCBzdGF0aWMgdm9pZCBhbGMyNjJfZnVqaXRzdV9hdXRvbXV0ZShzdHJ1Y3QgaGRhX2NvZGVj
ICpjb2RlYywgaW50IGZvcmNlKQ0KIAl1bnNpZ25lZCBpbnQgbXV0ZTsNCiANCiAJaWYgKGZvcmNl
IHx8ICFzcGVjLT5zZW5zZV91cGRhdGVkKSB7DQotCQl1bnNpZ25lZCBpbnQgcHJlc2VudDsNCisJ
CXVuc2lnbmVkIGludCBwcmVzZW50X2ludF9ocCwgcHJlc2VudF9kb2NrX2hwOw0KIAkJLyogbmVl
ZCB0byBleGVjdXRlIGFuZCBzeW5jIGF0IGZpcnN0ICovDQogCQlzbmRfaGRhX2NvZGVjX3JlYWQo
Y29kZWMsIDB4MTQsIDAsIEFDX1ZFUkJfU0VUX1BJTl9TRU5TRSwgMCk7DQotCQlwcmVzZW50ID0g
c25kX2hkYV9jb2RlY19yZWFkKGNvZGVjLCAweDE0LCAwLA0KKwkJcHJlc2VudF9pbnRfaHAgPSBz
bmRfaGRhX2NvZGVjX3JlYWQoY29kZWMsIDB4MTQsIDAsDQogCQkJCSAgICAJIEFDX1ZFUkJfR0VU
X1BJTl9TRU5TRSwgMCk7DQotCQlzcGVjLT5qYWNrX3ByZXNlbnQgPSAocHJlc2VudCAmIDB4ODAw
MDAwMDApICE9IDA7DQorCQlzbmRfaGRhX2NvZGVjX3JlYWQoY29kZWMsIDB4MUIsIDAsIEFDX1ZF
UkJfU0VUX1BJTl9TRU5TRSwgMCk7DQorCQlwcmVzZW50X2RvY2tfaHAgPSBzbmRfaGRhX2NvZGVj
X3JlYWQoY29kZWMsIDB4MWIsIDAsDQorCQkJCSAgICAJIEFDX1ZFUkJfR0VUX1BJTl9TRU5TRSwg
MCk7DQorCQlzcGVjLT5qYWNrX3ByZXNlbnQgPSAocHJlc2VudF9pbnRfaHAgJiAweDgwMDAwMDAw
KSAhPSAwOw0KKwkJc3BlYy0+amFja19wcmVzZW50IHw9IChwcmVzZW50X2RvY2tfaHAgJiAweDgw
MDAwMDAwKSAhPSAwOw0KIAkJc3BlYy0+c2Vuc2VfdXBkYXRlZCA9IDE7DQogCX0NCiAJaWYgKHNw
ZWMtPmphY2tfcHJlc2VudCkgew0KQEAgLTg2ODAsMTIgKzg2ODcsMTMgQEAgc3RhdGljIGludCBh
bGMyNjJfZnVqaXRzdV9tYXN0ZXJfc3dfcHV0KHN0cnVjdCBzbmRfa2NvbnRyb2wgKmtjb250cm9s
LA0KIAlsb25nICp2YWxwID0gdWNvbnRyb2wtPnZhbHVlLmludGVnZXIudmFsdWU7DQogCWludCBj
aGFuZ2U7DQogDQotCWNoYW5nZSA9IHNuZF9oZGFfY29kZWNfYW1wX3VwZGF0ZShjb2RlYywgMHgx
NCwgMCwgSERBX09VVFBVVCwgMCwNCi0JCQkJCSAgSERBX0FNUF9NVVRFLA0KLQkJCQkJICB2YWxw
WzBdID8gMCA6IEhEQV9BTVBfTVVURSk7DQotCWNoYW5nZSB8PSBzbmRfaGRhX2NvZGVjX2FtcF91
cGRhdGUoY29kZWMsIDB4MTQsIDEsIEhEQV9PVVRQVVQsIDAsDQotCQkJCQkgICBIREFfQU1QX01V
VEUsDQotCQkJCQkgICB2YWxwWzFdID8gMCA6IEhEQV9BTVBfTVVURSk7DQorCWNoYW5nZSA9IHNu
ZF9oZGFfY29kZWNfYW1wX3N0ZXJlbyhjb2RlYywgMHgxNCwgSERBX09VVFBVVCwgMCwNCisJCQkJ
CQkgSERBX0FNUF9NVVRFLA0KKwkJCQkJCSB2YWxwID8gMCA6IEhEQV9BTVBfTVVURSk7DQorCWNo
YW5nZSB8PSBzbmRfaGRhX2NvZGVjX2FtcF9zdGVyZW8oY29kZWMsIDB4MWIsIEhEQV9PVVRQVVQs
IDAsDQorCQkJCQkJIEhEQV9BTVBfTVVURSwNCisJCQkJCQkgdmFscCA/IDAgOiBIREFfQU1QX01V
VEUpOw0KKw0KIAlpZiAoY2hhbmdlKQ0KIAkJYWxjMjYyX2Z1aml0c3VfYXV0b211dGUoY29kZWMs
IDApOw0KIAlyZXR1cm4gY2hhbmdlOw0K


--=-EHpqs53SDMBVVSA8boqA--

--=-77qir8Knn9U5dkCT4+/t
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQBH2pZ8p5vW4rUFj5oRAia5AKCcf3XGTxc7C/ENuNvxSs/WTApTywCgmtK9
NNRhbdDWFUlztu5EHqOTQMs=
=gGIT
-----END PGP SIGNATURE-----

--=-77qir8Knn9U5dkCT4+/t--


--===============6295105240847120233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6295105240847120233==--
