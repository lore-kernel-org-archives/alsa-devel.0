From: "Stephen Warren" <SWarren@nvidia.com>
Subject: Proposed changes to azx/patch_realtek.c
Date: Wed, 15 Dec 2004 09:21:25 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B0033AE3D9@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4E2CA.81A7B391"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4E2CA.81A7B391
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello.

I'm working on updating the Azalia audio driver (ALC880 codec) to
support a new PCB with different routing of codec pins to connectors.

As part of this, I took a look at patch_realtek.c and have a few
suggestions on how to simplify things.

As an example of this, I've attached a patch. This isolates and
knowledge of the "board type" to the patch_alc880 function. All
decisions based on the board type are made here, and written into
configuration variables in the spec structure. Then, all other functions
simply pull values out of the spec structure and use them, so they don't
have to have a bunch of code that's conditional on board type, which
could grow unmanageably.

See the attached patch for this change.

Going forward, I'd like to make the following changes:

1)

patch_alc880 fills in the spec structure at run-time. Instead, I'd like
a set of pre-filled-in structures to be part of the driver, and
patch_alc880 just initializes codec->spec to point at one (just like it
currently initializes spec->init_seq to point at a specific list of
initialization instructions with my patch).

Benefit: Can support new boards simply by defining a new pre-defined
data structure and ALC880_xxx enumeration value - no need to actually
edit code in patch_alc880 for this.

2)

Unify 880 and 260 support.

Much of the code for 880 and 260 is very similar - for example,
alc880_build_controls and alc260_build_controls are the same function,
except that (if we use just the 880 code) we would hard-code
spec->build_side_mixer=3D0 and spec->digital=3D0, and have to =
parameterize
the function by putting a pointer to either alc880_base_mixer or
alc260_base_mixer into the spec structure.

Benefit: Identical code for 880 and 260 reduces duplication. Can
configure differences between codecs/boards just by editing the
pre-initialized spec structure values.

I expect to have to define my own xxx_base_mixer function for the PCB
I'm supporting.

3)

Finally add support for my PCB by defining new data structures using the
above features.

Does this all sound like a good idea, and is it something that could be
merged back into the official driver?

Thanks for any comments.

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html

------_=_NextPart_001_01C4E2CA.81A7B391
Content-Type: application/octet-stream;
	name="realtek.diff"
Content-Transfer-Encoding: base64
Content-Description: realtek.diff
Content-Disposition: attachment;
	filename="realtek.diff"

LS0tIHBhdGNoX3JlYWx0ZWsuYy5vcmlnCTIwMDQtMTItMTUgMDQ6MzA6NDcuODg3NDQxMDE2IC0w
NzAwCisrKyBwYXRjaF9yZWFsdGVrLmMJMjAwNC0xMi0xNSAwNDo0Njo1Ni41MjAxODY0NTYgLTA3
MDAKQEAgLTM5LDEwICszOSwxMiBAQAogfTsKIAogc3RydWN0IGFsY19zcGVjIHsKLQlpbnQgYm9h
cmRfY29uZmlnOwogCXN0cnVjdCBoZGFfaW5wdXRfbXV4ICppbnB1dF9tdXg7CiAJdW5zaWduZWQg
aW50IGZyb250X3BhbmVsOiAxOwogCXVuc2lnbmVkIGludCBkaWdpdGFsOiAxOworICAgICAgICB1
bnNpZ25lZCBpbnQgYnVpbGRfc2lkZV9taXhlcjogMTsKKyAgICAgICAgdW5zaWduZWQgaW50IGNo
YW5uZWxzX21heDsKKyAgICAgICAgY29uc3Qgc3RydWN0IGhkYV92ZXJiICppbml0X3NlcTsKIAl1
bnNpZ25lZCBpbnQgbnVtX2RhY19uaWRzOwogCWhkYV9uaWRfdCAqZGFjX25pZHM7CiAJdW5zaWdu
ZWQgaW50IG51bV9hZGNfbmlkczsKIHN0YXRpYyBzdHJ1Y3QgYWxjX2NoYW5uZWxfbW9kZSBmaXZl
c3RhY2tfbW9kZXMgPSB7CiAJLmNoYW5uZWxzID0geyA2LCA4IH0sCiAJLnNlcXVlbmNlcyA9IHsg
Zml2ZXN0YWNrX2NoNl9pbml0LCBmaXZlc3RhY2tfY2g4X2luaXQgfQpAQCAtMzYxLDcgKzM2Myw3
IEBACiAJCQkJICAgQVJSQVlfU0laRShhbGM4ODBfYmFzZV9taXhlcikpOwogCWlmIChlcnIgPCAw
KQogCQlyZXR1cm4gZXJyOwotCWlmIChzcGVjLT5ib2FyZF9jb25maWcgPT0gQUxDODgwXzVTVCB8
fCBzcGVjLT5ib2FyZF9jb25maWcgPT0gQUxDODgwXzVTVF9ESUcpIHsKKwlpZiAoc3BlYy0+YnVp
bGRfc2lkZV9taXhlcikgewogCQllcnIgPSBwYXRjaF9idWlsZF9jb250cm9scyhjb2RlYywgYWxj
ODgwX3NpZGVfbWl4ZXIsCiAJCQkJCSAgIEFSUkFZX1NJWkUoYWxjODgwX3NpZGVfbWl4ZXIpKTsK
IAkJaWYgKGVyciA8IDApCkBAIC01MzMsMTAgKzUzNSw5IEBACiBzdGF0aWMgaW50IGFsYzg4MF9p
bml0KHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjKQogewogCXN0cnVjdCBhbGNfc3BlYyAqc3BlYyA9
IGNvZGVjLT5zcGVjOwotCWlmIChzcGVjLT5ib2FyZF9jb25maWcgPT0gQUxDODgwXzVTVCB8fCBz
cGVjLT5ib2FyZF9jb25maWcgPT0gQUxDODgwXzVTVF9ESUcpCi0JCXNuZF9oZGFfc2VxdWVuY2Vf
d3JpdGUoY29kZWMsIGFsYzg4MF9maXZlX3N0YWNrX3ZvbHVtZSk7Ci0JZWxzZQotCQlzbmRfaGRh
X3NlcXVlbmNlX3dyaXRlKGNvZGVjLCBhbGM4ODBfdGhyZWVfc3RhY2tfdm9sdW1lKTsKKworCXNu
ZF9oZGFfc2VxdWVuY2Vfd3JpdGUoY29kZWMsIHNwZWMtPmluaXRfc2VxKTsKKwogCXJldHVybiAw
OwogfQogCkBAIC02OTMsMTEgKzY5NCw3IEBACiAJaW5mby0+bmFtZSA9ICJBTEM4ODAgQW5hbG9n
IjsKIAlpbmZvLT5zdHJlYW1bU05EUlZfUENNX1NUUkVBTV9QTEFZQkFDS10gPSBhbGM4ODBfcGNt
X2FuYWxvZ19wbGF5YmFjazsKIAlpbmZvLT5zdHJlYW1bU05EUlZfUENNX1NUUkVBTV9DQVBUVVJF
XSA9IGFsYzg4MF9wY21fYW5hbG9nX2NhcHR1cmU7Ci0KLQlpZiAoc3BlYy0+Ym9hcmRfY29uZmln
ID09IEFMQzg4MF81U1QgfHwgc3BlYy0+Ym9hcmRfY29uZmlnID09IEFMQzg4MF81U1RfRElHKQot
CQlpbmZvLT5zdHJlYW1bU05EUlZfUENNX1NUUkVBTV9QTEFZQkFDS10uY2hhbm5lbHNfbWF4ID0g
ODsKLQllbHNlCi0JCWluZm8tPnN0cmVhbVtTTkRSVl9QQ01fU1RSRUFNX1BMQVlCQUNLXS5jaGFu
bmVsc19tYXggPSA2OworCWluZm8tPnN0cmVhbVtTTkRSVl9QQ01fU1RSRUFNX1BMQVlCQUNLXS5j
aGFubmVsc19tYXggPSBzcGVjLT5jaGFubmVsc19tYXg7CiAKIAlyZXR1cm4gMDsKIH0KQEAgLTc5
MSwxNCArNzg4LDE3IEBACiBzdGF0aWMgaW50IHBhdGNoX2FsYzg4MChzdHJ1Y3QgaGRhX2NvZGVj
ICpjb2RlYykKIHsKIAlzdHJ1Y3QgYWxjX3NwZWMgKnNwZWM7CisJaW50IGJvYXJkX2NvbmZpZzsK
IAogCXNwZWMgPSBrY2FsbG9jKDEsIHNpemVvZigqc3BlYyksIEdGUF9LRVJORUwpOwogCWlmIChz
cGVjID09IE5VTEwpCiAJCXJldHVybiAtRU5PTUVNOwogCiAJY29kZWMtPnNwZWMgPSBzcGVjOwot
CXNwZWMtPmJvYXJkX2NvbmZpZyA9IHNuZF9oZGFfY2hlY2tfYm9hcmRfY29uZmlnKGNvZGVjLCBh
bGM4ODBfY2ZnX3RibCk7Ci0Jc3dpdGNoIChzcGVjLT5ib2FyZF9jb25maWcpIHsKKworCWJvYXJk
X2NvbmZpZyA9IHNuZF9oZGFfY2hlY2tfYm9hcmRfY29uZmlnKGNvZGVjLCBhbGM4ODBfY2ZnX3Ri
bCk7CisKKwlzd2l0Y2ggKGJvYXJkX2NvbmZpZykgewogCWNhc2UgQUxDODgwXzNTVF9ESUc6CiAJ
Y2FzZSBBTEM4ODBfNVNUX0RJRzoKIAkJc3BlYy0+ZGlnaXRhbCA9IDE7CkBAIC04MDksMTIgKzgw
OSwyNSBAQAogCQlzcGVjLT5mcm9udF9wYW5lbCA9IDE7CiAJCWJyZWFrOwogCX0KLQlpZiAoc3Bl
Yy0+Ym9hcmRfY29uZmlnID09IEFMQzg4MF81U1QgfHwgc3BlYy0+Ym9hcmRfY29uZmlnID09IEFM
Qzg4MF81U1RfRElHKSB7CisKKwlzd2l0Y2ggKGJvYXJkX2NvbmZpZykgeworCWNhc2UgQUxDODgw
XzVTVDoKKwljYXNlIEFMQzg4MF81U1RfRElHOgogCQlzcGVjLT5jaGFubmVsX3NldHRpbmcgPSA2
OworCQlzcGVjLT5jaGFubmVsc19tYXggPSA4OwogCQlzcGVjLT5jaGFubmVsX21vZGUgPSAmZml2
ZXN0YWNrX21vZGVzOwotCX0gZWxzZSB7CisJCXNwZWMtPmJ1aWxkX3NpZGVfbWl4ZXIgPSAxOwor
CQlzcGVjLT5pbml0X3NlcSA9IGFsYzg4MF9maXZlX3N0YWNrX3ZvbHVtZTsKKwkJYnJlYWs7CisJ
Y2FzZSBBTFM4ODBfM1NUOgorCWNhc2UgQUxTODgwXzVTVDoKKwlkZWZhdWx0OgogCQlzcGVjLT5j
aGFubmVsX3NldHRpbmcgPSAyOworCQlzcGVjLT5jaGFubmVsc19tYXggPSA2OwogCQlzcGVjLT5j
aGFubmVsX21vZGUgPSAmdGhyZWVzdGFja19tb2RlczsKKwkJc3BlYy0+YnVpbGRfc2lkZV9taXhl
ciA9IDA7CisJCXNwZWMtPmluaXRfc2VxID0gYWxjODgwX3RocmVlX3N0YWNrX3ZvbHVtZTsKKwkJ
YnJlYWs7CiAJfQogCiAJc3BlYy0+aW5wdXRfbXV4ID0gJmFsYzg4MF9jYXB0dXJlX3NvdXJjZTsK

------_=_NextPart_001_01C4E2CA.81A7B391--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
