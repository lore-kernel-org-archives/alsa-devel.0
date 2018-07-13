From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 1/2] ALSA: HDA: use PCI_BASE_CLASS_DISPLAY to cover more
 display adapters
Date: Fri, 13 Jul 2018 10:31:05 +0200
Message-ID: <20180713083105.GA4265@wunner.de>
References: <1531469162-6472-1-git-send-email-Jim.Qu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1531469162-6472-1-git-send-email-Jim.Qu-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Jim Qu <Jim.Qu-5C7GfCeVMHo@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBKdWwgMTMsIDIwMTggYXQgMDQ6MDY6MDFQTSArMDgwMCwgSmltIFF1IHdyb3RlOgo+
IFNpZ25lZC1vZmYtYnk6IEppbSBRdSA8SmltLlF1QGFtZC5jb20+CgpFbXB0eSBjb21taXQgbWVz
c2FnZS4gIFBsZWFzZSBhZGQgYW4gZXhwbGFuYXRpb24gd2h5IHRoZSBjaGFuZ2UgaXMKbmVjZXNz
YXJ5IHNvIGZvbGtzIGJyb3dzaW5nIHRoZSBnaXQgaGlzdG9yeSB1bmRlcnN0YW5kIGl0J3MgbW90
aXZhdGlvbi4KSSB0aGluayBoZXJlIHRoZSBtb3RpdmF0aW9uIGlzIHRoYXQgdGhlIFBDSSBjbGFz
cyBpcyBzb21ldGltZXMKUENJX0NMQVNTX0RJU1BMQVlfM0Qgb3IgUENJX0NMQVNTX0RJU1BMQVlf
T1RIRVIuCgoKPiAtLS0gYS9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCj4gKysrIGIvc291bmQv
cGNpL2hkYS9oZGFfaW50ZWwuYwo+IEBAIC0zMSw3ICszMSw3IEBACj4gICAqICBDSEFOR0VTOgo+
ICAgKgo+ICAgKiAgMjAwNC4xMi4wMQlNYWpvciByZXdyaXRlIGJ5IHRpd2FpLCBtZXJnZWQgdGhl
IHdvcmsgb2YgcHNob3UKPiAtICogCj4gKyAqCgpTcHVyaW91cyB1bnJlbGF0ZWQgY2hhbmdlLCBw
bGVhc2UgZ2V0IHJpZCBvZiBpdCwgdGhpcyBjbHV0dGVycyB1cAp0aGUgZ2l0IGhpc3RvcnkgdW5u
ZWNlc3NhcmlseS4KCgo+IEBAIC0zOTAsOCArMzkwLDggQEAgc3RhdGljIGNoYXIgKmRyaXZlcl9z
aG9ydF9uYW1lc1tdID0gewo+ICAJW0FaWF9EUklWRVJfU0lTXSA9ICJIREEgU0lTOTY2IiwKPiAg
CVtBWlhfRFJJVkVSX1VMSV0gPSAiSERBIFVMSSBNNTQ2MSIsCj4gIAlbQVpYX0RSSVZFUl9OVklE
SUFdID0gIkhEQSBOVmlkaWEiLAo+IC0JW0FaWF9EUklWRVJfVEVSQV0gPSAiSERBIFRlcmFkaWNp
IiwgCj4gLQlbQVpYX0RSSVZFUl9DVFhdID0gIkhEQSBDcmVhdGl2ZSIsIAo+ICsJW0FaWF9EUklW
RVJfVEVSQV0gPSAiSERBIFRlcmFkaWNpIiwKPiArCVtBWlhfRFJJVkVSX0NUWF0gPSAiSERBIENy
ZWF0aXZlIiwKCkRpdHRvLgoKVGhhbmtzLAoKTHVrYXMKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
