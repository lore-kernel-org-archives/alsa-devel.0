From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: Missing return check of of_property_read_*()
Date: Thu, 10 Sep 2015 11:23:44 +0800
Message-ID: <20150910032344.GA29391@wfg-t540p.sh.intel.com>
References: <s5hlhcfd5az.wl-tiwai@suse.de>
 <20150909145158.GK9751@sirena.org.uk>
 <alpine.DEB.2.10.1509090954430.3157@heelroid>
 <s5hfv2nd45t.wl-tiwai@suse.de>
 <20150909155737.GB20922@sirena.org.uk>
 <s5hvbbjbmzx.wl-tiwai@suse.de>
 <20150909161919.GC20922@sirena.org.uk>
 <s5hr3m7bls5.wl-tiwai@suse.de>
 <20150910031022.GA28677@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id DC28C260A5B
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2015 05:23:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150910031022.GA28677@wfg-t540p.sh.intel.com>
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
Cc: Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBTZXAgMTAsIDIwMTUgYXQgMTE6MTA6MjJBTSArMDgwMCwgRmVuZ2d1YW5nIFd1IHdy
b3RlOgo+IEhpIFRha2FzaGksCj4gCj4gPiBGZW5nZ3VhbmcsIHdlJ3ZlIGJlZW4gZGlzY3Vzc2lu
ZyBhYm91dCB0aGUgY29tcGlsZSB3YXJuaW5ncyB0aGF0Cj4gPiB3ZXJlbid0IGNhdWdodCBieSAw
ZGF5cy4gIEl0IHNlZW1zIHRoYXQgaXQncyB0cmlnZ2VyZWQgYnkgIUNPTkZJR19PRgo+ID4gYnV0
IHdpdGggQ09ORklHX0NPTVBJTEVfVEVTVD15LiAgVGhlbiBJIGdvdCB3YXJuaW5ncyBsaWtlOgo+
ID4gCj4gPiBzb3VuZC9zb2MvY29kZWNzL2NzMzVsMzIuYzogSW4gZnVuY3Rpb24g4oCYY3MzNWwz
Ml9pMmNfcHJvYmXigJk6Cj4gPiBzb3VuZC9zb2MvY29kZWNzL2NzMzVsMzIuYzoyNzg6Mjogd2Fy
bmluZzog4oCYdmFs4oCZIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlv
biBbLVdtYXliZS11bmluaXRpYWxpemVkXQo+ID4gICBzd2l0Y2ggKHZhbCkgewo+ID4gICBeCj4g
PiBzb3VuZC9zb2MvY29kZWNzL2NzMzVsMzIuYzoyNzI6MTU6IG5vdGU6IOKAmHZhbOKAmSB3YXMg
ZGVjbGFyZWQgaGVyZQo+ID4gICB1bnNpZ25lZCBpbnQgdmFsOwo+ID4gICAgICAgICAgICAgICAg
Xgo+ID4gCj4gPiBUaGUgYWJvdmUgd2FzIHdpdGggZ2NjLTUuMS4xLCBidXQgTGFycyB0b2xkIHRo
YXQgaGUgc2F3IHN1Y2ggYSB3YXJuaW5nCj4gPiB3aXRoIGdjYy00LjksIHRvby4KPiA+IAo+ID4g
Q291bGQgeW91IGFkZCB0aGlzIGtpbmQgb2Yga2NvbmZpZyBpbiB5b3VyIHRlc3Q/Cj4gCj4gSXQn
cyBjb3ZlcmVkIHRocm91Z2ggdGhlIGxvdHMgb2YgcmFuZGNvbmZpZyB0ZXN0cy4gSG93ZXZlciB0
aGUgcHJvYmxlbQo+IGlzLCB0aGV5IGFyZSBwcmV0dHkgb2xkIHdhcm5pbmdzIGFuZCAwZGF5IGln
bm9yZXMgb2xkIHdhcm5pbmdzIGJlY2F1c2UKPiBvbGQgd2FybmluZ3MgbWF5IHdlbGwgYmUgaW50
ZW5zaW9uYWxseSBpZ25vcmVkIGJ5IHBlb3BsZS4gT24gdGhlCj4gY29udHJhc3QsIGJ1aWxkIGVy
cm9ycyBjYW4gYmUgcmUtcmVwb3J0ZWQgaWYgcmVtYWluIHVuZml4ZWQgZm9yIGxvbmcgdGltZS4K
ClRoYXQgc2FpZCwgaWYgYXMgYSBtYWludGFpbmVyIHlvdSBkZW1hbmQgImFsbCB3YXJuaW5ncyBz
aG91bGQgYmUgcXVpZXRlZCIsCkknbGwgaGFwcGlseSBoZWxwIHlvdSByZW1pbmRpbmcgdGhlIHBl
b3BsZSB3aG8gYnJlYWsgdGhlIHJ1bGUuCgpJZiBpdCdzIGEgZ2VuZXJhbGx5IGFncmVlZCBydWxl
IGJ5IHRoZSBtYWludGFpbmVycywgSSdsbCBiZSBoYXBweSB0bwpoZWxwIGd1YXJhbnRlZSBpdCBr
ZXJuZWwgd2lkZS4KClRoYW5rcywKRmVuZ2d1YW5nCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxA
YWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8vYWxzYS1kZXZlbAo=
