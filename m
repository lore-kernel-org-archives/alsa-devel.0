From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix usb-* compiler warnings
Date: Mon, 08 Jul 2002 10:19:36 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D294B18.B5DDACCD@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_+USUkEhrOQrzI7L2mRb9FQ)"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Boundary_(ID_+USUkEhrOQrzI7L2mRb9FQ)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT


The compiler complains that usbaudio.c doesn't use snd_enable[].
Let's make it happy ...

When using modversions, usb_alloc_urb()/_submit_urb()/_set_interface()
are defined as macros. #undef'ing them in wrapper.h before redefining
them doesn't hurt in the case they aren't macros.


Clemens

--Boundary_(ID_+USUkEhrOQrzI7L2mRb9FQ)
Content-type: application/octet-stream; name=usb.diff
Content-transfer-encoding: BASE64
Content-disposition: attachment; filename=usb.diff

SW5kZXg6IHVzYi91c2JhdWRpby5jCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZp
bGU6IC9jdnNyb290L2Fsc2EvYWxzYS1kcml2ZXIvdXNiL3VzYmF1ZGlvLmMsdgpy
ZXRyaWV2aW5nIHJldmlzaW9uIDEuMTUKZGlmZiAtdSAtcjEuMTUgdXNiYXVkaW8u
YwotLS0gdXNiL3VzYmF1ZGlvLmMJNSBKdWwgMjAwMiAxMzozNzo1MyAtMDAwMAkx
LjE1CisrKyB1c2IvdXNiYXVkaW8uYwk4IEp1bCAyMDAyIDA4OjA4OjI0IC0wMDAw
CkBAIC0xOTYxLDcgKzE5NjEsNyBAQAogCQkgKiBub3cgbG9vayBmb3IgYW4gZW1w
dHkgc2xvdCBhbmQgY3JlYXRlIGEgbmV3IGNhcmQgaW5zdGFuY2UKIAkJICovCiAJ
CWZvciAoaSA9IDA7IGkgPCBTTkRSVl9DQVJEUzsgaSsrKQotCQkJaWYgKCEgdXNi
X2NoaXBbaV0pIHsKKwkJCWlmIChzbmRfZW5hYmxlW2ldICYmICEgdXNiX2NoaXBb
aV0pIHsKIAkJCQljYXJkID0gc25kX2NhcmRfbmV3KHNuZF9pbmRleFtpXSwgc25k
X2lkW2ldLCBUSElTX01PRFVMRSwgMCk7CiAJCQkJaWYgKGNhcmQgPT0gTlVMTCkg
ewogCQkJCQlzbmRfcHJpbnRrKEtFUk5fRVJSICJjYW5ub3QgY3JlYXRlIGEgY2Fy
ZCBpbnN0YW5jZSAlZFxuIiwgaSk7CkluZGV4OiB1c2Ivd3JhcHBlci5oCj09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0KUkNTIGZpbGU6IC9jdnNyb290L2Fsc2EvYWxzYS1kcml2
ZXIvdXNiL3dyYXBwZXIuaCx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS4yCmRpZmYg
LXUgLXIxLjIgd3JhcHBlci5oCi0tLSB1c2Ivd3JhcHBlci5oCTIgSnVsIDIwMDIg
MTc6MjI6MjkgLTAwMDAJMS4yCisrKyB1c2Ivd3JhcHBlci5oCTggSnVsIDIwMDIg
MDg6MDg6MjQgLTAwMDAKQEAgLTEwLDYgKzEwLDggQEAKIHsKIAlyZXR1cm4gdXNi
X3N1Ym1pdF91cmIodXJiKTsKIH0KKyN1bmRlZiB1c2JfYWxsb2NfdXJiCisjdW5k
ZWYgdXNiX3N1Ym1pdF91cmIKICNkZWZpbmUgdXNiX2FsbG9jX3VyYihuLGZsYWdz
KSB1c2JfYWxsb2NfdXJiX3dyYXBwZXIobixmbGFncykKICNkZWZpbmUgdXNiX3N1
Ym1pdF91cmIocCxmbGFncykgdXNiX3N1Ym1pdF91cmJfd3JhcHBlcihwLGZsYWdz
KQogI2VuZGlmIC8qIExJTlVYX1ZFUlNJT05fQ09ERSA8IDIuNS4wICovCkBAIC04
Miw2ICs4NCw3IEBACiAJcmV0dXJuIDA7CiB9CiAKKyN1bmRlZiB1c2Jfc2V0X2lu
dGVyZmFjZQogI2RlZmluZSB1c2Jfc2V0X2ludGVyZmFjZShkZXYsaWZhY2UsYWx0
KSBoYWNrX3VzYl9zZXRfaW50ZXJmYWNlKGRldixpZmFjZSxhbHQpCiAKICNlbmRp
ZiAvKiBMSU5VWF9WRVJTSU9OIDwgMi41LjI0ICovCg==

--Boundary_(ID_+USUkEhrOQrzI7L2mRb9FQ)--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Oh, it's good to be a geek.
http://thinkgeek.com/sf
