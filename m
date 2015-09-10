From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: Missing return check of of_property_read_*()
Date: Thu, 10 Sep 2015 11:10:22 +0800
Message-ID: <20150910031022.GA28677@wfg-t540p.sh.intel.com>
References: <s5hlhcfd5az.wl-tiwai@suse.de>
 <20150909145158.GK9751@sirena.org.uk>
 <alpine.DEB.2.10.1509090954430.3157@heelroid>
 <s5hfv2nd45t.wl-tiwai@suse.de>
 <20150909155737.GB20922@sirena.org.uk>
 <s5hvbbjbmzx.wl-tiwai@suse.de>
 <20150909161919.GC20922@sirena.org.uk>
 <s5hr3m7bls5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 5911B260A5B
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2015 05:10:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hr3m7bls5.wl-tiwai@suse.de>
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

SGkgVGFrYXNoaSwKCj4gRmVuZ2d1YW5nLCB3ZSd2ZSBiZWVuIGRpc2N1c3NpbmcgYWJvdXQgdGhl
IGNvbXBpbGUgd2FybmluZ3MgdGhhdAo+IHdlcmVuJ3QgY2F1Z2h0IGJ5IDBkYXlzLiAgSXQgc2Vl
bXMgdGhhdCBpdCdzIHRyaWdnZXJlZCBieSAhQ09ORklHX09GCj4gYnV0IHdpdGggQ09ORklHX0NP
TVBJTEVfVEVTVD15LiAgVGhlbiBJIGdvdCB3YXJuaW5ncyBsaWtlOgo+IAo+IHNvdW5kL3NvYy9j
b2RlY3MvY3MzNWwzMi5jOiBJbiBmdW5jdGlvbiDigJhjczM1bDMyX2kyY19wcm9iZeKAmToKPiBz
b3VuZC9zb2MvY29kZWNzL2NzMzVsMzIuYzoyNzg6Mjogd2FybmluZzog4oCYdmFs4oCZIG1heSBi
ZSB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdtYXliZS11bmluaXRpYWxp
emVkXQo+ICAgc3dpdGNoICh2YWwpIHsKPiAgIF4KPiBzb3VuZC9zb2MvY29kZWNzL2NzMzVsMzIu
YzoyNzI6MTU6IG5vdGU6IOKAmHZhbOKAmSB3YXMgZGVjbGFyZWQgaGVyZQo+ICAgdW5zaWduZWQg
aW50IHZhbDsKPiAgICAgICAgICAgICAgICBeCj4gCj4gVGhlIGFib3ZlIHdhcyB3aXRoIGdjYy01
LjEuMSwgYnV0IExhcnMgdG9sZCB0aGF0IGhlIHNhdyBzdWNoIGEgd2FybmluZwo+IHdpdGggZ2Nj
LTQuOSwgdG9vLgo+IAo+IENvdWxkIHlvdSBhZGQgdGhpcyBraW5kIG9mIGtjb25maWcgaW4geW91
ciB0ZXN0PwoKSXQncyBjb3ZlcmVkIHRocm91Z2ggdGhlIGxvdHMgb2YgcmFuZGNvbmZpZyB0ZXN0
cy4gSG93ZXZlciB0aGUgcHJvYmxlbQppcywgdGhleSBhcmUgcHJldHR5IG9sZCB3YXJuaW5ncyBh
bmQgMGRheSBpZ25vcmVzIG9sZCB3YXJuaW5ncyBiZWNhdXNlCm9sZCB3YXJuaW5ncyBtYXkgd2Vs
bCBiZSBpbnRlbnNpb25hbGx5IGlnbm9yZWQgYnkgcGVvcGxlLiBPbiB0aGUKY29udHJhc3QsIGJ1
aWxkIGVycm9ycyBjYW4gYmUgcmUtcmVwb3J0ZWQgaWYgcmVtYWluIHVuZml4ZWQgZm9yIGxvbmcg
dGltZS4KClRoYW5rcywKRmVuZ2d1YW5nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1w
cm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGlu
Zm8vYWxzYS1kZXZlbAo=
