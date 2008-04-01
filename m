From: Cliff Cai <xcahua@hotmail.com>
Subject: How to reduce delay between playback and capture for
	echo canceller
Date: Tue, 1 Apr 2008 14:17:33 +0000
Message-ID: <BAY110-W2212683DC70884C8B4A947C9F50@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc2-s7.bay0.hotmail.com (bay0-omc2-s7.bay0.hotmail.com
	[65.54.246.143]) by alsa0.perex.cz (Postfix) with ESMTP id 5AF99249C0
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Apr 2008 16:17:35 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

CkhpIGFsbCwKIAogIEknbSBwbGF5aW5nIGEgbGlucGhvbmUgYmFzZWQgVk9JUCBkZW1vIGJvYXJk
IHRoZXNlIGRheXMsdGhlIGJvYXJkIGNhbiBjb25uZWN0IGRpZmZlcmVudCBzb3VuZGNhcmQgZGF1
Z2h0ZXIgYm9hcmQgCmFzIHBsYXliYWNrIGFuZCBjYXB0dXJlIGRldmljZXMgdGhyb3VnaCAgSTJT
IG9yIEFDOTcuVGhlbiBJIGV4cGVyaWVuY2UgYSBiYWQgZWNobyBvbiBteSBQQyh1c2luZyBsaXBo
b25lIGFuZCBoZWFkc2V0KSB3aGVuIAp0YWxrIHdpdGggdGhlIGJvYXJkICh3aXRoIHNwZWFrZXIg
YW5kIE1JQyBvbiBib2FyZCkuU28gSSBlbmFibGUgdGhlIGVjaG8gY2FuY2VsbGVyIChiYXNlZCBv
biBzcGVleCkgZm9yIGl0LgpPbmUgb2YgbXkgc291bmQgY2FyZCAoY29ubmVjdGVkIGJ5IEkyUykg
d29ya3MgcHJldHR5IHdlbGwsYnV0IHRoZSBvdGhlciBvbmUgKGNvbm5lY3RlZCBieSBBQzk3KSBk
b2Vzbid0IHdvcmsuClRocm91Z2ggdGhlIGRpYWdub3N0aWMgdG9vbCBwcm92aWRlZCBieSBzcGVl
eCBJIGZpbmQgdGhhdCB0aGUgYWM5NyBvbmUgaGFzIGEgYmlnIGRlbGF5IGJldHdlZW4gcGxheWVk
IHNpZ25hbChyZWZlcmVuY2Ugc2lnbmFsKQphbmQgY2FwdHVyZWQgc2lnbmFsLkp1c3QgdGhlIGRl
bGF5IG1ha2UgZWNobyBjYW5jZWxsZXIgZG9uJ3Qgd29yayBhcyBleHBlY3RhdGlvbi5TbyBJIHRo
aW5rIHRoZSBkcml2ZXIgZm9yIHRoZSBBQzk3IHNvdW5kY2FyZApuZWVkIHNvbWUgaW1wcm92ZW1l
bnQgdG8gcmVkdWNlIHRoZSBkZWxheS4KIApIYXMgYW55b25lIGEgdXNlZnVsbCBkaXJlY3Rpb24g
Zm9yIG1lPyBUaGFua3MgaW4gYWR2YW5jZSxCZXN0IFJlZ2FyZHMKIApDbGlmZiBDYWkKIAogCiAK
IAogCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCk1TTiDW0M7EzfijrNfu0MLKscnQyfq77tfK0bajrLDXwey+27yvw8W7p6Gj
Cmh0dHA6Ly9jbi5tc24uY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0
Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxz
YS1kZXZlbAo=
