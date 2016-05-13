From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH] alsa-lib:Make snd_atomic_write_* truly
 atomic
Date: Fri, 13 May 2016 14:26:59 +0200
Message-ID: <alpine.DEB.2.02.1605131426000.31333@lnxricardw1.se.axis.com>
References: <570E2279.7060809@axis.com> <s5hwpo14o0n.wl-tiwai@suse.de>
 <alpine.DEB.2.02.1605121446220.31333@lnxricardw1.se.axis.com>
 <s5h37pnctrf.wl-tiwai@suse.de>
 <alpine.DEB.2.02.1605121556390.31333@lnxricardw1.se.axis.com>
 <s5hmvnvbafu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DFC5266992
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 14:27:21 +0200 (CEST)
In-Reply-To: <s5hmvnvbafu.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: =?ISO-8859-15?Q?Arvid_Nihlg=E5rd_Lindell?= <arvidnl@axis.com>, Andreas x Larsson <andrelan@axis.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Ck9uIFRodSwgMTIgTWF5IDIwMTYsIFRha2FzaGkgSXdhaSB3cm90ZToKCj4gWWVhaCwgdGhhdCdz
IHdoeSBJIHN0YXRlZCB0aGUgcHJpbWFyeSBxdWVzdGlvbi4gIFRoZSBhdG9taWMgb3BlcmF0aW9u
Cj4gdGhlcmUgaXMgbW9zdGx5IGNvc21ldGljLCBub3QgcmVhbGx5IGhlbHBmdWwuICBJbiB0aGUg
d2hvbGUgb3RoZXIKPiBvcGVyYXRpb24sIHdlIGRvbid0IGd1YXJhbnRlZSB0aGUgdGhyZWFkIHNh
ZmV0eSBhdCBhbGwuICBTbywKPiBpbXBsZW1lbnRpbmcgdGhlIGF0b21pYyBvcCBvbmx5IGluIGEg
dmVyeSBzbWFsbCBwYXJ0IG9mIHRoZSB3aG9sZSBjb2RlCj4gYXBwZWFycyBsaWtlIGEgc3VwZXJm
bHVvdXMgb3B0aW1pemF0aW9uIHRvIG1lLgoKVGhlIHF1ZXN0aW9uIGlzLCBpZiB3ZSBkZWNpZGUg
dG8gcmVtb3ZlIHRoaXMgYXRvbWljIHN0dWZmLCBob3cgZG8gd2UgCnZlcmlmeSB0aGF0IGl0IGFj
dHVhbGx5IGNhdXNlcyBubyBwcm9ibGVtcywgb24gYWxsIGFyY2hpdGVjdHVyZXMsIGV0Yz8KCi9S
aWNhcmQKLS0gClJpY2FyZCBXb2xmIFdhbmRlcmzDtmYgICAgICAgICAgICAgICAgICAgICAgICAg
ICByaWNhcmR3KGF0KWF4aXMuY29tCkF4aXMgQ29tbXVuaWNhdGlvbnMgQUIsIEx1bmQsIFN3ZWRl
biAgICAgICAgICAgIHd3dy5heGlzLmNvbQpQaG9uZSArNDYgNDYgMjcyIDIwMTYgICAgICAgICAg
ICAgICAgICAgICAgICAgICBGYXggKzQ2IDQ2IDEzIDYxIDMwCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2Et
ZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21h
aWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
