From: tom burkart <alsa@aussec.com>
Subject: 0.9.3c build failure + partial patch
Date: Thu, 22 May 2003 22:33:13 +1000 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305222225210.1451-200000@home.aussec.com>
References: <s5hptmbqjay.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809536-160362348-1053606793=:1451"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hptmbqjay.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463809536-160362348-1053606793=:1451
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,
attached is a patch to attempt to fix some problems with the current
release:
Hunk 1 contains a minor fix that will create directories during
installation for some files (especially useful for building packages)
Hunk 2 fixes a dependency that appears to be no longer required.
Hunk 3 is a partial fix to the pnp.c file in support/pnp not being built.
It is a partial fix as it still does not get compiled at all, even though
issuing a make will compile it...

tom.

---1463809536-160362348-1053606793=:1451
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="alsa-driver-install.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0305222233130.1451@home.aussec.com>
Content-Description: 
Content-Disposition: attachment; filename="alsa-driver-install.patch"

LS0tIGFsc2EtZHJpdmVyLTAuOS4wcmMzL01ha2VmaWxlLm9yZwlGcmkgSmFu
IDEwIDAzOjA4OjA3IDIwMDMNCisrKyBhbHNhLWRyaXZlci0wLjkuMHJjMy9N
YWtlZmlsZQlGcmkgRmViIDIxIDE3OjE3OjQwIDIwMDMNCkBAIC0xNTMsMTEg
KzE1MywxMSBAQA0KIC5QSE9OWTogaW5zdGFsbC1zY3JpcHRzDQogaW5zdGFs
bC1zY3JpcHRzOg0KIAlpZiBbIC1kIC9zYmluL2luaXQuZCBdOyB0aGVuIFwN
Ci0JICBpbnN0YWxsIC1tIDc1NSAtZyAkKElHUk9VUCkgLW8gJChJVVNFUikg
dXRpbHMvYWxzYXNvdW5kICQoREVTVERJUikvc2Jpbi9pbml0LmQvYWxzYXNv
dW5kOyBcDQorCSAgaW5zdGFsbCAtRCAtbSA3NTUgLWcgJChJR1JPVVApIC1v
ICQoSVVTRVIpIHV0aWxzL2Fsc2Fzb3VuZCAkKERFU1RESVIpL3NiaW4vaW5p
dC5kL2Fsc2Fzb3VuZDsgXA0KIAllbGlmIFsgLWQgL2V0Yy9yYy5kL2luaXQu
ZCBdOyB0aGVuIFwNCi0JICBpbnN0YWxsIC1tIDc1NSAtZyAkKElHUk9VUCkg
LW8gJChJVVNFUikgdXRpbHMvYWxzYXNvdW5kICQoREVTVERJUikvZXRjL3Jj
LmQvaW5pdC5kL2Fsc2Fzb3VuZDsgXA0KKwkgIGluc3RhbGwgLUQgLW0gNzU1
IC1nICQoSUdST1VQKSAtbyAkKElVU0VSKSB1dGlscy9hbHNhc291bmQgJChE
RVNURElSKS9ldGMvcmMuZC9pbml0LmQvYWxzYXNvdW5kOyBcDQogCWVsaWYg
WyAtZCAvZXRjL2luaXQuZCBdOyB0aGVuIFwNCi0JICBpbnN0YWxsIC1tIDc1
NSAtZyAkKElHUk9VUCkgLW8gJChJVVNFUikgdXRpbHMvYWxzYXNvdW5kICQo
REVTVERJUikvZXRjL2luaXQuZC9hbHNhc291bmQ7IFwNCisJICBpbnN0YWxs
IC1EIC1tIDc1NSAtZyAkKElHUk9VUCkgLW8gJChJVVNFUikgdXRpbHMvYWxz
YXNvdW5kICQoREVTVERJUikvZXRjL2luaXQuZC9hbHNhc291bmQ7IFwNCiAJ
ZmkNCiANCiAuUEhPTlk6IGNoZWNrLXNuZC1wcmVmaXgNCi0tLSBhbHNhLWRy
aXZlci0wLjkuM2Ivc3VwcG9ydC9wbnAvcG5wLmMub3JnCU1vbiBNYXkgMTkg
MTg6MjQ6NTEgMjAwMw0KKysrIGFsc2EtZHJpdmVyLTAuOS4zYi9zdXBwb3J0
L3BucC9wbnAuYwlXZWQgTWF5IDIxIDE0OjEwOjU1IDIwMDMNCkBAIC0zMyw3
ICszMyw2IEBADQogI2lmIGRlZmluZWQoQ09ORklHX01PRFZFUlNJT05TKSAm
JiAhZGVmaW5lZChfX0dFTktTWU1TX18pICYmICFkZWZpbmVkKF9fREVQRU5E
X18pDQogI2RlZmluZSBNT0RWRVJTSU9OUw0KICNpbmNsdWRlIDxsaW51eC9t
b2R2ZXJzaW9ucy5oPg0KLSNpbmNsdWRlICJzbmR2ZXJzaW9ucy5oIg0KICNl
bmRpZg0KICNlbmRpZg0KIA0KLS0tIGFsc2EtZHJpdmVyLTAuOS4zYi9zdXBw
b3J0L3BucC9NYWtlZmlsZS5vcmcJTW9uIEFwciAgNyAyMDowMDozMSAyMDAz
DQorKysgYWxzYS1kcml2ZXItMC45LjNiL3N1cHBvcnQvcG5wL01ha2VmaWxl
CVdlZCBNYXkgMjEgMTY6MDc6MDIgMjAwMw0KQEAgLTE3LDcgKzE3LDcgQEAN
CiAjIFRvcGxldmVsIE1vZHVsZSBEZXBlbmRlbmN5DQogaWZuZGVmIENPTkZJ
R19QTlBfS0VSTkVMDQogaWZlcSAoeSwkKENPTkZJR19JU0FQTlApKQ0KLW9i
ai1tICs9IHNuZC1wbnAubw0KK29iai1tICs9IHBucC5vDQogZW5kaWYNCiBl
bmRpZg0KIA0K
---1463809536-160362348-1053606793=:1451--


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
