From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/5] ASoC codec:
	SSM2602: assign last substream to the master when shutting down
Date: Thu, 4 Jun 2009 05:04:15 -0400
Message-ID: <8bd0f97a0906040204y1dd447fbk76ca3d839c655b23@mail.gmail.com>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
	<1243916337-29953-2-git-send-email-vapier@gentoo.org>
	<20090603105223.GE11507@sirena.org.uk>
	<8bd0f97a0906030537y1e65aa7atec4b0c5cdf4ae2f@mail.gmail.com>
	<20090603145316.GA7315@rakim.wolfsonmicro.main>
	<8bd0f97a0906031826j647efa0bs1ffb6492cfd0ccd8@mail.gmail.com>
	<20090604085921.GD6983@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F70E1037ED
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 11:04:16 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so314949ywq.2
	for <alsa-devel@alsa-project.org>; Thu, 04 Jun 2009 02:04:15 -0700 (PDT)
In-Reply-To: <20090604085921.GD6983@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

T24gVGh1LCBKdW4gNCwgMjAwOSBhdCAwNDo1OSwgTWFyayBCcm93biB3cm90ZToKPiBPbiBXZWQs
IEp1biAwMywgMjAwOSBhdCAwOToyNjozNFBNIC0wNDAwLCBNaWtlIEZyeXNpbmdlciB3cm90ZToK
Pj4gYWx3YXlzIHN1cmUgd2hlbiBpIG5lZWQgdG8gYmFuZyBvbiBDbGlmZiB0byBnZXQgdGhpbmdz
IGZpeGVkIHVwCj4+IChjaGFuZ2VzIHNwbGl0IC8gYmV0dGVyIGNvbW1lbnRzIC8gZXRjLi4uKS4K
Pgo+IElmIHlvdSdyZSBub3Qgc3VyZSB0aGVyZSdzIGEgY2FzZSBmb3IgYmV0dGVyIGNoYW5nZWxv
Z3MgYXQgbGVhc3QhIDopCgptZWgsIGl2ZSByZWFkIHNvbWUgb2YgdGhlIGFsc2EgY2hhbmdlbG9n
cyBhbmQgbG9va2VkIHRocm91Z2ggdGhlIGNvZGUKYW5kIG5vbmUgb2YgaXQgcmVhbGx5IG1hdHRl
cmVkLiAgaSdtIGp1c3QgaGFwcHkgc291bmQgY29tZXMgb3V0IG9mIG15Cm1hY2hpbmUgYXQgYWxs
IChpbmNsdWRpbmcgbWl4aW5nKS4KCj4+IGlmIGZpeGVzIG1pc3MgYSBtZXJnZSB3aW5kb3csIHRo
ZW4gdGhhdCdzIGFuIGlzc3VlLiDCoGJ1dCBpbiBnZW5lcmFsLAo+PiB1c2VycyBvbmx5IHNlZSBm
aXhlcyBwZXIgcmVsZWFzZSwgc28gc2VuZGluZyB0aGluZ3MgbW9yZSBxdWlja2x5IHRoZXJlCj4+
IHdvdWxkbnQgcmVhbGx5IGhlbHAgPwo+Cj4gVGhlIGlzc3VlIGlzIHRoYXQgdGhpbmdzIGFyZSBt
aXNzaW5nIG1lcmdlIHdpbmRvd3MgLSB0aGV5J3JlIGdldHRpbmcKPiBzZW50IGluIGJ1dCBpZiB0
aGVyZSdzIGFueSByZXZpZXcgY29tbWVudHMgYSByZXZpc2VkIHZlcnNpb24gb2YgdGhlCj4gcGF0
Y2ggaXNuJ3QgZ2V0dGluZyBwb3N0ZWQgdW50aWwgdGhlIG5leHQgYmF0Y2ggb2Ygc3VibWlzc2lv
bnMuIMKgSXQncwo+IHRoZXNlIHJldmlzaW9ucyByYXRoZXIgdGhhbiB0aGUgaW5pdGlhbCBzdWJt
aXNzaW9ucyB0aGF0IEknbSBjb25jZXJuZWQKPiBhYm91dC4KCndlbGwgaSBjYW4gc2F5IGknbSBh
ZGRyZXNzaW5nIHRoYXQsIGJ1dCByZWFsbHkgbm90aGluZyBpIHNheSBtYXR0ZXJzCmFzIHRoaXMg
d2lsbCBvbmx5IGJlIHByb3ZlbiBvdmVyIHRpbWUuCi1taWtlCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2Et
ZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21h
aWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
