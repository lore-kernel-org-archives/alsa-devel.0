From: rtp <rtp-mailing@wanadoo.fr>
Subject: Alsa, devfs and multiples soundcards
Date: Mon, 30 Jun 2003 20:46:29 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306302026540.25744-200000@labevue.coinnetwork.dl>
Reply-To: rtp <rtp-mailing@wanadoo.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463768574-1763165680-1056998789=:25744"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463768574-1763165680-1056998789=:25744
Content-Type: TEXT/PLAIN; charset=US-ASCII



	Hi,

Recently I switch to devfs (kernels 2.4.20 and 2.4.21). On Alsa loading, I
get this message :

kernel: devfs: devfs_register(unknown): could not append to parent, err:
-17

And all applications with oss were working with only one of my two
sound cards (ie gnome-volume-control). So I found this mail from T.Iwai on
lkml :

http://www.cs.helsinki.fi/linux/linux-kernel/2001-49/0266.html

So I've adapted this patch (modified patch joined with this mail) and all
works well.

Can somebody give me more informations about this ?


Arnaud Patard


---1463768574-1763165680-1056998789=:25744
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sound.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0306302046290.25744@labevue.coinnetwork.dl>
Content-Description: 
Content-Disposition: attachment; filename="sound.patch"

ZGlmZiAtdXIgbGludXgtMi40LjIxL2RyaXZlcnMvc291bmQvc291bmRfY29y
ZS5jIC91c3Ivc3JjL2xpbnV4L2RyaXZlcnMvc291bmQvc291bmRfY29yZS5j
DQotLS0gbGludXgtMi40LjIxL2RyaXZlcnMvc291bmQvc291bmRfY29yZS5j
CTIwMDEtMDktMzAgMjE6MjY6MDguMDAwMDAwMDAwICswMjAwDQorKysgL3Vz
ci9zcmMvbGludXgvZHJpdmVycy9zb3VuZC9zb3VuZF9jb3JlLmMJMjAwMy0w
Ni0yMyAxNDozMzoxMy4wMDAwMDAwMDAgKzAyMDANCkBAIC0yMzEsMjMgKzIz
MSwyOSBAQA0KICANCiBpbnQgcmVnaXN0ZXJfc291bmRfc3BlY2lhbChzdHJ1
Y3QgZmlsZV9vcGVyYXRpb25zICpmb3BzLCBpbnQgdW5pdCkNCiB7DQotCWNo
YXIgKm5hbWU7DQorCWNoYXIgKm5hbWUsIG5hbWVfZXh0WzMyXTsNCisJaW50
IHN1ZmZpeCA9IDA7DQorCQ0KIA0KLQlzd2l0Y2ggKHVuaXQpIHsNCisJc3dp
dGNoICh1bml0ICYgMTUpIHsJDQogCSAgICBjYXNlIDA6DQogCQluYW1lID0g
Im1peGVyIjsNCisJCXN1ZmZpeD0xOw0KIAkJYnJlYWs7DQogCSAgICBjYXNl
IDE6DQogCQluYW1lID0gInNlcXVlbmNlciI7DQogCQlicmVhazsNCiAJICAg
IGNhc2UgMjoNCi0JCW5hbWUgPSAibWlkaTAwIjsNCisJCXNwcmludGYobmFt
ZV9leHQsICJtaWRpMCVkIiwgdW5pdCAvIFNPVU5EX1NURVApOw0KKwkJbmFt
ZSA9IG5hbWVfZXh0Ow0KIAkJYnJlYWs7DQogCSAgICBjYXNlIDM6DQogCQlu
YW1lID0gImRzcCI7DQorCQlzdWZmaXggPSAxOw0KIAkJYnJlYWs7DQogCSAg
ICBjYXNlIDQ6DQogCQluYW1lID0gImF1ZGlvIjsNCisJCXN1ZmZpeCA9IDE7
DQogCQlicmVhazsNCiAJICAgIGNhc2UgNToNCiAJCW5hbWUgPSAidW5rbm93
bjUiOw0KQEAgLTI2MywyNiArMjY5LDM1IEBADQogCQlicmVhazsNCiAJICAg
IGNhc2UgOToNCiAJCW5hbWUgPSAiZG1taWRpIjsNCisJCXN1ZmZpeCA9IDE7
DQogCQlicmVhazsNCiAJICAgIGNhc2UgMTA6DQogCQluYW1lID0gImRtZm0i
Ow0KKwkJc3VmZml4ID0gMTsNCiAJCWJyZWFrOw0KIAkgICAgY2FzZSAxMToN
CiAJCW5hbWUgPSAidW5rbm93bjExIjsNCiAJCWJyZWFrOw0KIAkgICAgY2Fz
ZSAxMjoNCiAJCW5hbWUgPSAiYWRzcCI7DQorCQlzdWZmaXggPSAxOw0KIAkJ
YnJlYWs7DQogCSAgICBjYXNlIDEzOg0KIAkJbmFtZSA9ICJhbWlkaSI7DQor
CQlzdWZmaXggPSAxOw0KIAkJYnJlYWs7DQogCSAgICBjYXNlIDE0Og0KIAkJ
bmFtZSA9ICJhZG1taWRpIjsNCisJCXN1ZmZpeCA9IDE7DQogCQlicmVhazsN
CiAJICAgIGRlZmF1bHQ6DQogCQluYW1lID0gInVua25vd24iOw0KIAkJYnJl
YWs7DQogCX0NCisJaWYgKHN1ZmZpeCAmJiB1bml0ID49IFNPVU5EX1NURVAp
IHsNCisJICAgIHNwcmludGYobmFtZV9leHQsICIlcyVkIiwgbmFtZSwgdW5p
dCAvIFNPVU5EX1NURVApOw0KKwkgICAgbmFtZSA9IG5hbWVfZXh0Ow0KKwl9
DQogCXJldHVybiBzb3VuZF9pbnNlcnRfdW5pdCgmY2hhaW5zW3VuaXQmMTVd
LCBmb3BzLCAtMSwgdW5pdCwgdW5pdCsxLA0KIAkJCQkgbmFtZSwgU19JUlVT
UiB8IFNfSVdVU1IpOw0KIH0NCg==
---1463768574-1763165680-1056998789=:25744--


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
