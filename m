From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: ac97: Add Toshiba P500 to ac97 jack
	sense blacklist
Date: Sun, 28 Mar 2010 13:32:34 -0700
Message-ID: <604760771003281332s203aae85i6137d71034fed929@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00504502cc91e6cddf0482e24bc9
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f178.google.com (mail-pz0-f178.google.com
	[209.85.222.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 815CE243C7
	for <alsa-devel@alsa-project.org>;
	Sun, 28 Mar 2010 22:32:35 +0200 (CEST)
Received: by pzk8 with SMTP id 8so68706pzk.16
	for <alsa-devel@alsa-project.org>; Sun, 28 Mar 2010 13:32:34 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, stable@kernel.org
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--00504502cc91e6cddf0482e24bc9
Content-Type: text/plain; charset=UTF-8

Hi,

Attached is a patch against sound-2.6 (also applicable to 2.6.32.y and
2.6.33.y) adding the OR's SSID to ad1981_jacks_blacklist for audible
audio by default.

Best,
-Dan

--00504502cc91e6cddf0482e24bc9
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-ALSA-ac97-Add-Toshiba-P500-to-ac97-jack-sense-blackl.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-ac97-Add-Toshiba-P500-to-ac97-jack-sense-blackl.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g7caxd8c0

RnJvbSBkMWQzOWQ1ZGI4ZWJjMjk0YWNlNjk0OTIxZWFjYWJhNzhhOGI4ZjdlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFN1biwgMjggTWFyIDIwMTAgMTY6MjE6NTggLTA0MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBhYzk3OiBBZGQgVG9zaGliYSBQNTAwIHRvIGFjOTcgamFjayBzZW5zZSBibGFja2xpc3QKCkJ1
Z0xpbms6IGh0dHBzOi8vbGF1bmNocGFkLm5ldC9idWdzLzQ4MTA1OAoKVGhlIE9SIGhhcyB2ZXJp
ZmllZCB0aGF0IGJvdGggJ0hlYWRwaG9uZSBKYWNrIFNlbnNlJyBhbmQgJ0xpbmUgSmFjayBTZW5z
ZScKbmVlZCB0byBiZSBtdXRlZCBmb3Igc291bmQgdG8gYmUgYXVkaWJsZSwgc28ganVzdCBhZGQg
dGhlIG1hY2hpbmUncyBTU0lECnRvIHRoZSBhYzk3IGphY2sgc2Vuc2UgYmxhY2tsaXN0LgoKUmVw
b3J0ZWQtYnk6IFJpY2hhcmQgR2FnbmUKVGVzdGVkLWJ5OiBSaWNoYXJkIEdhZ25lCkNjOiA8c3Rh
YmxlQGtlcm5lbC5vcmc+ClNpZ25lZC1vZmYtYnk6IERhbmllbCBUIENoZW4gPGNyaW1zdW5AdWJ1
bnR1LmNvbT4KLS0tCiBzb3VuZC9wY2kvYWM5Ny9hYzk3X3BhdGNoLmMgfCAgICAxICsKIDEgZmls
ZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L3NvdW5kL3BjaS9hYzk3L2FjOTdfcGF0Y2guYyBiL3NvdW5kL3BjaS9hYzk3L2FjOTdfcGF0Y2gu
YwppbmRleCAxYTU5YjcxLi5lNjhjOThlIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvYWM5Ny9hYzk3
X3BhdGNoLmMKKysrIGIvc291bmQvcGNpL2FjOTcvYWM5N19wYXRjaC5jCkBAIC0xODU5LDYgKzE4
NTksNyBAQCBzdGF0aWMgdW5zaWduZWQgaW50IGFkMTk4MV9qYWNrc19ibGFja2xpc3RbXSA9IHsK
IAkweDEwMjgwMTYwLCAvKiBEZWxsIERpbWVuc2lvbiAyNDAwICovCiAJMHgxMDQzODBiMCwgLyog
QXN1cyBBN1Y4WC1NWCAqLwogCTB4MTE3OTAyNDEsIC8qIFRvc2hpYmEgU2F0ZWxsaXRlIEEtMTUg
UzEyNyAqLworCTB4MTE3OWZmMTAsIC8qIFRvc2hpYmEgUDUwMCAqLwogCTB4MTQ0ZGMwMWEsIC8q
IFNhbXN1bmcgTlAtWDIwQzAwNC9TRUcgKi8KIAkwIC8qIGVuZCAqLwogfTsKLS0gCjEuNy4wCgo=
--00504502cc91e6cddf0482e24bc9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--00504502cc91e6cddf0482e24bc9--
