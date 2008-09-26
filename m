From: Pawel MOLL <pawel.moll@st.com>
Subject: Re: Audio buffer mmap-ing on sh arch
	vs.	cache	aliasing	problem
Date: Fri, 26 Sep 2008 12:25:17 +0100
Message-ID: <1222428317.28498.74.camel@bri1004.bri.st.com>
References: <1220527434.3299.2074.camel@bri1004.bri.st.com>
	<s5h63owgdk1.wl%tiwai@suse.de>
	<1222354553.28498.30.camel@bri1004.bri.st.com>
	<s5hbpybcjfc.wl%tiwai@suse.de>  <20080926103045.GA18874@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s200aog10.obsmtp.com (s200aog10.obsmtp.com [207.126.144.124])
	by alsa0.perex.cz (Postfix) with ESMTP id E96DA103819
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Sep 2008 13:25:27 +0200 (CEST)
In-Reply-To: <20080926103045.GA18874@linux-sh.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

PiA+IElJUkMsIGEgc2ltaWxhciBidWZmZXIgaGFuZGxpbmcgKHZpYSB2bWFsbG9jKSBpcyB1c2Vk
IGluIHZpZGVvCj4gPiBkcml2ZXJzLiAgSSBzdXBwb3NlIHRoZXkgZG9uJ3Qgd29yayBhcyB3ZWxs
LCByaWdodD8KCldlbGwsIG91ciBGQiBkcml2ZXIgaXMgYXdhcmUgb2YgdGhlIHByb2JsZW0uIEkg
Y2FuJ3Qgc2F5IG11Y2ggYWJvdXQKb3RoZXIgb25lcy4uLgoKPiA+IERSTSBkcml2ZXIgdXNlcyBf
X3ZtYWxsb2MoKSB3aXRoIFBBR0VfS0VSTkVMX05PQ0FDSEUsIGJ1dCBpdCdzIG9ubHkKPiA+IGZv
ciBQUEMzMiBub24tY29oZXJlbnQuCgpIbS4gUFBDIHdpdGggbm9uLWNvaGVyZW50IGNhY2hlPwoK
LyoKICogT25seSBvbiBjb2hlcmVudCBhcmNoaXRlY3R1cmVzLCB3ZSBjYW4gbW1hcCB0aGUgc3Rh
dHVzIGFuZCB0aGUgY29udHJvbCByZWNvcmRzCiAqIGZvciBlZmZjaWVudCBkYXRhIHRyYW5zZmVy
LiAgT24gb3RoZXJzLCB3ZSBoYXZlIHRvIHVzZSBIV1NZTkMgaW9jdGwuLi4KICovCiNpZiBkZWZp
bmVkKENPTkZJR19YODYpIHx8IGRlZmluZWQoQ09ORklHX1BQQykgfHwgZGVmaW5lZChDT05GSUdf
QUxQSEEpCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXl5eXl5eXl5eXgovKgog
KiBtbWFwIHN0YXR1cyByZWNvcmQKICovCnN0YXRpYyBzdHJ1Y3QgcGFnZSAqIHNuZF9wY21fbW1h
cF9zdGF0dXNfbm9wYWdlKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqYXJlYSwKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBhZGRyZXNz
LCBpbnQgKnR5cGUpCgo+IHg4NiBkb2VzIGl0IGFsc28sIHZpYSBpdHMgUEFHRV9BR1AgZGVmaW5p
dGlvbi4KPiAKPiBUaGVyZSBhcmUgbm90IHRoYXQgbWFueSBwbGF0Zm9ybXMgdGhhdCBkZWZpbmUg
UEFHRV9LRVJORUxfTk9DQUNIRSB0aG91Z2gsCj4gc28gdGhpcyBnZXRzIGEgYml0IG1lc3N5Li4K
Ck9oLCBibG9vZHkgaGVsbCwgSSBoYXZlbid0IHJlYWxpc2VkIHRoYXQhCgo+IFllYWgsIHRoYXQn
cyBub3Qgc2V4eSwgYnV0IG1heWJlIHRoZSBvbmx5IHdvcmtpbmcgY2FzZSByaWdodCBub3cKPiA+
IChiZXR0ZXIgd2l0aCBhcmNoLXNwZWNpZmljIGlmZGVmcykuCgpUaGUgcXVlc3Rpb24gaXMgd2hh
dCBpZmRlZnMgdG8gdXNlIDstKSBCZWNhdXNlIHRoZSBjYWNoZWQvdW5jYWNoZWQKZGVjaXNpb24g
bXVzdCBiZSBjb25zaXN0ZW50IGJldHdlZW4gc25kX3BjbV9kZWZhdWx0X21tYXAoKSBhbmQgYnVm
ZmVyCmFsbG9jYXRpb24uLi4KCldoYXQgYSBtZXNzISA7LSkKClBhd2XFggoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxp
c3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVj
dC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
