From: tom burkart <alsa@aussec.com>
Subject: Re: Re: alsa 0.9.5 - ymfpci - Yay!
Date: Fri, 18 Jul 2003 14:08:39 +1000 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307181336250.1312-300000@home.aussec.com>
References: <s5hy8yxyzs0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="Multipart_Thu_Jul_17_16:49:02_2003-1"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy8yxyzs0.wl@alsa2.suse.de>
Content-ID: <Pine.LNX.4.44.0307181336251.1312@home.aussec.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Multipart_Thu_Jul_17_16:49:02_2003-1
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0307181336252.1312@home.aussec.com>

On Jul 17, Takashi Iwai wrote:

> - unload alsa module, load oss, check the performance
Ok, works as before.

> - unload oss, and reload the alsa again.
It didn't want to do it for quite a while - I eventually got to repeat
it...  There are a lot of artifacts in the sound that are not there when
oss is active - may leave that for another day...

The attached patch I got from Jaroslav some time ago when he was trying to
chase the same bug - it was still applied.

The other diff is the differences in the ymfpci output.  The lspci output
is identical over before (alsa), oss, after (alsa) - not supplied.
I still have all the original files if required.

tom.

--Multipart_Thu_Jul_17_16:49:02_2003-1
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="alsa-driver-ymfpci.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0307181403330.1312@home.aussec.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="alsa-driver-ymfpci.patch"

LS0tIGFsc2EtZHJpdmVyLTAuOS40L2Fsc2Eta2VybmVsL3BjaS95bWZwY2kv
eW1mcGNpLmMub3JnCVR1ZSBNYXkgIDYgMDA6MTQ6NTkgMjAwMw0KKysrIGFs
c2EtZHJpdmVyLTAuOS40L2Fsc2Eta2VybmVsL3BjaS95bWZwY2kveW1mcGNp
LmMJRnJpIEp1biAxMyAwOTo0MjozNyAyMDAzDQpAQCAtMjQ1LDYgKzI0NSw4
IEBADQogCX0NCiAJcGNpX3NldF9kcnZkYXRhKHBjaSwgY2hpcCk7DQogCWRl
disrOw0KKwlsZWdhY3lfY3RybCA9IDB4OTA3ZjsNCisJcGNpX3dyaXRlX2Nv
bmZpZ193b3JkKHBjaSwgUENJUl9EU1hHX0xFR0FDWSwgbGVnYWN5X2N0cmwp
Ow0KIAlyZXR1cm4gMDsNCiB9DQogDQo=
--Multipart_Thu_Jul_17_16:49:02_2003-1
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=differences
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0307181403331.1312@home.aussec.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=differences

LS0tIGJlZm9yZS15bWZwY2kJRnJpIEp1bCAxOCAxMzoxMjoxMSAyMDAzDQor
KysgYWZ0ZXIteW1mcGNpCUZyaSBKdWwgMTggMTM6NTc6NDcgMjAwMw0KQEAg
LTI0LDcgKzI0LDcgQEANCiAwMDU0OiBmZjAwZmYNCiAwMDU4OiA1NTU1MDBm
Zg0KIDAwNWM6IDAwMDANCi0wMDYwOiAyMDgwMDANCiswMDYwOiAxYzgwMDAN
CiAwMDY0OiAyNjgwMGYNCiAwMDY4OiA4MDAwMDAwMA0KIDAwNmM6IDAwMDAN
CkBAIC0zMiwxNiArMzIsMTYgQEANCiAwMDc0OiAwMDAwDQogMDA3ODogMDAw
MA0KIDAwN2M6IDAwMDANCi0wMDgwOiAzMWU3MzFlNw0KLTAwODQ6IDMxZTcz
MWU3DQotMDA4ODogMzFlNzMxZTcNCiswMDgwOiAzZmZmM2ZmZg0KKzAwODQ6
IDNmZmYzZmZmDQorMDA4ODogM2ZmZjNmZmYNCiAwMDhjOiAwMDAwDQogMDA5
MDogMDAwMA0KIDAwOTQ6IDAwMDANCi0wMDk4OiAzMWU3MzFlNw0KKzAwOTg6
IDAwMDANCiAwMDljOiAwMDAwDQogMDBhMDogMDAwMA0KLTAwYTQ6IDAwMDAN
CiswMGE0OiAzZmZmM2ZmZg0KIDAwYTg6IDNmZmYzZmZmDQogMDBhYzogM2Zm
ZjNmZmYNCiAwMGIwOiAwMDAwDQpAQCAtNjUsNyArNjUsNyBAQA0KIDAwZjg6
IDAwMDANCiAwMGZjOiAwMDAwDQogMDEwMDogMDAwMA0KLTAxMDQ6IDAwMDEN
CiswMTA0OiAwMDAwDQogMDEwODogMDAwMA0KIDAxMGM6IDAwMDANCiAwMTEw
OiAwMDAwDQpAQCAtODYsNyArODYsNyBAQA0KIDAxNGM6IDAxMDANCiAwMTUw
OiAwMDAwDQogMDE1NDogMDAxOA0KLTAxNTg6IDQ4MDgwMDANCi0wMTVjOiA0
ODBiZTAwDQotMDE2MDogNDgwYmYwMA0KLTAxNjQ6IDQ4MGMwMDANCiswMTU4
OiAzYWM4MDAwDQorMDE1YzogM2FjYmUwMA0KKzAxNjA6IDNhY2JmMDANCisw
MTY0OiAzYWNjMDAwDQo=
--Multipart_Thu_Jul_17_16:49:02_2003-1--


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
