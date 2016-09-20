From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/4] test: use proper threshold level
 information for user-ctl-element-set test
Date: Tue, 20 Sep 2016 19:13:16 +0900
Message-ID: <e8cb64e3-a513-221a-b336-209bdfaa462a@sakamocchi.jp>
References: <1474123768-13160-1-git-send-email-o-takashi@sakamocchi.jp>
 <1474123768-13160-3-git-send-email-o-takashi@sakamocchi.jp>
 <s5htwdblios.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id DBDA826155E
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 12:13:22 +0200 (CEST)
In-Reply-To: <s5htwdblios.wl-tiwai@suse.de>
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
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, clemens@ladisch.de, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

T24gMjAxNuW5tDA55pyIMjDml6UgMDU6NDgsIFRha2FzaGkgSXdhaSB3cm90ZToKPiBPbiBTYXQs
IDE3IFNlcCAyMDE2IDE2OjQ5OjI2ICswMjAwLAo+IFRha2FzaGkgU2FrYW1vdG8gd3JvdGU6Cj4+
Cj4+IEN1cnJlbnRseSwgdGhpcyB0ZXN0IHByb2dyYW0gdXNlcyBpbnZhbGlkIGFycmF5IGZvciB0
aHJlc2hvbGQgbGV2ZWwKPj4gaW5mb3JtYXRpb24uCj4gCj4gV2hhdCBkbyB5b3UgbWVhbiBleGFj
dGx5IGhlcmUgYXMgInRocmVzaG9sZCBsZXZlbCI/Cj4gVGhpcyB0ZXJtIGlzIGZhaXJseSB1bmNs
ZWFyIHRvIG1lIGFuZCBJIGRvbid0IHJlbWVtYmVyIG9mIGl0IGJlaW5nCj4gZGVmaW5lZCBwcm9w
ZXJseSBhbHRob3VnaCB5b3Ugc2VlbSB0byBoYXZlIHN0YXJ0ZWQgdXNpbmcgaW4gc29tZQo+IGNv
bW1lbnRzLgoKQWhhLiBOb3cgSSBnb3QgaXQuCgpJIGludGVycHJldGVkICdUTFYnIGFzICdUaHJl
c2hvbGQgTGVWZWwnLCBhbmQgaXQncyBjb21wbGV0ZWx5IG15Cm1pc3JlYWRpbmcuIEFjdHVhbGx5
LCBUTFYgaXMgbWFpbmx5IHVzZWQgdG8gZGVzY3JpYmUgdGhlIHJlbGF0aW9uc2hpcApiZXR3ZWVu
IExpbmVhci9kQiByZXByZXNlbnRhdGlvbiwgSG93ZXZlciwgaW4gYSBkZXNpZ24gb2YgQUxTQSBj
b250cm9sCmludGVyZmFjZSwgJ1RMVicgbWVhbnMgYSBkYXRhIHN0cnVjdHVyZSB3aXRoIFR5cGUv
TGVuZ3RoL1ZhbHVlLiBTbyB0aGlzCmxpbmUgZXhwZWN0IHRoZSBUTFYgcGFja2V0IGlzIGxhcmdl
ciB0aGFuIHR3byBtZW1iZXJzIGZvciB0aGUgVCBhbmQgdGhlIEwuCmh0dHA6Ly9naXQua2VybmVs
Lm9yZy9jZ2l0L2xpbnV4L2tlcm5lbC9naXQvdGl3YWkvc291bmQuZ2l0L3RyZWUvc291bmQvY29y
ZS9jb250cm9sLmM/aD12NC44LXJjNiNuMTQ0MAoKSSBoYXZlIHNjYXJjZWx5IHJlYWxpemVkIG15
IG1pc3Rha2VzLiBJJ2xsIHJldmlzZSB0aGlzIHBhdGNoc2V0IHdpdGggYQpuZXcgb25lIHRvIHVw
ZGF0ZSBjb250cm9sIGludGVyZmFjZSBkZXNjcmlwdGlvbi4uLgoKClRoYW5rcyEKClRha2FzaGkg
U2FrYW1vdG8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
QWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6
Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
