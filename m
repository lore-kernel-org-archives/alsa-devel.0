From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/2] ASoC: hdmi-codec: add channel mapping
	control
Date: Tue, 13 Dec 2016 22:58:17 +0900
Message-ID: <d8b4e5cf-f297-f075-801f-6517393d9ca7@sakamocchi.jp>
References: <1481215067-19362-1-git-send-email-arnaud.pouliquen@st.com>
 <1481215067-19362-3-git-send-email-arnaud.pouliquen@st.com>
 <1cc79b45-d45c-35da-8e85-b349f0338866@sakamocchi.jp>
 <d9d775e9-b077-ae53-6b3f-6c4d6f40c0c3@st.com>
 <be85377b-5aae-5f3a-76da-8f2b851e5cfa@sakamocchi.jp>
 <6589c8e0-f918-10c3-3d7b-39d50b429850@st.com>
 <636ed854-e80c-e18c-314d-54c870d2c1bc@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 550C2266E04
 for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2016 14:58:23 +0100 (CET)
In-Reply-To: <636ed854-e80c-e18c-314d-54c870d2c1bc@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "kernel@stlinux.com" <kernel@stlinux.com>, Takashi Iwai <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, David Airlie <airlied@linux.ie>, "broonie@kernel.org" <broonie@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: alsa-devel@alsa-project.org

T24gMjAxNuW5tDEy5pyIMTPml6UgMjI6MjMsIFRha2FzaGkgU2FrYW1vdG8gd3JvdGU6Cj4gSGkg
QXJuYXVkLAo+Pj4gVGhpcyB0YWJsZSBpcyBpbnZhcmlhbnQgaW4gbGlmZXRpbWUgb2YgdGhlIHN0
b3JhZ2Ugb2JqZWN0LCBhcyB3ZWxsLgo+Pj4gTGV0J3MgcHV0IGludG8gLnJvZGF0YSBzZWN0aW9u
LCB0b28uCj4+Pgo+PiBUaGlzIHRhYmxlIGlzIHVwZGF0ZWQgaW4gaGRtaV9jb2RlY19jZWFfaW5p
dF9jaGFubmVsX2FsbG9jIHNvIGNhbiBub3QgYmUKPj4gY29uc3RhbnQuIEluIHRoZW9yeSBpIGNv
dWxkIGRlY2xhcmUgYWxsIGZpZWxkIGluc3RlYWQgb2YgY29tcHV0aW5nIHNvbWUuCj4+IEJ1dCBm
b3IgbGlzaWJpbGl0eSwgaSB3b3VsZCBwcmVmZXIgdG8ganVzdCBkZWNsYXJlIGNhX2luZGV4ICBh
bmQKPj4gc3BlYWtlcnMgYWxsb2NhdGlvbiBmaWVsZCBpbiB0aGlzIHRhYmxlIChpIHdpbGwgZGVj
bGFyZWQgYm90aCBhcyBjb25zdCkKPgo+IFlvdSBzaG91bGQgcGF5IGVub3VnaCBhdHRlbnRpb24g
dG8gYSBjYXNlIHRoYXQgb25lIHN5c3RlbSBoYXMgc2V2ZXJhbAo+IEdQVXMgdG8gd2hpY2ggcmVs
ZXZhbnQgR1BVIGRyaXZlcnMgcmVnaXN0ZXIgSERNSV9DT0RFQ19EUlZfTkFNRSBwbGF0Zm9ybQo+
IGRldmljZS4gVGhlICdzdGF0aWMnIG1vZGlmaWVyIGhhcyBhbiBlZmZlY3QgdG8ga2VlcCBqdXN0
IG9uZSBzdG9yYWdlCj4gb2JqZWN0LCB0aHVzIHlvdXIgY29kZSBjYXVzZXMgYnVncyBpbiB0aGUg
Y2FzZS4KCk9vcHMsIHRoZSBidWcgaXMgdW5yZWxhdGVkIHRvIHRoZSBzdGF0aWMgbW9kaWZpZXIu
IFRoZSBtb2RpZmllciBpcyBmb3IgCnJlZmVyZW5jZSBzY29wZS4gSSdsbCBjb3JyZWN0IGFzIHRo
ZSBmaWxlIGxvY2FsIHN5bWJvbCBoYXMganVzdCBvbmUgCnN0b3JhZ2Ugb2JqZWN0LgoKKEkgbWln
aHQgYmUgdGlyZWQgdG9uaWdodC4uLikKCgpSZWdhcmRzCgpUYWthc2hpIFNha2Ftb3RvCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFp
bGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNh
LXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
