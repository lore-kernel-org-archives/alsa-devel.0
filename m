From: Reimar =?iso-8859-1?Q?D=F6ffinger?= <Reimar.Doeffinger@stud.uni-karlsruhe.de>
Subject: Memleak with mixer? Or incorrect code?
Date: Wed, 12 Jan 2005 12:23:20 +0100
Message-ID: <20050112112320.GA5411@rz.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
the attached code consumes more and more memory when I run it (with alsa
1.0.3 as included in SuSE 9.1).
Why is that so? Did I forget to free something?
Both commenting out the snd_mixer_selem_register or the snd_mixer_load
call will fix it, but that's not an option in real code (this is
actually a stripped-down version of the code in MPlayer's ao_alsa.c)...
Any hints on that??

Greetings,
Reimar D=F6ffinger

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPGFsc2EvYXNvdW5kbGliLmg+DQoNCmludCBtYWluKCkgew0KICBzbmRfbWl4
ZXJfdCAqaGFuZGxlOyANCiAgc25kX21peGVyX3NlbGVtX2lkX3QgKnNpZDsNCiAgc25kX21p
eGVyX2NsYXNzX3QgKmNsYXNzOw0KICBpbnQgZXJyOw0KICB3aGlsZSAoMSkgew0KICAgIHNu
ZF9taXhlcl9vcGVuKCZoYW5kbGUsIDApOw0KICAgIHNuZF9taXhlcl9hdHRhY2goaGFuZGxl
LCAiZGVmYXVsdCIpOw0KICAgIHNuZF9taXhlcl9zZWxlbV9yZWdpc3RlcihoYW5kbGUsIE5V
TEwsIE5VTEwpOw0KICAgIHNuZF9taXhlcl9sb2FkKGhhbmRsZSk7DQogICAgc25kX21peGVy
X2ZyZWUoaGFuZGxlKTsNCiAgICBzbmRfbWl4ZXJfZGV0YWNoKGhhbmRsZSwgImRlZmF1bHQi
KTsNCiAgICBzbmRfbWl4ZXJfY2xvc2UoaGFuZGxlKTsNCi8vICAgIHNsZWVwKDEwMCk7DQog
IH0NCn0NCg==

--jRHKVT23PllUwdXP--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
