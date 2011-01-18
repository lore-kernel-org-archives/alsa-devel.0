From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: WL1273 FM Radio driver...
Date: Tue, 18 Jan 2011 17:04:23 +0200
Message-ID: <1295363063.25951.67.camel@masi.mnp.nokia.com>
Reply-To: matti.j.aaltonen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 64527245DD
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 16:04:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, mchehab@redhat.com, hverkuil@xs4all.nl, sameo@linux.intel.com, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

SGVsbG8KCkkgaGF2ZSBiZWVuIHRyeWluZyB0byBnZXQgdGhlIFdMMTI3MyBGTSByYWRpbyBkcml2
ZXIgaW50byB0aGUga2VybmVsIGZvcgpzb21lIHRpbWUuIEl0IGhhcyBiZWVuIGtpbmQgb2YgZGlm
ZmljdWx0LCBvbmUgb2YgdGhlIHJlYXNvbnMgaXMgdGhhdCBJCmRpZG4ndCByZWFsaXplIEkgc2hv
dWxkIGhhdmUgdHJpZWQgdG8gaW52b2x2ZSBhbGwgcmVsZXZhbnQgbWFpbnRhaW5lcnMKdG8gdGhl
IGRpc2N1c3Npb24gZm9ybSB0aGUgYmVnaW5uaW5nIChBc29DLCBNZWRpYSBhbmQgTUZEKS4gQXQg
TWFyaydzCnN1Z2dlc3Rpb24gSSdtIHRyeWluZyB0byByZW9wZW4gdGhlIGRpc2N1c3Npb24gbm93
LgoKVGhlIGRyaXZlciBjb25zaXN0cyBvZiBhbiBNRkQgY29yZSBhbmQgdHdvIGNoaWxkIGRyaXZl
cnMgKHRoZSBhdWRpbwpjb2RlYyBhbmQgdGhlIFY0TDIgZHJpdmVyKS4gQW5kIHRoZSBxdWVzdGlv
biBpcyBtYWlubHkgYWJvdXQgdGhlIHJvbGUgb2YKdGhlIE1GRCBkcml2ZXI6IHRoZSBvcmlnaW5h
bCBkZXNpZ24gaGFkIHRoZSBJTyBmdW5jdGlvbnMgaW4gdGhlIGNvcmUuCkN1cnJlbnRseSB0aGUg
Y29yZSBpcyBwcmFjdGljYWxseSBlbXB0eSBtYWlubHkgYmVjYXVzZSBNYXVybyB2ZXJ5CnN0cm9u
Z2x5IHdhbnRlZCB0byBoYXZlIOKAnGV2ZXJ5dGhpbmfigJ0gaW4gdGhlIFY0TDIgZHJpdmVyLgoK
SSBsaWtlZCB0aGUgb3JpZ2luYWwgZGVzaWduIGJlY2F1c2UgaXQgZGlkbid0IGhhdmUgdGhlIGJ1
ZyB0aGF0IHRoZQpjdXJyZW50IE1GRCBoYXM6IHRoZSBjb2RlYyBjYW4gYmUgaW5pdGlhbGl6ZWQg
YmVmb3JlIHRoZSBWNEwyIHBhcnQgc2V0cwp0aGUgSU8gZnVuY3Rpb24gcG9pbnRlcnMuIEhhdmlu
ZyBpbiBwcmluY2lwbGUgZXF1YWxseSBjYXBhYmxlIGludGVyZmFjZQpkcml2ZXJzIGlzIHN5bW1l
dHJpY2FsIGFuZCBlc3RoZXRpY2FsbHkgcGxlYXNpbmc6LSkgQWxzbyBzb21lYm9keSBjb3VsZApl
YXNpbHkgbGVhdmUgb3V0IHRoZSBleGlzdGluZyBpbnRlcmZhY2VzIGFuZCBjcmVhdGUgYSBjb21w
bGV0ZWx5IG5ldyBvbmUKYmFzZWQgZm9yIGV4YW1wbGUgdG8gc3lzZnMgb3Igc29tZXRoaW5nLi4u
IEhhdmluZyB0aGUgSU8gaW4gdGhlIGNvcmUKd291bGQgYWxzbyBjb252ZW5pZW50bHkgaGlkZSB0
aGUgcGh5c2ljYWwgY29tbXVuaWNhdGlvbiBsYXllciBhbmQgbWFrZQppdCBlYXN5IHRvIGNoYW5n
ZSBJMkMgdG8gVUFSVCwgd2hpY2ggaXMgYWxzbyBzdXBwb3J0ZWQgYnkgdGhlIGNoaXAuCgpUaGFu
a3MsCk1hdHRpCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0
dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
