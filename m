From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v6 4/4] drm/i915: set proper N/CTS in modeset
Date: Wed, 02 Sep 2015 16:44:34 +0300
Message-ID: <871teh2awt.fsf@intel.com>
References: <1441174301-144177-1-git-send-email-libin.yang@intel.com>
 <1441174301-144177-4-git-send-email-libin.yang@intel.com>
 <8737yx44hh.fsf@intel.com>
 <96A12704CE18D347B625EE2D4A099D196F88C1@SHSMSX103.ccr.corp.intel.com>
 <87twrd2nyl.fsf@intel.com> <s5h7fo9osh0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <s5h7fo9osh0.wl-tiwai@suse.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

T24gV2VkLCAwMiBTZXAgMjAxNSwgVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPiB3cm90ZToK
PiBPbiBXZWQsIDAyIFNlcCAyMDE1IDExOjAyOjQyICswMjAwLAo+IEphbmkgTmlrdWxhIHdyb3Rl
Ogo+PiAKPj4gPj4gTml0cGljay4gSSdkIHByZWZlciBzb21lIHNoYXJpbmcgd2l0aCB0aGUgc2lt
aWxhciBibG9ja3MgZnJvbSB0aGUKPj4gPj4gZWFybGllciBwYXRjaC4gQWxzbyBhIGRlYnVnIG1l
c3NhZ2Ugb24gbiA9PSAwIHdvdWxkIGJlIG5pY2U7IHlvdQo+PiA+PiBwcm9iYWJseSBkaWRuJ3Qg
bm90aWNlIHlvdXIgYXVkaW9fY29uZmlnX2dldF9yYXRlKCkgd2Fzbid0IHdvcmtpbmcKPj4gPj4g
cmlnaHQKPj4gPj4gYmVjYXVzZSB0aGlzIHNpbGVudGx5IGZlbGwgYmFjayB0byB0aGUgYXV0b21h
dGljIG1vZGUgaGVyZS4KPj4gPgo+PiA+IE9LLCBJIHdpbGwgYWRkIHRoZSBtc2cuIEFzIHlvdSBh
bmQgVmlsbGUgYXJlIGluc2lzdGluZyBvbgo+PiA+IHNoYXJpbmcgY29kZSwgSSB3aWxsIGRvIGl0
IGluIG5leHQgdmVyc2lvbi4KPj4gCj4+IFdlbGwsIHJlYWxseSwgSSdtIGZpbmUgd2l0aCBoYXZp
bmcgdGhhdCBwYXJ0IGR1cGxpY2F0ZWQgYXMtaXMgZm9yIG5vdywKPj4gd2UgY2FuIGZpeCBpdCBs
YXRlci4gTW9yZSBpbXBvcnRhbnQgdG8gZm9jdXMgb24gZ2V0dGluZwo+PiBhdWRpb19jb25maWdf
Z2V0X3JhdGUoKSByaWdodC4KPj4gCj4+IEkgZG9uJ3Qga25vdyBpZiB5b3UncmUgc3RpbGwgdGFy
Z2V0aW5nIHY0LjMgd2l0aCB0aGlzICh1cCB0byBUYWthc2hpIEkKPj4gZ3Vlc3MpIHdlJ2xsIHJl
YWxseSBuZWVkIHRvIHdyYXAgdGhpcyB1cCBzb29uLgo+Cj4gSSdtIGluIGZhdm9yIG9mIG1lcmdp
bmcgdGhpcyBpbnRvIDQuMywgc28gaXQnZCBiZSBhcHByZWNpYXRlZCBpZiBMaWJpbgo+IGNhbiBw
cmVwYXJlIHRoZSBmaXhlZCB2ZXJzaW9uIHNvb25pc2gsIGluZGVlZC4KCklJVUMgcGF0Y2hlcyAx
LTMgd291bGQgYmUgdXNlZnVsIG9uIHRoZWlyIG93biBhbHJlYWR5LCBhbmQgYSBmaXhlZAp2ZXJz
aW9uIG9mIHBhdGNoIDQgY291bGQgZm9sbG93LiBKdXN0IGEgdGhvdWdodC4KCkJSLApKYW5pLgoK
Pgo+Cj4gdGhhbmtzLAo+Cj4gVGFrYXNoaQoKLS0gCkphbmkgTmlrdWxhLCBJbnRlbCBPcGVuIFNv
dXJjZSBUZWNobm9sb2d5IENlbnRlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2ludGVsLWdmeAo=
