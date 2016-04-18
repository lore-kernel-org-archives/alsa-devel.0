From: Xing Zheng <zhengxing@rock-chips.com>
Subject: Re: [PATCH 1/3] ASoC: jack: Add a jack detect callback
	via codec
Date: Mon, 18 Apr 2016 18:03:00 +0800
Message-ID: <5714B0D4.7080506@rock-chips.com>
References: <1460967452-24574-1-git-send-email-zhengxing@rock-chips.com>
 <1460967452-24574-2-git-send-email-zhengxing@rock-chips.com>
 <20160418092218.GL3217@sirena.org.uk> <5714AC57.2070901@rock-chips.com>
 <20160418095302.GN3217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.134])
 by alsa0.perex.cz (Postfix) with ESMTP id C80A32650B0
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 12:03:07 +0200 (CEST)
In-Reply-To: <20160418095302.GN3217@sirena.org.uk>
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

SEkgTWFyaywKCk9uIDIwMTblubQwNOaciDE45pelIDE3OjUzLCBNYXJrIEJyb3duIHdyb3RlOgo+
IE9uIE1vbiwgQXByIDE4LCAyMDE2IGF0IDA1OjQzOjUxUE0gKzA4MDAsIFhpbmcgWmhlbmcgd3Jv
dGU6Cj4KPj4gVGhlIHBhdGNoXzEvMyBhZGQgYW4gZXhwb3J0IG9mIGEgZnVuY3Rpb24gdGhhdCBj
YWxscyB0aGUgX2RldGVjdF9qYWNrXwo+PiBmdW5jdGlvbgo+PiB3aGVuIGEgY29kZWMgc3VwcG9y
dHMgamFjayBkZXRlY3Rpb24gYW5kIGZpbGwgdGhlIF9kZXRlY3RfamFja18gZnVuY3Rpb24gaW4K
Pj4gdGhlCj4+IHN0cnVjdCBzbmRfc29jX2NvZGVjX2RyaXZlci4KPiBCdXQgd2h5IHdvdWxkIGFu
eXRoaW5nIGV2ZXIgY2FsbCB0aGlzIGZ1bmN0aW9uPyAgSG93IGlzIHRoaXMgc3VwcG9zZWQgdG8K
PiBiZSB1c2VkPwpJbiBteSBvcGluaW9uLCB0aGlzIGZ1bmN0aW9uIGlzIG1haW5seSB0byBwcm92
aWRlIHNpbXBsZS1jYXJkIChwYXRjaF8yLzMpLgoKVGhpcyBmdW5jdGlvbiB3aWxsIGNhbGwgYW5k
IGluaXRpYWxpemUgamFjayBkZXRlY3Rpb24gaWYgYSBjb2RlYyAKc3VwcG9ydHMgaXQgYW5kIGZp
bGwgdGhlIGRldGVjdF9qYWNrIGZ1bmN0aW9uIChwYXRjaF8zLzMgdXNlIGl0KSwKYW5kLCB3ZSBk
b24ndCBuZWVkIHRvIGNyZWF0ZSBhIGN1c3RvbWl6ZWQgbWFjaGluZSBkcml2ZXIgdG8gY2FsbCB0
aGUgCmNvZGVjIGphY2sgZGV0ZWN0aW9uLCB0aGUgc2ltcGxlLWNhcmQgaXMgYWJsZSB0bwpwYXJz
ZSB0aGVtLgoKVGhhbmtzLgoKLS0gCi0gWGluZyBaaGVuZwoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2Et
ZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21h
aWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
