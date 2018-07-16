From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: Re: [alsa-devel] [V2 2/2] vgaswitchreoo: set audio client id in
 vgaswitchreoo enable function
Date: Mon, 16 Jul 2018 16:51:12 +0200
Message-ID: <20180716145112.GA28849@wunner.de>
References: <1531721195-4982-1-git-send-email-Jim.Qu@amd.com>
 <1531721195-4982-2-git-send-email-Jim.Qu@amd.com>
 <20180716144342.GA23508@wunner.de> <s5hmuur44r4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <s5hmuur44r4.wl-tiwai-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jim Qu <Jim.Qu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBKdWwgMTYsIDIwMTggYXQgMDQ6NDc6MTFQTSArMDIwMCwgVGFrYXNoaSBJd2FpIHdy
b3RlOgo+IE9uIE1vbiwgMTYgSnVsIDIwMTggMTY6NDM6NDIgKzAyMDAsCj4gTHVrYXMgV3VubmVy
IHdyb3RlOgo+ID4gCj4gPiBPbiBNb24sIEp1bCAxNiwgMjAxOCBhdCAwMjowNjozNVBNICswODAw
LCBKaW0gUXUgd3JvdGU6Cj4gPiA+ICsKPiA+ID4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KGNsaWVu
dCwgJnZnYXNyX3ByaXYuY2xpZW50cywgbGlzdCkgewo+ID4gPiArCQlpZiAoIWNsaWVudF9pc19h
dWRpbyhjbGllbnQpIHx8IGNsaWVudF9pZChjbGllbnQpICE9Cj4gPiA+ICsJCQlWR0FfU1dJVENI
RVJPT19VTktOT1dOX0lEKQo+ID4gCj4gPiBEb24ndCB5b3UgaGF2ZSB0byBjaGVjayBmb3IKPiA+
IAo+ID4gICAgICAgY2xpZW50X2lkKGNsaWVudCkgIT0gVkdBX1NXSVRDSEVST09fVU5LTk9XTl9J
RCB8IElEX0JJVF9BVURJTwo+ID4gCj4gPiBoZXJlPyAgVGhhdCdzIHRoZSB2YWx1ZSB5b3UgYXNz
aWduIHdoZW4gdGhlIGF1ZGlvIGNsaWVudCByZWdpc3RlcnMsCj4gPiB5ZXQgeW91J3JlIGNoZWNr
aW5nIGZvciBzb21ldGhpbmcgZWxzZSwgc28geW91J3JlIGFsd2F5cyBza2lwcGluZwo+ID4gb3Zl
ciBhdWRpbyBjbGllbnRzLiAgRGlkIHlvdSBhY3R1YWxseSB0ZXN0IHRoaXMgcGF0Y2g/Cj4gCj4g
VGhpcyBzaG91bGQgYmUgT0ssIHNpbmNlIGNsaWVudF9pZCgpIGlzIGEgbWFjcm8gdG8gc3RyaXAg
dG8gdGhlIGNvcmUKPiBpZCBudW1iZXIgd2l0aG91dCBJRF9CSVRfQVVESU8uICBBbmQgY2xpZW50
X2lzX3ZnYSgpICYKPiBjbGllbnRfaXNfYXVkaW8oKSBtYWNyb3Mgd2VyZSByZXdyaXR0ZW4gYWxv
bmcgd2l0aCBpdCwgdG9vLgoKT2theSwgdGhhbmtzIGZvciB0aGUgY2xhcmlmaWNhdGlvbi4KCkx1
a2FzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
