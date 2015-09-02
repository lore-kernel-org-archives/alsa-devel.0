From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v6 1/4] drm/i915: Add audio sync_audio_rate
	callback
Date: Wed, 02 Sep 2015 10:23:38 +0300
Message-ID: <87a8t54745.fsf@intel.com>
References: <1441174301-144177-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1441174301-144177-1-git-send-email-libin.yang@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: libin.yang@intel.com, alsa-devel@alsa-project.org, tiwai@suse.de, intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch, ville.syrjala@linux.intel.com
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCAwMiBTZXAgMjAxNSwgbGliaW4ueWFuZ0BpbnRlbC5jb20gd3JvdGU6Cj4gRnJvbTog
TGliaW4gWWFuZyA8bGliaW4ueWFuZ0BpbnRlbC5jb20+Cj4KPiBBZGQgdGhlIHN5bmNfYXVkaW9f
cmF0ZSBjYWxsYmFjay4KPgo+IFdpdGggdGhlIGNhbGxiYWNrLCBhdWRpbyBkcml2ZXIgY2FuIHRy
aWdnZXIKPiBpOTE1IGRyaXZlciB0byBzZXQgdGhlIHByb3BlciBOL0NUUyBvciBOL00KPiBiYXNl
ZCBvbiBkaWZmZXJlbnQgc2FtcGxlIHJhdGVzLgo+Cj4gU2lnbmVkLW9mZi1ieTogTGliaW4gWWFu
ZyA8bGliaW4ueWFuZ0BpbnRlbC5jb20+CgpSZXZpZXdlZC1ieTogSmFuaSBOaWt1bGEgPGphbmku
bmlrdWxhQGludGVsLmNvbT4KCj4gLS0tCj4gIGluY2x1ZGUvZHJtL2k5MTVfY29tcG9uZW50Lmgg
fCA3ICsrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvZHJtL2k5MTVfY29tcG9uZW50LmggYi9pbmNsdWRlL2RybS9pOTE1X2Nv
bXBvbmVudC5oCj4gaW5kZXggYzlhOGI2NC4uOGFkNmYxYiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRl
L2RybS9pOTE1X2NvbXBvbmVudC5oCj4gKysrIGIvaW5jbHVkZS9kcm0vaTkxNV9jb21wb25lbnQu
aAo+IEBAIC0zMyw2ICszMywxMyBAQCBzdHJ1Y3QgaTkxNV9hdWRpb19jb21wb25lbnQgewo+ICAJ
CXZvaWQgKCpwdXRfcG93ZXIpKHN0cnVjdCBkZXZpY2UgKik7Cj4gIAkJdm9pZCAoKmNvZGVjX3dh
a2Vfb3ZlcnJpZGUpKHN0cnVjdCBkZXZpY2UgKiwgYm9vbCBlbmFibGUpOwo+ICAJCWludCAoKmdl
dF9jZGNsa19mcmVxKShzdHJ1Y3QgZGV2aWNlICopOwo+ICsJCS8qKgo+ICsJCSAqIEBzeW5jX2F1
ZGlvX3JhdGU6IHNldCBuL2N0cyBiYXNlZCBvbiB0aGUgc2FtcGxlIHJhdGUKPiArCQkgKgo+ICsJ
CSAqIENhbGxlZCBmcm9tIGF1ZGlvIGRyaXZlci4gQWZ0ZXIgYXVkaW8gZHJpdmVyIHNldHMgdGhl
Cj4gKwkJICogc2FtcGxlIHJhdGUsIGl0IHdpbGwgY2FsbCB0aGlzIGZ1bmN0aW9uIHRvIHNldCBu
L2N0cwo+ICsJCSAqLwo+ICsJCWludCAoKnN5bmNfYXVkaW9fcmF0ZSkoc3RydWN0IGRldmljZSAq
LCBpbnQgcG9ydCwgaW50IHJhdGUpOwo+ICAJfSAqb3BzOwo+ICB9Owo+ICAKPiAtLSAKPiAxLjku
MQo+CgotLSAKSmFuaSBOaWt1bGEsIEludGVsIE9wZW4gU291cmNlIFRlY2hub2xvZ3kgQ2VudGVy
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLWdm
eCBtYWlsaW5nIGxpc3QKSW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
