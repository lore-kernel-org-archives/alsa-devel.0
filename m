From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 1/2] ALSA: x86: Fix runtime PM for
 hdmi-lpe-audio
Date: Thu, 25 Oct 2018 07:50:29 +0100
Message-ID: <154045022989.5632.11725434520493726099@skylake-alporthouse-com>
References: <20181024154825.18185-1-ville.syrjala@linux.intel.com>
 <154039634272.5632.2532479909216282819@skylake-alporthouse-com>
 <20181024162845.GE9144@intel.com>
 <154039872477.5632.293946478835350162@skylake-alporthouse-com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <154039872477.5632.293946478835350162@skylake-alporthouse-com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: =?utf-8?b?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, intel-gfx@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

UXVvdGluZyBDaHJpcyBXaWxzb24gKDIwMTgtMTAtMjQgMTc6MzI6MDQpCj4gUXVvdGluZyBWaWxs
ZSBTeXJqw6Rsw6QgKDIwMTgtMTAtMjQgMTc6Mjg6NDUpCj4gPiBPbiBXZWQsIE9jdCAyNCwgMjAx
OCBhdCAwNDo1MjoyMlBNICswMTAwLCBDaHJpcyBXaWxzb24gd3JvdGU6Cj4gPiA+IFF1b3Rpbmcg
VmlsbGUgU3lyamFsYSAoMjAxOC0xMC0yNCAxNjo0ODoyNCkKPiA+ID4gPiBGcm9tOiBWaWxsZSBT
eXJqw6Rsw6QgPHZpbGxlLnN5cmphbGFAbGludXguaW50ZWwuY29tPgo+ID4gPiA+IAo+ID4gPiA+
IENvbW1pdCA0NmU4MzFhYmU4NjQgKCJkcm0vaTkxNS9scGU6IE1hcmsgTFBFIGF1ZGlvIHJ1bnRp
bWUgcG0gYXMKPiA+ID4gPiAibm8gY2FsbGJhY2tzIiIpIGJyb2tlIHJ1bnRpbWUgUE0gd2l0aCBs
cGUgYXVkaW8uIFdlIGNhbiBubyBsb25nZXIKPiA+ID4gPiBydW50aW1lIHN1c3BlbmQgdGhlIEdQ
VSBzaW5jZSB0aGUgc3lzZnMgIHBvd2VyL2NvbnRyb2wgZm9yIHRoZQo+ID4gPiA+IGxwZS1hdWRp
byBkZXZpY2Ugbm8gbG9uZ2VyIGV4aXN0cyBhbmQgdGhlIGRldmljZSBpcyBjb25zaWRlcmVkCj4g
PiA+ID4gYWx3YXlzIGFjdGl2ZS4gV2UgY2FuIGZpeCB0aGlzIGJ5IG5vdCBtYXJraW5nIHRoZSBk
ZXZpY2UgYXMKPiA+ID4gPiBhY3RpdmUuCj4gPiA+IAo+ID4gPiBEbyB5b3UgYWxzbyB3YW50IHRv
IHNlbmQgd2l0aCBhIEhBWCBwYXRjaCB0byBmb3JjZSBzZWxlY3Rpb24gb2YgU05EX1g4Ngo+ID4g
PiBmb3IgQ0k/Cj4gPiAKPiA+IEhtbS4gV291bGQgaGF2ZSBiZWVuIGEgZ29vZCBpZGVhIGEgZmV3
IG1pbnV0ZXMgYWdvLiBOb3Qgc3VyZSBJIHdhbnQKPiA+IHRvIHNwYW0gdGhlIGxpc3QgYWdhaW4u
IERlcGVuZHMgaG93IGxvbmcgaXQnbGwgdGFrZSB0byBhZGp1c3QgdGhlIGNpCj4gPiAuY29uZmln
IEkgc3VwcG9zZS4KPiAKPiBUcnlib3QgYW5kIGxpbmsgdG8gdGhlIHJlc3VsdHM/CgpodHRwczov
L2ludGVsLWdmeC1jaS4wMS5vcmcvdHJlZS9kcm0tdGlwL1RyeWJvdF8zMTE4L2lzc3Vlcy5odG1s
CgpUaGUgZmktYnl0LWNsYXBwZXIgcG0gdGVzdHMgcGFzc2VkIHdoaWNoIGlzIHRoZSBtb3N0IHNp
Z25pZmljYW50IHJlc3VsdC4KRm9yIGVuYWJsaW5nIExQRSBhdWRpbyBpbiBDSSwgaXQgYXBwZWFy
cyB3ZSBuZWVkIHRvIHRyaWNrCnNuZF9oZG1pX2xwZV9hdWRpby5rbyBpbnRvIHVubG9hZGluZyBv
biBkZW1hbmQuCi1DaHJpcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRl
bC1nZngK
