From: p z oooo <pzad@pobox.sk>
Subject: PATCH - SB Live 5.1 - Center noise
Date: Wed, 10 Dec 2003 09:04:41 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312100804.JAA19760@www3.pobox.sk>
Reply-To: p z oooo <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: MULTIPART/mixed; charset=iso-8859-2; BOUNDARY="97783256-1804289383-1071043481=:19756"
Content-Transfer-Encoding: 8BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

--97783256-1804289383-1071043481=:19756
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

This patch defaults initial center/lfe jack to analog mode (now it is=20
initialized to digital mode). This solves problem with noise from=20
center on SB Live 5.1.

Peter Zubaj


=0A____________________________________=0Ahttp://www.logofun.pobox.sk - uro=
bte radost svojmu telefonu=0A
--97783256-1804289383-1071043481=:19756
Content-Type: APPLICATION/octet-stream; name="C:\\live_ad.diff"
Content-Transfer-Encoding: BASE64

ZGlmZiAtciAtdSBvL2Fsc2Eta2VybmVsL3BjaS9lbXUxMGsxL2VtdTEwazFf
bWFpbi5jIG4vYWxzYS1rZXJuZWwvcGNpL2VtdTEwazEvZW11MTBrMV9tYWlu
LmMKLS0tIG8vYWxzYS1rZXJuZWwvcGNpL2VtdTEwazEvZW11MTBrMV9tYWlu
LmMJMjAwMy0xMS0wNyAxODo1MjowMS4wMDAwMDAwMDAgKzAxMDAKKysrIG4v
YWxzYS1rZXJuZWwvcGNpL2VtdTEwazEvZW11MTBrMV9tYWluLmMJMjAwMy0x
Mi0wOSAyMToyMjoxMy4wMDAwMDAwMDAgKzAxMDAKQEAgLTIzOSwxNCArMjM5
LDkgQEAKICAJCX0KIAl9CiAJCi0JaWYgKCFlbXUtPkFQUykgewkvKiBlbmFi
bGUgYW5hbG9nIG91dHB1dCAqLwotCQlpZiAoIWVtdS0+YXVkaWd5KSB7Ci0J
CQl1bnNpZ25lZCBpbnQgcmVnID0gaW5sKGVtdS0+cG9ydCArIEhDRkcpOwot
CQkJb3V0bChyZWcgfCBIQ0ZHX0dQT1VUMCwgZW11LT5wb3J0ICsgSENGRyk7
Ci0JCX0gZWxzZSB7Ci0JCQl1bnNpZ25lZCBpbnQgcmVnID0gaW5sKGVtdS0+
cG9ydCArIEFfSU9DRkcpOwotCQkJb3V0bChyZWcgfCBBX0lPQ0ZHX0dQT1VU
MCwgZW11LT5wb3J0ICsgQV9JT0NGRyk7Ci0JCX0KKwlpZiAoZW11LT5hdWRp
Z3kpIHsJLyogZW5hYmxlIGFuYWxvZyBvdXRwdXQgKi8KKwkJdW5zaWduZWQg
aW50IHJlZyA9IGlubChlbXUtPnBvcnQgKyBBX0lPQ0ZHKTsKKwkJb3V0bChy
ZWcgfCBBX0lPQ0ZHX0dQT1VUMCwgZW11LT5wb3J0ICsgQV9JT0NGRyk7CiAJ
fQogCiAJLyoK

--97783256-1804289383-1071043481=:19756--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
