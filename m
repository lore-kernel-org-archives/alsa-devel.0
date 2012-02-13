From: Rolf Anderegg <rolf.anderegg@weiss.ch>
Subject: snd_dice: category ID
Date: Mon, 13 Feb 2012 18:46:36 +0100
Message-ID: <4F394C7C.1090007@weiss.ch>
Reply-To: rolf.anderegg@weiss.ch
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060409020802040404000708"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail11.bluewin.ch (mail11.bluewin.ch [195.186.18.61])
	by alsa0.perex.cz (Postfix) with ESMTP id D0FE9103C7C
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 18:46:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Uli Franke <uli.franke@weiss.ch>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--------------060409020802040404000708
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Clemens,

I'd like to request the following patch to be applied on the
firewire-kernel-streaming branch (current commit head
526795d69f5be6d058bdf89a65a303a1ee136aba).
It involves handling Weiss DICE devices which use a dedicated category ID=
 (other
than TCAT's default Cat ID (0x04), which is not necessarily binding).
Citing (one of many) TC's user guide:

[...]
The manufacturer is free to use the lower 5 bytes of the WWUID in any way=
. The
DICE firmware, by default, uses the chip ID as follows:

Upper 32 bits of WWUID
+------------------------+--------+
| 24 bit OUI =E2=80=93 0x000166  | Cat    |
+------------------------+--------+
Category 8 bits: TCAT uses 0x04 for this field.

Lower 32 bits of WWUID
+----------------------------+----------------+
| 10 bit product identifier  | 22 bit serial# |
+----------------------------+----------------+
[...]

Presumably, few of the other vendors have changed TCATs default Cat. ID. =
We have
decided to change it to 0x00 since the beginning of our DICE product-line=
, alas
this should be considered in snd-dice's dice_interface_check.
Thanks in advance.

Rolf Anderegg


--------------060409020802040404000708
Content-Type: text/plain; name="weiss_categoryID.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="weiss_categoryID.patch"

ZGlmZiAtLWdpdCBhL3NvdW5kL2ZpcmV3aXJlL2RpY2UuYyBiL3NvdW5kL2ZpcmV3aXJlL2Rp
Y2UuYwppbmRleCAyMDhjYTBhLi5hMmJlZjRlIDEwMDY0NAotLS0gYS9zb3VuZC9maXJld2ly
ZS9kaWNlLmMKKysrIGIvc291bmQvZmlyZXdpcmUvZGljZS5jCkBAIC0xMTEzLDYgKzExMTMs
OSBAQCBzdGF0aWMgdm9pZCBkaWNlX2NhcmRfZnJlZShzdHJ1Y3Qgc25kX2NhcmQgKmNhcmQp
CiAKICNkZWZpbmUgRElDRV9DQVRFR09SWV9JRCAweDA0CiAKKyNkZWZpbmUgRElDRV9WRU5E
T1JfSURfV0VJU1MgICAgMHgxQzZBCisjZGVmaW5lIERJQ0VfQ0FURUdPUllfSURfV0VJU1Mg
IDB4MDAKKwogc3RhdGljIGludCBfX2RldmluaXQgZGljZV9pbnRlcmZhY2VfY2hlY2soc3Ry
dWN0IGZ3X3VuaXQgKnVuaXQpCiB7CiAJc3RhdGljIGNvbnN0IGludCBtaW5fdmFsdWVzWzEw
XSBfX2RldmluaXRjb25zdCA9IHsKQEAgLTExNDYsOSArMTE0OSwxOCBAQCBzdGF0aWMgaW50
IF9fZGV2aW5pdCBkaWNlX2ludGVyZmFjZV9jaGVjayhzdHJ1Y3QgZndfdW5pdCAqdW5pdCkK
IAkJCWJyZWFrOwogCQl9CiAJfQotCWlmIChkZXZpY2UtPmNvbmZpZ19yb21bM10gIT0gKCh2
ZW5kb3IgPDwgOCkgfCBESUNFX0NBVEVHT1JZX0lEKSB8fAotCSAgICBkZXZpY2UtPmNvbmZp
Z19yb21bNF0gPj4gMjIgIT0gbW9kZWwpCi0JCXJldHVybiAtRU5PREVWOworCXN3aXRjaCAo
dmVuZG9yKSB7CisJY2FzZSBESUNFX1ZFTkRPUl9JRF9XRUlTUzoKKwkJaWYgKGRldmljZS0+
Y29uZmlnX3JvbVszXSAhPSAoKHZlbmRvciA8PCA4KSB8IERJQ0VfQ0FURUdPUllfSURfV0VJ
U1MpIHx8CisJCQlkZXZpY2UtPmNvbmZpZ19yb21bNF0gPj4gMjIgIT0gbW9kZWwpCisJCQly
ZXR1cm4gLUVOT0RFVjsKKwkJYnJlYWs7CisJZGVmYXVsdDoKKwkJaWYgKGRldmljZS0+Y29u
ZmlnX3JvbVszXSAhPSAoKHZlbmRvciA8PCA4KSB8IERJQ0VfQ0FURUdPUllfSUQpIHx8CisJ
CQlkZXZpY2UtPmNvbmZpZ19yb21bNF0gPj4gMjIgIT0gbW9kZWwpCisJCQlyZXR1cm4gLUVO
T0RFVjsKKwkJYnJlYWs7CisJfQogCiAJLyoKIAkgKiBDaGVjayB0aGF0IHRoZSBzdWIgYWRk
cmVzcyBzcGFjZXMgZXhpc3QgYW5kIGFyZSBsb2NhdGVkIGluc2lkZSB0aGUK
--------------060409020802040404000708
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060409020802040404000708--
