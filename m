From: Daniel Mack <zonque@gmail.com>
Subject: =?utf-8?q?=5BPATCH_0/6=5D_snd-usb_endpoint_rework=2C?=
	=?utf-8?q?_version_6?=
Date: Fri, 23 Dec 2011 17:15:41 +0100
Message-ID: <1324656947-23169-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
	by alsa0.perex.cz (Postfix) with ESMTP id EB025103F94
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 17:16:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: gdiffey@gmail.com, tiwai@suse.de, clemens@ladisch.de, linuxaudio@showlabor.de, Daniel Mack <zonque@gmail.com>, blablack@gmail.com
List-Id: alsa-devel@alsa-project.org

Rm9ydHVuYXRlbHksIHRoZSBlZmZlY3RzIHJlcG9ydGVkIGJ5IEF1csOpbGllbiB3ZXJlIGVhc3kg
dG8gZml4LCBhbmQKaW5kZWVkIGp1c3QgcmVncmVzc2lvbnMgZnJvbSBwcmV2aW91cyB2ZXJzaW9u
IG9mIHRoZSBwYXRjaCBzZXQuIFRob3NlCmFyZSBub3cgb3V0IG9mIHRoZSB3YXksIHNvIGhlcmUn
cyB2ZXJzaW9uIDYuCgpPbmUgdGhpbmcgdGhhdCBoYXMgYWxzbyBiZWVuIGFkZGVkIGhlcmUgaXMg
YSBzaXh0aCBwYXRjaCB0aGF0IGFkZHMKc29tZSBkb2N1bWVudGF0aW9uIHRvIGVuZHBvaW50LmMg
dG8gZXhwbGFpbiB0aGUgY29uY2VwdCBvZiB0aGUgbmV3CmltcGxlbWVudGF0aW9uLgoKVGhhbmtz
LCBhbmQgcGxlYXNlIGhhdmUgbW9yZSB0ZXN0IHJlc3VsdHMgY29taW5nLgoKCkRhbmllbAoKCkRh
bmllbCBNYWNrICg2KToKICBBTFNBOiBzbmQtdXNiOiBhZGQgc25kX3VzYl9hdWRpby13aWRlIG11
dGV4CiAgQUxTQTogc25kLXVzYjogaW1wbGVtZW50IG5ldyBlbmRwb2ludCBzdHJlYW1pbmcgbW9k
ZWwKICBBTFNBOiBzbmQtdXNiOiBzd2l0Y2ggb3ZlciB0byBuZXcgZW5kcG9pbnQgc3RyZWFtaW5n
IGxvZ2ljCiAgQUxTQTogc25kLXVzYjogcmVtb3ZlIG9sZCBzdHJlYW1pbmcgbG9naWMKICBBTFNB
OiBzbmQtdXNiOiBhZGQgc3VwcG9ydCBmb3IgaW1wbGljaXQgZmVlZGJhY2sKICBBTFNBOiBzbmQt
dXNiOiBhZGQgc29tZSBkb2N1bWVudGF0aW9uCgogc291bmQvdXNiL2NhcmQuYyAgICAgfCAgIDEw
ICstCiBzb3VuZC91c2IvY2FyZC5oICAgICB8ICAgNjIgKysKIHNvdW5kL3VzYi9lbmRwb2ludC5j
IHwgMTYwMiArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQogc291bmQvdXNiL2VuZHBvaW50LmggfCAgIDMyICstCiBzb3VuZC91c2IvcGNtLmMgICAgICB8
ICA0NDAgKysrKysrKysrKysrLS0tCiBzb3VuZC91c2Ivc3RyZWFtLmMgICB8ICAgMzEgKy0KIHNv
dW5kL3VzYi91c2JhdWRpby5oIHwgICAgMiArCiA3IGZpbGVzIGNoYW5nZWQsIDEzODEgaW5zZXJ0
aW9ucygrKSwgNzk4IGRlbGV0aW9ucygtKQoKLS0gCjEuNy43LjQKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFs
c2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
