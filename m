From: Rui Sousa <rui.sousa@laposte.net>
Subject: [PATCH] via82xx.c #2
Date: Sun, 8 Sep 2002 19:53:09 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209081937330.1191-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1426227996-1031507589=:1191"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1426227996-1031507589=:1191
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi again,

I realized the CVS driver after Jul 31 (sg buffer implementation) was
already broken when using a fragment size smaller than PAGE_SIZE. The 
attached patch fixes this. I now have CVS driver from 8/27/2002 working 
(last commit before the merge), but mainline of today is still broken.

Rui Sousa

--8323328-1426227996-1031507589=:1191
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="via82xx.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0209081953090.1191@localhost.localdomain>
Content-Description: via82xx patch #2
Content-Disposition: attachment; filename="via82xx.patch"

SW5kZXg6IGFsc2Eta2VybmVsL3BjaS92aWE4Mnh4LmMNCj09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0NClJDUyBmaWxlOiAvY3Zzcm9vdC9hbHNhL2Fsc2Eta2Vy
bmVsL3BjaS92aWE4Mnh4LmMsdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjEN
CmRpZmYgLXUgLXIxLjEgdmlhODJ4eC5jDQotLS0gYWxzYS1rZXJuZWwvcGNp
L3ZpYTgyeHguYwk0IFNlcCAyMDAyIDE0OjE3OjQ3IC0wMDAwCTEuMQ0KKysr
IGFsc2Eta2VybmVsL3BjaS92aWE4Mnh4LmMJOCBTZXAgMjAwMiAxNzozODow
NCAtMDAwMA0KQEAgLTIzMSw3ICsyMzEsNyBAQA0KIA0KIAlpZiAoZGV2LT50
Ymxfc2l6ZSA8IFBBR0VfU0laRSkgew0KIAkJZm9yIChpID0gMDsgaSA8IGRl
di0+dGJsX2VudHJpZXM7IGkrKykNCi0JCQlkZXYtPnRhYmxlW2kgPDwgMV0g
PSBjcHVfdG9fbGUzMigodTMyKXNnYnVmLT50YWJsZVswXS5hZGRyICsgZGV2
LT5mcmFnc2l6ZSAqIGkpOw0KKwkJCWRldi0+dGFibGVbaSA8PCAxXSA9IGNw
dV90b19sZTMyKCh1MzIpc2didWYtPnRhYmxlWyhkZXYtPmZyYWdzaXplICog
aSkgPj4gUEFHRV9TSElGVF0uYWRkciArIChkZXYtPmZyYWdzaXplICogaSkg
JSBQQUdFX1NJWkUpOw0KIAl9IGVsc2Ugew0KIAkJZm9yIChpID0gMDsgaSA8
IGRldi0+dGJsX2VudHJpZXM7IGkrKykNCiAJCQlkZXYtPnRhYmxlW2kgPDwg
MV0gPSBjcHVfdG9fbGUzMigodTMyKXNnYnVmLT50YWJsZVtpXS5hZGRyKTsN
CkBAIC0yNDEsNyArMjQxLDcgQEANCiAJCWRldi0+dGFibGVbKGkgPDwgMSkg
KyAxXSA9IGNwdV90b19sZTMyKFZJQV9UQkxfQklUX0ZMQUcgfCBkZXYtPnRi
bF9zaXplKTsNCiAJCXNpemUgLT0gZGV2LT50Ymxfc2l6ZTsNCiAJfQ0KLQlk
ZXYtPnRhYmxlWyhkZXYtPnRibF9lbnRyaWVzIDw8IDEpIC0gMV0gPSBjcHVf
dG9fbGUzMihWSUFfVEJMX0JJVF9FT0wgfCBzaXplKTsNCisJZGV2LT50YWJs
ZVsoKGRldi0+dGJsX2VudHJpZXMgLSAxKSA8PCAxKSArIDFdID0gY3B1X3Rv
X2xlMzIoVklBX1RCTF9CSVRfRU9MIHwgc2l6ZSk7DQogDQogCXJldHVybiAw
Ow0KIH0NCg==
--8323328-1426227996-1031507589=:1191--


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
