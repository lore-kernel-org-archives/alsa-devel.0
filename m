From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH 1/2] ALSA: x86: Fix runtime PM for
 hdmi-lpe-audio
Date: Fri, 2 Nov 2018 18:20:36 +0200
Message-ID: <20181102162036.GT9144@intel.com>
References: <20181024154825.18185-1-ville.syrjala@linux.intel.com>
 <20181101152436.GE9144@intel.com> <s5hh8gzj05i.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <s5hh8gzj05i.wl-tiwai@suse.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, intel-gfx@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCBOb3YgMDIsIDIwMTggYXQgMTA6MzE6MzdBTSArMDEwMCwgVGFrYXNoaSBJd2FpIHdy
b3RlOgo+IE9uIFRodSwgMDEgTm92IDIwMTggMTY6MjQ6MzYgKzAxMDAsCj4gVmlsbGUgU3lyasOk
bMOkIHdyb3RlOgo+ID4gCj4gPiBPbiBXZWQsIE9jdCAyNCwgMjAxOCBhdCAwNjo0ODoyNFBNICsw
MzAwLCBWaWxsZSBTeXJqYWxhIHdyb3RlOgo+ID4gPiBGcm9tOiBWaWxsZSBTeXJqw6Rsw6QgPHZp
bGxlLnN5cmphbGFAbGludXguaW50ZWwuY29tPgo+ID4gPiAKPiA+ID4gQ29tbWl0IDQ2ZTgzMWFi
ZTg2NCAoImRybS9pOTE1L2xwZTogTWFyayBMUEUgYXVkaW8gcnVudGltZSBwbSBhcwo+ID4gPiAi
bm8gY2FsbGJhY2tzIiIpIGJyb2tlIHJ1bnRpbWUgUE0gd2l0aCBscGUgYXVkaW8uIFdlIGNhbiBu
byBsb25nZXIKPiA+ID4gcnVudGltZSBzdXNwZW5kIHRoZSBHUFUgc2luY2UgdGhlIHN5c2ZzICBw
b3dlci9jb250cm9sIGZvciB0aGUKPiA+ID4gbHBlLWF1ZGlvIGRldmljZSBubyBsb25nZXIgZXhp
c3RzIGFuZCB0aGUgZGV2aWNlIGlzIGNvbnNpZGVyZWQKPiA+ID4gYWx3YXlzIGFjdGl2ZS4gV2Ug
Y2FuIGZpeCB0aGlzIGJ5IG5vdCBtYXJraW5nIHRoZSBkZXZpY2UgYXMKPiA+ID4gYWN0aXZlLgo+
ID4gPiAKPiA+ID4gQ2M6IENocmlzIFdpbHNvbiA8Y2hyaXNAY2hyaXMtd2lsc29uLmNvLnVrPgo+
ID4gPiBDYzogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPgo+ID4gPiBDYzogUGllcnJlLUxv
dWlzIEJvc3NhcnQgPHBpZXJyZS1sb3Vpcy5ib3NzYXJ0QGxpbnV4LmludGVsLmNvbT4KPiA+ID4g
Rml4ZXM6IDQ2ZTgzMWFiZTg2NCAoImRybS9pOTE1L2xwZTogTWFyayBMUEUgYXVkaW8gcnVudGlt
ZSBwbSBhcyAibm8gY2FsbGJhY2tzIiIpCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFZpbGxlIFN5cmrD
pGzDpCA8dmlsbGUuc3lyamFsYUBsaW51eC5pbnRlbC5jb20+Cj4gPiAKPiA+IFRha2FzaGksIGRv
IHlvdSB3YW50IHRvIHRha2UgdGhlc2Ugb3Igc2hvdWxkIEkganVzdCBzbWFzaCB0aGVtCj4gPiBp
bnRvIGRybS1pbnRlbD8KPiAKPiBGZWVsIGZyZWUgdG8gZ28gdGhyb3VnaCBkcm0taW50ZWwuCj4g
ICBBY2tlZC1ieTogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPgoKVGhhbmtzLiBTZXJpZXMg
cHVzaGVkLgoKLS0gClZpbGxlIFN5cmrDpGzDpApJbnRlbApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0CkludGVsLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9pbnRlbC1nZngK
