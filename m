From: "Ronny V. Vindenes" <s864@lstud.ii.uib.no>
Subject: [PATCH] alsa-lib rpm spec update
Date: Mon, 24 Feb 2003 13:59:53 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302241355230.31903-200000@steinflue.ii.uib.no>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1316923629-441007072-1046091593=:31903"
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

---1316923629-441007072-1046091593=:31903
Content-Type: TEXT/PLAIN; charset=US-ASCII

Cleanup the alsa-lib rpm spec:
 * Use standard rpm macros for build & install
 * Split package into alsa-lib and alsa-lib-devel (this is standard and
 makes offical packages play nice with 3rd party alsa-lib packages
 like those provided by gstreamer)
 * Correct which files are installed (so that pkg-config works)
 * Set license to LGPL

Tested on Redhat 8.0, hopefully it doesn't break on SuSe or Mandrake

-- 
Ronny V. Vindenes <sublett@dc-s.com>

---1316923629-441007072-1046091593=:31903
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="alsa-lib.spec.in.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0302241359530.31903@steinflue.ii.uib.no>
Content-Description: 
Content-Disposition: attachment; filename="alsa-lib.spec.in.patch"

LS0tIGFsc2EtbGliLnNwZWMuaW4ub3JpZwkyMDAzLTAyLTIyIDIzOjM4OjAy
LjAwMDAwMDAwMCArMDEwMA0KKysrIGFsc2EtbGliLnNwZWMuaW4JMjAwMy0w
Mi0yMiAyMzo0MzowOS4wMDAwMDAwMDAgKzAxMDANCkBAIC01LDE4ICs1LDMy
IEBADQogTmFtZTogYWxzYS1saWINCiBWZXJzaW9uOiAldmVyDQogUmVsZWFz
ZTogJXJlbA0KLUNvcHlyaWdodDogR1BMDQorTGljZW5zZTogTEdQTA0KIEdy
b3VwOiBTeXN0ZW0vTGlicmFyaWVzDQogU291cmNlOiBmdHA6Ly9mdHAuYWxz
YS1wcm9qZWN0Lm9yZy9wdWIvbGliL2Fsc2EtbGliLSV7dmVyfS50YXIuYnoy
DQotQnVpbGRSb290OiAvdmFyL3RtcC9hbHNhLWxpYi0le3Zlcn0NCitCdWls
ZFJvb3Q6ICV7X3RtcHBhdGh9LyV7bmFtZX0tJXt2ZXJzaW9ufS1yb290DQog
VVJMOiBodHRwOi8vd3d3LmFsc2EtcHJvamVjdC5vcmcNCiBSZXF1aXJlczog
YWxzYS1kcml2ZXINCitCdWlsZFJlcXVpcmVzOglhbHNhLWRyaXZlcg0KIA0K
ICVkZXNjcmlwdGlvbg0KIA0KIEFkdmFuY2VkIExpbnV4IFNvdW5kIEFyY2hp
dGVjdHVyZSAoQUxTQSkgLSBMaWJyYXJ5DQogDQorJXBhY2thZ2UgLW4gYWxz
YS1saWItZGV2ZWwNCitTdW1tYXJ5OiBBTFNBIExpYnJhcmllcyBEZXZlbG9w
bWVudCBGaWxlcw0KK0dyb3VwOiBEZXZlbG9wbWVudC9MaWJyYXJpZXMNCitS
ZXF1aXJlczogJXtuYW1lfSA9ICV7dmVyc2lvbn0tJXtyZWxlYXNlfQ0KKw0K
KyVkZXNjcmlwdGlvbiAtbiBhbHNhLWxpYi1kZXZlbA0KK0RldmVsb3BtZW50
IGZpbGVzIGZvciBidWlsZGluZyBhcHBsaWNhdGlvbnMgd2hpY2ggdXNlIHRo
ZSBBTFNBIGxpYnJhcmllcy4NCisNCiAlY2hhbmdlbG9nDQorKiBTYXQgRmVi
IDIyIDIwMDMgUm9ubnkgVi4gVmluZGVuZXMgPHN1YmxldHRAZGMtcy5jb20+
DQorLSBzcGxpdCBhbHNhLWxpYiBpbnRvIGFsc2EtbGliIGFuZCBhbHNhLWxp
Yi1kZXZlbA0KKy0gY2hhbmdlZCB3aGljaCBmaWxlcyBhcmUgaW5zdGFsbGVk
IChub3cgaW5jbHVkZXMgYWxzYS5wYykNCistIHVzZSBzdGFuZGFyZCBycG0g
bWFjcm9zIGZvciBidWlsZCBhbmQgaW5zdGFsbA0KKy0gY2hhbmdlZCBCdWls
ZFJvb3QgZnJvbSAvdmFyL3RtcCB0byAle190bXBwYXRofQ0KIA0KICogVHVl
IE5vdiAyMCAyMDAxIEphcm9zbGF2IEt5c2VsYSA8cGVyZXhAc3VzZS5jej4N
CiANCkBAIC0zNiwzMSArNTAsMjggQEANCiAlcHJlcA0KICVzZXR1cA0KICVi
dWlsZA0KLQ0KLS4vY29uZmlndXJlIC0tcHJlZml4PSVfcHJlZml4IC0tbWFu
ZGlyPSVfbWFuZGlyIC0tZGF0YWRpcj0lX2RhdGFkaXIgXA0KLQkgICAgLS1p
bmNsdWRlZGlyPSVfaW5jbHVkZWRpciAtLWxpYmRpcj0lX2xpYmRpcg0KKyVj
b25maWd1cmUNCiBtYWtlDQogDQogJWluc3RhbGwNCi1bIC1uICIkUlBNX0JV
SUxEX1JPT1QiIC1hICIkUlBNX0JVSUxEX1JPT1QiICE9IC8gXSAmJiBybSAt
cmYgJFJQTV9CVUlMRF9ST09UDQotDQotbWtkaXIgLXAgJFJQTV9CVUlMRF9S
T09ULyVfaW5jbHVkZWRpci9hbHNhDQotbWtkaXIgLXAgJFJQTV9CVUlMRF9S
T09ULyVfZGF0YWRpci9hbHNhDQotbWtkaXIgLXAgJFJQTV9CVUlMRF9ST09U
LyVfZGF0YWRpci9hY2xvY2FsDQotbWtkaXIgLXAgJFJQTV9CVUlMRF9ST09U
LyVfbGliZGlyDQotDQotbWFrZSBERVNURElSPSIkUlBNX0JVSUxEX1JPT1Qi
IGluc3RhbGwNCitbICIkUlBNX0JVSUxEX1JPT1QiICE9ICIvIiBdICYmIHJt
IC1yZiAkUlBNX0JVSUxEX1JPT1QNCislbWFrZWluc3RhbGwNCiANCiAlY2xl
YW4NCi1bIC1uICIkUlBNX0JVSUxEX1JPT1QiIC1hICIkUlBNX0JVSUxEX1JP
T1QiICE9IC8gXSAmJiBybSAtcmYgJFJQTV9CVUlMRF9ST09UDQorWyAiJFJQ
TV9CVUlMRF9ST09UIiAhPSAiLyIgXSAmJiBybSAtcmYgJFJQTV9CVUlMRF9S
T09UDQogDQogJWZpbGVzDQogJWRlZmF0dHIoLSwgcm9vdCwgcm9vdCkNCi0N
Cisle19iaW5kaXJ9LyoNCisle19saWJkaXJ9Lyouc28uKg0KKyV7X2RhdGFk
aXJ9L2Fsc2ENCiAlZG9jIGRvYy8qLnR4dA0KIA0KLSVfaW5jbHVkZWRpci9h
bHNhLyouaA0KLSVfbGliZGlyL2xpYioNCi0lX2RhdGFkaXIvYWNsb2NhbC9h
bHNhLm00DQotJV9kYXRhZGlyL2Fsc2EvKg0KLSVfcHJlZml4L2Jpbi9hc2Vy
dmVyDQorJWZpbGVzIC1uIGFsc2EtbGliLWRldmVsDQorJWRlZmF0dHIoLSxy
b290LHJvb3QpDQorJXtfaW5jbHVkZWRpcn0vYWxzYQ0KKyV7X2luY2x1ZGVk
aXJ9L3N5cy8qDQorJXtfbGliZGlyfS8qLmxhDQorJXtfbGliZGlyfS8qLnNv
DQorJXtfZGF0YWRpcn0vYWNsb2NhbC8qDQorJXtfbGliZGlyfS9wa2djb25m
aWcvKg0K
---1316923629-441007072-1046091593=:31903--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
