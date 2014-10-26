From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH][fix] ALSA: bebob: fix wrong decoding of clock
	information for Terratec PHASE 88 Rack FW
Date: Sun, 26 Oct 2014 22:49:45 +0900
Message-ID: <1414331385-14731-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id C22AE2606A9
 for <alsa-devel@alsa-project.org>; Sun, 26 Oct 2014 14:49:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: muranyia@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

VGVycmF0ZWMgUEhBU0UgODggcmFjayBmdyBoYXMgdHdvIHJlZ2lzdGVycyBmb3Igc291cmNlIG9m
IGNsb2NrLCBvbmUgaXMKZm9yIGludGVybmFsL2V4dGVybmFsLCBhbmQgYW5vdGhlciBpcyBmb3Ig
d29yZGNsb2NrL3NwZGlmIGZvciBleHRlcm5hbC4KCldoZW4gY2xvY2sgc291cmNlIGlzIGludGVy
bmFsLCBpbmZvcm1hdGlvbiBpbiBhbm90aGVyIHJlZ2lzdGVyIGhhcyBubyBtZWFuaW5nLgpUaHVz
IGl0IG11c3QgYmUgaWdub3JlZCwgYnV0IGN1cnJlbnQgaW1wbGVtZW50YXRpb24gZGVjb2RlcyBp
dC4gVGhpcyBjYXVzZXMKb3Zlci1pbmRleGluZyByZWZlcmVuY2UgdG8gbGFiZWxzLgoKUmVwb3J0
ZWQtYnk6IEFuZHLDoXMgTXVyw6FueWkgPG11cmFueWlhQGdtYWlsLmNvbT4KVGVzdGVkLWJ5OiBB
bmRyw6FzIE11csOhbnlpIDxtdXJhbnlpYUBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IFRha2Fz
aGkgU2FrYW1vdG8gPG8tdGFrYXNoaUBzYWthbW9jY2hpLmpwPgotLS0KIHNvdW5kL2ZpcmV3aXJl
L2JlYm9iL2JlYm9iX3RlcnJhdGVjLmMgfCA3ICsrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9maXJld2lyZS9i
ZWJvYi9iZWJvYl90ZXJyYXRlYy5jIGIvc291bmQvZmlyZXdpcmUvYmVib2IvYmVib2JfdGVycmF0
ZWMuYwppbmRleCAwZTRjMGJmLi45OTQwNjExIDEwMDY0NAotLS0gYS9zb3VuZC9maXJld2lyZS9i
ZWJvYi9iZWJvYl90ZXJyYXRlYy5jCisrKyBiL3NvdW5kL2ZpcmV3aXJlL2JlYm9iL2JlYm9iX3Rl
cnJhdGVjLmMKQEAgLTI0LDcgKzI0LDEyIEBAIHBoYXNlODhfcmFja19jbGtfc3JjX2dldChzdHJ1
Y3Qgc25kX2JlYm9iICpiZWJvYiwgdW5zaWduZWQgaW50ICppZCkKIAlpZiAoZXJyIDwgMCkKIAkJ
Z290byBlbmQ7CiAKLQkqaWQgPSAoZW5hYmxlX2V4dCAmIDB4MDEpIHwgKChlbmFibGVfd29yZCAm
IDB4MDEpIDw8IDEpOworCWlmIChlbmFibGVfZXh0ID09IDApCisJCSppZCA9IDA7CisJZWxzZSBp
ZiAoZW5hYmxlX3dvcmQgPT0gMCkKKwkJKmlkID0gMTsKKwllbHNlCisJCSppZCA9IDI7CiBlbmQ6
CiAJcmV0dXJuIGVycjsKIH0KLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFs
c2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2Fsc2EtZGV2ZWwK
