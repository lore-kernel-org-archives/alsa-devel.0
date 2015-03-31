From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 0/4] ASoC: constification and random cleanups
Date: Tue, 31 Mar 2015 16:48:55 +0200
Message-ID: <1427813339-23817-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 2871A264F37
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 16:49:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, Fabian Frederick <fabf@skynet.be>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

SGVsbG8sCgp0aGlzIGlzIHRoZSBzZXJpZXMgc2VudCBvbiBTdW5kYXkgcmViYXNlZCBvbiBuZXh0
LiBUaGVyZSB3YXMgYSBjb25mbGljdAp3aXRoIGNvbW1pdCBjNjYwYzBhODA1ODYgKEFTb0M6IGZz
aTogY29uc3RpZnkgb2ZfZGV2aWNlX2lkIGFycmF5KSB3aGljaApkaWQgYSBwYXJ0IG9mIG15IDJu
ZCBwYXRjaCBidXQgYWxyZWFkeSBjb25mbGljdGVkIHdpdGggdGhlIGZpcnN0IG9uZS4KCk1hcmsg
c2FpZCBoZSBhbHJlYWR5IHRvb2sgcGF0Y2ggMywgYnV0IHRoYXQgc2hvdWxkIG5vdCBiZSBhIHBy
b2JsZW0uClBhdGNoIDQgYXBwbGllZCBqdXN0IGZpbmUgdG8gbmV4dCwgc28gdGhpcyBpcyBqdXN0
IGEgcmVzZW5kLgoKQmVzdCByZWdhcmRzClV3ZQoKVXdlIEtsZWluZS1Lw7ZuaWcgKDQpOgogIEFT
b0M6IGZzaTogcmVvcmRlciBjb2RlIHRvIG1ha2UgYSBmb3J3YXJkIGRlY2xhcmF0aW9uIHN1cGVy
Zmx1b3VzCiAgQVNvQzogZnNpOiBtYXJrIHNldmVyYWwgZGF0YSBzdHJ1Y3R1cmVzIGFzIGNvbnN0
CiAgQVNvQzogZnNpOiBmaXggbGljZW5zZSBzcGVjaWZpY2F0aW9uCiAgQVNvQzogbWFyayBvZl9k
ZXZpY2VfaWQgYW5kIGRldmljZSBkYXRhIGFzIGNvbnN0YW50Cgogc291bmQvc29jL3NoL2ZzaS5j
ICAgICAgIHwgNzEgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCiBzb3VuZC9zb2Mvc2gvcmNhci9jb3JlLmMgfCAgNCArLS0KIDIgZmlsZXMgY2hhbmdlZCwg
MzcgaW5zZXJ0aW9ucygrKSwgMzggZGVsZXRpb25zKC0pCgotLSAKMi4xLjQKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBs
aXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2pl
Y3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
