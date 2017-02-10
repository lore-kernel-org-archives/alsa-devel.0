From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>
Subject: [PATCH 0/4] ASoC: sun8i-codec: Clean-up
Date: Fri, 10 Feb 2017 10:41:29 +0100
Message-ID: <20170210094133.11382-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 705F426683E
 for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2017 10:42:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@free-electrons.com, wens@csie.org, perex@perex.cz, tiwai@suse.com
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, mylene.josserand@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

SGkgYWxsLAoKVGhhbmtzIHRvIENoZW4tWXUncyByZXZpZXcgWzFdLCBoZXJlIGFyZSBzb21lIHBh
dGNoZXMgdG8gY2xlYW4tdXAKbXkgc3VuOGkgQTMzIGF1ZGlvIGRyaXZlci4KClBhdGNoZXMgdGVz
dGVkIG9uIGFzb2MvZm9yLW5leHQgYnJhbmNoIHdpdGggYWRkaXRpb25uYWwgcGF0Y2hlcwp0byBh
cHBseSBiZWZvcmU6Cmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvOTQ0NzYzMS8K
aHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC85NDIzOTk5LwpodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL3BhdGNoLzk1MjExMjEvCmh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xp
c3RzL2FybS1rZXJuZWwvbXNnNTYwMDkxLmh0bWwKClBhdGNoIDE6IFJlbW92ZXMgdGhlIEhQIHdp
ZGdldCB3aGljaCBpcyBhdmFpbGFibGUgaW4gdGhlIGFuYWxvZyBwYXJ0LgoKUGF0Y2ggMjogVXBk
YXRlIHRoZSBkcml2ZXIgdG8gdXNlIFNPQ19EQVBNX0RPVUJMRSBhbmQgcmVuYW1lIHRoZQpjb250
cm9scyBhY2NvcmRpbmdseS4KClBhdGNoIDM6IENvbnZlcnQgU05EX1NPQ19EQVBNX01JWEVSIHRv
IFNPQ19NSVhFUl9BUlJBWS4KClBhdGNoIDM6IENvbnZlcnQgU05EX1NPQ19EQVBNX0RBQyB0byBT
TkRfU09DX0RBUE1fQUlGX0lOIGRlZmluaXRpb24uCgpUaGUgbGFzdCBDaGVuIFl1J3MgY29tbWVu
dHMgYXJlIHN0aWxsIGluIHByb2dyZXNzIChpZSB1c2Ugb2YKc2V0X3BsbCBhbmQgc2V0X3N5c2Ns
ayBhbmQgcmV3b3JraW5nIHRoZSBhdWRpbyByb3V0ZSkuCgpBZnRlciB0aGlzIHNlcmllcywgYW1p
eGVyIGNvbW1hbmRzIHRvIHRlc3QgYW4gYXVkaW8gZmlsZToKCWFtaXhlciBzZXQgJ0hlYWRwaG9u
ZScgNzUlCglhbWl4ZXIgc2V0ICdIZWFkcGhvbmUnIG9uCglhbWl4ZXIgc2V0ICdEQUMnIG9uCglh
bWl4ZXIgc2V0ICdBSUYxIFNsb3QgMCBEaWdpdGFsIERBQycgb24KClsxXSBodHRwczovL2xrbWwu
b3JnL2xrbWwvMjAxNy8yLzcvMTAzCgpUaGFuayB5b3UgaW4gYWR2YW5jZSwKQmVzdCByZWdhcmRz
LAoKTXlsw6huZSBKb3NzZXJhbmQgKDQpOgogIEFTb0M6IHN1bjhpLWNvZGVjOiBSZW1vdmUgYW5h
bG9nICJIUCIgd2lkZ2V0CiAgQVNvQzogc3VuOGktY29kZWM6IFVwZGF0ZSBtaXhlciB0byB1c2Ug
U09DX0RBUE1fRE9VQkxFCiAgQVNvQzogc3VuOGktY29kZWM6IENvbnZlcnQgdG8gU09DX01JWEVS
X0FSUkFZCiAgQVNvQzogc3VuOGktY29kZWM6IENvbnZlcnQgdG8gdXNlIFNORF9TT0NfREFQTV9B
SUZfSU4KCiBhcmNoL2FybS9ib290L2R0cy9zdW44aS1hMzMuZHRzaSB8ICA0ICstLQogc291bmQv
c29jL3N1bnhpL3N1bjhpLWNvZGVjLmMgICAgfCA2NSArKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDM5IGRl
bGV0aW9ucygtKQoKLS0gCjIuMTEuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXBy
b2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbHNhLWRldmVsCg==
