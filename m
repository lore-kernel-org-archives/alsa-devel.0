From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH 0/8] Add ASoC support for AMD APUs [v4]
Date: Tue, 20 Oct 2015 10:19:38 +1000
Message-ID: <CAPM=9txzacA+04MA5VOjF3V3EuQguuF244PSvQ3pXKkhKNV__Q@mail.gmail.com>
References: <1444320760-21936-1-git-send-email-alexander.deucher@amd.com>
 <CADnq5_OwjyjL+Xn3-f==Z3qPCD03kM-+8f5fwvKxvwRwXyyMJQ@mail.gmail.com>
 <20151020001422.GV32054@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20151020001422.GV32054@sirena.org.uk>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Bayyavarapu,
 Maruthi" <maruthi.bayyavarapu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, rajeev kumar <rajeevkumar.linux@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

T24gMjAgT2N0b2JlciAyMDE1IGF0IDEwOjE0LCBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5v
cmc+IHdyb3RlOgo+IE9uIE1vbiwgT2N0IDE5LCAyMDE1IGF0IDExOjExOjE5QU0gLTA0MDAsIEFs
ZXggRGV1Y2hlciB3cm90ZToKPgo+PiBQaW5nPyAgQW55b25lIGhhZCBhIGNoYW5jZSB0byBsb29r
IG92ZXIgdGhpcyBsYXRlc3QgcmV2aXNpb24/ICBJIHRoaW5rCj4+IHdlJ3ZlIGFkZHJlc3NlZCBh
bGwgdGhlIG91dHN0YW5kaW5nIGNvbW1lbnRzLgo+Cj4gUGxlYXNlIGRvbid0IHNlbmQgY29udGVu
dCBmcmVlIHBpbmdzIGFuZCBwbGVhc2UgYWxsb3cgYSByZWFzb25hYmxlIHRpbWUKPiBmb3IgcmV2
aWV3LiAgUGVvcGxlIGdldCBidXN5LCBnbyBvbiBob2xpZGF5LCBhdHRlbmQgY29uZmVyZW5jZXMg
YW5kIHNvCj4gb24gc28gdW5sZXNzIHRoZXJlIGlzIHNvbWUgcmVhc29uIGZvciB1cmdlbmN5IChs
aWtlIGNyaXRpY2FsIGJ1ZyBmaXhlcykKPiBwbGVhc2UgYWxsb3cgYXQgbGVhc3QgYSBjb3VwbGUg
b2Ygd2Vla3MgZm9yIHJldmlldy4gIFNlbmRpbmcgY29udGVudAo+IGZyZWUgcGluZ3MganVzdCBh
ZGRzIHRvIHRoZSBtYWlsIHZvbHVtZSAoaWYgdGhleSBhcmUgc2VlbiBhdCBhbGwpIGFuZCBpZgo+
IHNvbWV0aGluZyBoYXMgZ29uZSB3cm9uZyB5b3UnbGwgaGF2ZSB0byByZXNlbmQgdGhlIHBhdGNo
ZXMgYW55d2F5LgoKSGkgTWFyaywKClRvIGJlIGhvbmVzdCwgbWFpbnRhaW5lcnMgYWxzbyBmb3Jn
ZXQsIGdldCBidXN5IGRvaW5nIG90aGVyIHRoaW5ncywKZ2V0IGRpdmVydGVkIGRvd24gcmFiYml0
IGhvbGVzLApnZXQgdGFza2VkIHRvIGRvIHNvbWV0aGluZyBlbHNlLiBXZSBhbHNvIGRvbid0IGtu
b3cgd2hlbiBtYWludGFpbmVycwphcmUgYXQgY29uZmVyZW5jZXMsCm9yIG9uIGhvbGlkYXlzLgoK
SSBkb24ndCB0aGluayByZXBpbmdpbmcgcGF0Y2hlcyBhZnRlciAxMSBkYXlzIGlzIHRoYXQgdW5y
ZWFzb25hYmxlIGlmCnlvdSd2ZSBnb3R0ZW4gcmVwbGllcyBxdWlja2VyCnRoYW4gdGhhdCBwcmV2
aW91c2x5LgoKSSdkIHByZWZlciBhIGNvbnRlbnQgZnJlZSBwaW5nLCByYXRoZXIgdGhhbiBhbm90
aGVyIHJvdW5kIG9mIHRoZQpwYXRjaGVzIHdpdGggdHdvIHNwZWxsaW5nIG1pc3Rha2VzCmZpeGVk
IGV0Yy4KCkRhdmUuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
Cg==
