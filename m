From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] drm/i915: set proper N/CTS in modeset
Date: Wed, 23 Sep 2015 14:20:23 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1971A4B3@shsmsx102.ccr.corp.intel.com>
References: <1441932051-48719-1-git-send-email-libin.yang@intel.com>
 <87613av7n0.fsf@intel.com> <s5hlhbx8r5q.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <s5hlhbx8r5q.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Takashi Iwai <tiwai@suse.de>, Jani Nikula <jani.nikula@linux.intel.com>
Cc: "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

SGkgVGFrYXNoaSwKCgo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gRnJvbTogVGFrYXNo
aSBJd2FpIFttYWlsdG86dGl3YWlAc3VzZS5kZV0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJl
ciAyMywgMjAxNSA0OjQxIFBNCj4gVG86IEphbmkgTmlrdWxhCj4gQ2M6IFlhbmcsIExpYmluOyBh
bHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmc7IGludGVsLQo+IGdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc7IGRhbmllbC52ZXR0ZXJAZmZ3bGwuY2g7Cj4gdmlsbGUuc3lyamFsYUBsaW51eC5pbnRl
bC5jb20KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vaTkxNTogc2V0IHByb3BlciBOL0NUUyBp
biBtb2Rlc2V0Cj4gCj4gT24gV2VkLCAxNiBTZXAgMjAxNSAxNTowMzoxNSArMDIwMCwKPiBKYW5p
IE5pa3VsYSB3cm90ZToKPiA+Cj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9pOTE1X2Nv
bXBvbmVudC5oCj4gYi9pbmNsdWRlL2RybS9pOTE1X2NvbXBvbmVudC5oCj4gPiA+IGluZGV4IGU2
ZDM1ZDcuLjg5ZGM3ZDYgMTAwNjQ0Cj4gPiA+IC0tLSBhL2luY2x1ZGUvZHJtL2k5MTVfY29tcG9u
ZW50LmgKPiA+ID4gKysrIGIvaW5jbHVkZS9kcm0vaTkxNV9jb21wb25lbnQuaAo+ID4gPiBAQCAt
MjQsOCArMjQsMTggQEAKPiA+ID4gICNpZm5kZWYgX0k5MTVfQ09NUE9ORU5UX0hfCj4gPiA+ICAj
ZGVmaW5lIF9JOTE1X0NPTVBPTkVOVF9IXwo+ID4gPgo+ID4gPiArLyogTUFYX1BPUlQgaXMgdGhl
IG51bWJlciBvZiBwb3J0Cj4gPiA+ICsgKiBJdCBtdXN0IGJlIHN5bmMgd2l0aCBJOTE1X01BWF9Q
T1JUUyBkZWZpbmVkIGk5MTVfZHJ2LmgKPiA+ID4gKyAqIDUgc2hvdWxkIGJlIGVub3VnaCBhcyBv
bmx5IEhTVywgQkRXLCBTS0wgbmVlZCBzdWNoIGZpeC4KPiA+Cj4gPiBZb3Ugc2hvdWxkIHByb2Jh
Ymx5IGFkZCBCVUlMRF9CVUdfT04oTUFYX1BPUlRTICE9Cj4gSTkxNV9NQVhfUE9SVFMpCj4gPiBz
b21ld2hlcmUgbmVhciB0aGUgbG9vcCBhYm92ZS4gT3IgYXQgbGVhc3QgY2hhbmdlCj4gSTkxNV9N
QVhfUE9SVFMgdG8KPiA+IEFSUkFZX1NJWkUoYWNvbXAtPmF1ZF9zYW1wbGVfcmF0ZSkgaW4gdGhl
IGxvb3AgdG8gbm90IHJ1biBvdmVyCj4gdGhlIGFycmF5Cj4gPiBpZiBNQVhfUE9SVFMgZ2V0cyBv
dXQgb2Ygc3luYy4KPiA+Cj4gPiBXaXRoIHRoYXQgYWRkcmVzc2VkIG9uZSB3YXkgb3IgYW5vdGhl
ciwgdGhpcyBpcwo+ID4KPiA+IFJldmlld2VkLWJ5OiBKYW5pIE5pa3VsYSA8amFuaS5uaWt1bGFA
aW50ZWwuY29tPgo+IAo+IExpYmluLCBjb3VsZCB5b3UgcmVzdWJtaXQgdGhlIHBhdGNoIHdpdGgg
Zml4ZXMgSmFuaSBzdWdnZXN0ZWQ/Cj4gVGhlbiBJJ20gZ29pbmcgdG8gbWVyZ2UgaXQgdG8gdGhl
IGV4aXN0aW5nIHRvcGljL2RybS1zeW5jLWF1ZGlvLXJhdGUKPiBicmFuY2guCgpPSywgSSB3aWxs
IHNlbmQgaXQgdG9tb3Jyb3cuCgpSZWdhcmRzLApMaWJpbgoKPiAKPiAKPiB0aGFua3MsCj4gCj4g
VGFrYXNoaQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJ
bnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
