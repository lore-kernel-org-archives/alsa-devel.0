From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH v3] ALSA: usb-audio: Fix max packet size
 calculation for USB audio
Date: Sun, 11 Oct 2015 16:58:11 +0200
Message-ID: <alpine.DEB.2.02.1510111651550.29096@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1510102326500.1523@lnxricardw1.se.axis.com>
 <s5h612dkh8t.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id B3C6A2606A5
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2015 16:58:16 +0200 (CEST)
In-Reply-To: <s5h612dkh8t.wl-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Ck9uIFN1biwgMTEgT2N0IDIwMTUsIFRha2FzaGkgSXdhaSB3cm90ZToKCj4gPiBUaGUgY29kZSBh
cyBpdCBzdGFuZHMgaGFzIHRoZSBmb2xsb3dpbmcgZXhwcmVzc2lvbiBvbiBsaW5lIDYxMyB0byAK
PiA+IGNhbGN1bGF0ZSB0aGUgbWF4aW11bSBpc29jaHJvbm91cyBwYWNrZXQgc2l6ZToKPiA+IC4u
Lgo+ID4gc2l6ZSB3aGljaCB0cmlnZ2VyZWQgdGhlIGlmIHN0YXRlbWVudCB0byBzdGFydCB3aXRo
Lgo+IAo+IFRoZSB3aG9sZSB0ZXh0IHNob3VsZCBiZSBwdXQgaW4gdGhlIGNoYW5nZWxvZy4gIFRo
YXQncyB3aGF0IENsZW1lbnMKPiBzdWdnZXN0ZWQgaW1wbGljaXRseS4gIFRoZXJlIGlzIG5vIHJl
YXNvbiB0byBoaWRlIHN1Y2ggYSBwcmVjaW91cwo+IGluZm9ybWF0aW9uIGZvciBsYXRlciByZWFk
ZXJzLgoKWWVhaCwgSSB3YXNuJ3Qgc3VyZSBleGFjdGx5IHdoYXQgQ2xlbWVucyB3YXMgaGludGlu
ZyBhdC4KCllvdSBtZWFuIHB1dCB0aGUgd2hvbGUgdGhpbmcgaW4gdGhlIGNvbW1pdCBtZXNzYWdl
PyBJIGNhbiBjZXJ0YWlubHkgZG8gCnRoYS4gSXQgZmVlbHMgYSBiaXQgZXhjZXNzaXZlLCB0byBt
ZSBpdCBzZWVtZWQgdGhhdCBvbmNlIHRoZSBleHByZXNzaW9uIGlzIApjb3JyZWN0IGEgc2hvcnQg
Y29tbWl0IG1lc3NhZ2Ugc2hvdWxkIHN1ZmZpY2UgZXhwbGFpbmluZyB3aGF0IGl0IGRvZXMsIGJ1
dCAKaW4gb3JkZXIgdG8gY29udmluY2UgcG90ZW50aWFsIHJldmlld2VycyAoYW5kIHByb3ZpZGUg
YSBzdGFydGluZyBwb2ludCBmb3IgCmRpc2N1c3Npb24pIGFuIGV4cGxhbmF0aW9uIG9mIHRoZSBw
cm9wb3NlZCBjaGFuZ2UgaXMgbmVlZGVkIGluIG9yZGVyIHRvIApnZXQgdGhlIHBhdGNoIGFwcGxp
ZWQuCgpCdXQgSSBjYW4gY2VydGFpbmx5IHJld29yayBpdCBhbmQgcHV0IGl0IGluIHRoZSBjb21t
aXQgbWVzc2FnZSBpbnN0ZWFkLgoKL1JpY2FyZAotLSAKUmljYXJkIFdvbGYgV2FuZGVybMO2ZiAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHJpY2FyZHcoYXQpYXhpcy5jb20KQXhpcyBDb21tdW5p
Y2F0aW9ucyBBQiwgTHVuZCwgU3dlZGVuICAgICAgICAgICAgd3d3LmF4aXMuY29tClBob25lICs0
NiA0NiAyNzIgMjAxNiAgICAgICAgICAgICAgICAgICAgICAgICAgIEZheCArNDYgNDYgMTMgNjEg
MzAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1k
ZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
