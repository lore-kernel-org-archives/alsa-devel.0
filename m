From: "Jan Pohanka" <xhpohanka@gmail.com>
Subject: ASoC davinci: playing mono sound doubles all samples
 on the i2s (pcm) bus except the first one
Date: Fri, 27 Jan 2012 12:31:53 +0100
Message-ID: <op.v8qqbfafyxxkfz@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 414532434C
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2012 12:31:56 +0100 (CET)
Received: by eaaj12 with SMTP id j12so490509eaa.38
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2012 03:31:55 -0800 (PST)
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

SGVsbG8sCgpJJ20gd29ya2luZyB3aXRoIGEgYm9hcmQgd2l0aCBUSSBkbTM2NSBwcm9jZXNzb3Ig
YW5kIHVzaW5nIE1jQlNQICAKcGhlcmlwaGVyYWwgdG8gc2VuZCBzb3VuZCBzYW1wbGVzIHRvIGEg
R1NNIG1vZHVsZS4gVGhlIGtlcm5lbCB2ZXJzaW9uIGlzICAKMi42LjMyLjE3IGFuZCB0aGUgQVNv
QyBkcml2ZXIgc3RhdGUgaXMgYmFzZWQgb24gdGhpcyBjb21taXQgIApodHRwOi8vYXJhZ28tcHJv
amVjdC5vcmcvZ2l0L3Byb2plY3RzLz9wPWxpbnV4LWRhdmluY2kuZ2l0O2E9Y29tbWl0O2g9YTRj
OGVhMmRkYWVkMmY0NjE2MDZjMjgyOGIxOTc4NjUyNGI1NTFhYwoKSSBoYXZlIGNvbmZpZ3VyZWQg
dGhlIGh3IGludGVyZmFjZSB0byBzZW5kIHR3byB3b3JkcyBpbiBhIGZyYW1lIG9uIDgwMDBIeiwg
IAp0aGlzIGlzIHdvcmtpbmcgZmluZS4gV2hlbiBwbGF5aW5nIG1vbm8gd2F2ZWZvcm1zIEkgbm90
aWNlZCB0aGF0IGFsbCAgCnNhbXBsZXMgYXJlIGRvdWJsZWQgKGl0IHNob3VsZCBiZSBjb3JyZWN0
IGJlY2F1c2Ugc25kX3BjbV9oYXJkd2FyZSBoYXMgIApTTkRSVl9QQ01fSU5GT19JTlRFUkxFQVZF
RCBmbGFnKSBidXQgZXhjZXB0IHRoZSBmaXJzdCBvbmUsIHRoYXQgaXMgc2VuZCAgCm9ubHkgb25j
ZS4gVGhpcyBsZWFkcyB0byBhIHN0YXRlIHdoZW4gb25lIHNhbXBsZSBpbiBlYWNoIGZyYW1lIGlz
IGRlbGF5ZWQuICAKVW5mb3J0dW5hdGVseSBJJ20gbm90IGFuIGV4cGVydCBvbiBBTFNBIGFuZCBB
U29DIGFuZCBJJ20gbm90IHN1cmUgd2hldGhlciAgCnRoaXMgcHJvYmxlbSByaXNlcyBpbiB0aGUg
Y29yZSBvZiBBTFNBIG9yIG9ubHkgaW4gdGhlIGRyaXZlciBmb3IgZGF2aW5jaSAgCmRtMzY1IChw
cm9iYWJseSBzb21ld2hlcmUgaW4gdGhlIGRtYSBoYW5kbGluZykuCgpDb3VsZCBwbGVhc2Ugc29t
ZW9uZSBnaXZlIG1lIHNvbWUgaGludCB3aGVyZSB0byBmaW5kIHRoZSBzb3VyY2Ugb2YgdGhlICAK
cHJvYmxlbT8gSSBob3BlIEkgZGVzY3JpYmVkIHRoZSBzaXR1YXRpb24gZW5vdWdoLi4uCgpiZXN0
IHJlZ2FyZHMKSmFuCgotLSAKVGF0byB6cHLDoXZhIGJ5bGEgdnl0dm/FmWVuYSBwxZlldnJhdG7D
vW0gcG/FoXRvdm7DrW0ga2xpZW50ZW0gT3Blcnk6ICAKaHR0cDovL3d3dy5vcGVyYS5jb20vbWFp
bC8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1k
ZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
