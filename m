From: Xing Zheng <zhengxing@rock-chips.com>
Subject: Re: [PATCH 1/3] ASoC: jack: Add a jack detect callback
	via codec
Date: Mon, 18 Apr 2016 18:20:00 +0800
Message-ID: <5714B4D0.90406@rock-chips.com>
References: <1460967452-24574-1-git-send-email-zhengxing@rock-chips.com>
 <1460967452-24574-2-git-send-email-zhengxing@rock-chips.com>
 <20160418092218.GL3217@sirena.org.uk> <5714AC57.2070901@rock-chips.com>
 <20160418095302.GN3217@sirena.org.uk> <5714B0D4.7080506@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.134])
 by alsa0.perex.cz (Postfix) with ESMTP id B25F52650B0
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 12:20:08 +0200 (CEST)
In-Reply-To: <5714B0D4.7080506@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, heiko@sntech.de, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org, Adam.Thomson@diasemi.com, jay.xu@rock-chips.com
List-Id: alsa-devel@alsa-project.org

T24gMjAxNuW5tDA05pyIMTjml6UgMTg6MDMsIFhpbmcgWmhlbmcgd3JvdGU6Cj4gSEkgTWFyaywK
Pgo+IE9uIDIwMTblubQwNOaciDE45pelIDE3OjUzLCBNYXJrIEJyb3duIHdyb3RlOgo+PiBPbiBN
b24sIEFwciAxOCwgMjAxNiBhdCAwNTo0Mzo1MVBNICswODAwLCBYaW5nIFpoZW5nIHdyb3RlOgo+
Pgo+Pj4gVGhlIHBhdGNoXzEvMyBhZGQgYW4gZXhwb3J0IG9mIGEgZnVuY3Rpb24gdGhhdCBjYWxs
cyB0aGUgX2RldGVjdF9qYWNrXwo+Pj4gZnVuY3Rpb24KPj4+IHdoZW4gYSBjb2RlYyBzdXBwb3J0
cyBqYWNrIGRldGVjdGlvbiBhbmQgZmlsbCB0aGUgX2RldGVjdF9qYWNrXyAKPj4+IGZ1bmN0aW9u
IGluCj4+PiB0aGUKPj4+IHN0cnVjdCBzbmRfc29jX2NvZGVjX2RyaXZlci4KPj4gQnV0IHdoeSB3
b3VsZCBhbnl0aGluZyBldmVyIGNhbGwgdGhpcyBmdW5jdGlvbj8gIEhvdyBpcyB0aGlzIHN1cHBv
c2VkIHRvCj4+IGJlIHVzZWQ/Cj4gSW4gbXkgb3BpbmlvbiwgdGhpcyBmdW5jdGlvbiBpcyBtYWlu
bHkgdG8gcHJvdmlkZSBzaW1wbGUtY2FyZCAKPiAocGF0Y2hfMi8zKS4KPgo+IFRoaXMgZnVuY3Rp
b24gd2lsbCBjYWxsIGFuZCBpbml0aWFsaXplIGphY2sgZGV0ZWN0aW9uIGlmIGEgY29kZWMgCj4g
c3VwcG9ydHMgaXQgYW5kIGZpbGwgdGhlIGRldGVjdF9qYWNrIGZ1bmN0aW9uIChwYXRjaF8zLzMg
dXNlIGl0KSwKPiBhbmQsIHdlIGRvbid0IG5lZWQgdG8gY3JlYXRlIGEgY3VzdG9taXplZCBtYWNo
aW5lIGRyaXZlciB0byBjYWxsIHRoZSAKPiBjb2RlYyBqYWNrIGRldGVjdGlvbiwgdGhlIHNpbXBs
ZS1jYXJkIGlzIGFibGUgdG8KPiBwYXJzZSB0aGVtLgo+Cj4gVGhhbmtzLgo+ClRoZSBkdHMgdXNh
Z2UgbGlrZSB0aGlzOgoKc291bmQgewogICAgICAgICAuLi4uLi4KICAgICAgICAgc2ltcGxlLWF1
ZGlvLWNhcmQsZGFpLWxpbmtAMCB7CiAgICAgICAgICAgICBmb3JtYXQgPSAiaTJzIjsKICAgICAg
ICAgICAgIGNwdSB7CiAgICAgICAgICAgICAgICAgc291bmQtZGFpID0gPCZpMnMwPjsKICAgICAg
ICAgICAgIH07CgogICAgICAgICAgICAgY29kZWMgewogICAgICAgICAgICAgICAgIHNvdW5kLWRh
aSA9IDwmY29kZWM+OwoKICAgICAgICAgICAgICAgICBzaW1wbGUtYXVkaW8tY2FyZCxjb2RlYy1q
YWNrID0KICAgICAgICAgICAgICAgICAgICAgIkpBQ0tfSEVBRFNFVCIsCiAgICAgICAgICAgICAg
ICAgICAgICJKQUNLX0JUTl8wIiwKICAgICAgICAgICAgICAgICAgICAgIkpBQ0tfQlROXzEiLAog
ICAgICAgICAgICAgICAgICAgICAiSkFDS19CVE5fMiIsCiAgICAgICAgICAgICAgICAgICAgICJK
QUNLX0JUTl8zIjsKICAgICAgICAgICAgIH07CiAgICAgICAgIH07CiAgICAgICAgIC4uLi4uLgp9
OwoKLS0gCi0gWGluZyBaaGVuZwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9q
ZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8v
YWxzYS1kZXZlbAo=
