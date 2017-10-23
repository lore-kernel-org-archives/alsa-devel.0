From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 02/14] soundwire: Add SoundWire bus type
Date: Mon, 23 Oct 2017 12:46:18 +0100
Message-ID: <1508759178.29460.1.camel@linux.intel.com>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-3-git-send-email-vinod.koul@intel.com>
 <20171020104528.GC3210@kroah.com> <20171020160134.GT30097@localhost>
 <20171020162123.GA4538@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 31302266A73
 for <alsa-devel@alsa-project.org>; Mon, 23 Oct 2017 13:46:28 +0200 (CEST)
In-Reply-To: <20171020162123.GA4538@kroah.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

PiA+ID4gQW5kIHdoeSBkdWFsIGxpY2Vuc2Ugc29tZXRoaW5nIHRoYXQgd2lsbCBvbmx5IGV2ZXIg
d29yayBvbiBMaW51eD8KPiA+IAo+ID4gV2UgaGF2ZSBub24gTGludXggdXNlcnMgKG1vc3RseSBS
VE9TIGZvbGtzKSB3aGljaCB3ZSB3b3VsZCBsaWtlIHRvCj4gPiBzdXBwb3J0Cj4gPiB3aXRoIGFz
IG11Y2ggYXMgY29tbW9uIGNvZGUuCj4gCj4gTm90ZSwgeW91IG5lZWQgdG8gYmUgVkVSWSBDQVJF
RlVMIGFib3V0IGRvaW5nIHRoaXMuwqDCoFlvdSBuZWVkIHRvIGhhdmUKPiBhbGwgc29ydHMgb2Yg
aW5mcmFzdHJ1Y3R1cmUgc2V0IHVwIGFuZCBpbiBwbGFjZSBhbmQgcGFwZXJ3b3JrIHVwIHRoZQo+
IHdhem9vIGluIG9yZGVyIHRvIG1ha2UgaXQgd29yayBwcm9wZXJseS4KCkludGVsIGtub3dzIHRo
YXQuIFdlIGhhdmUgcHJvY2Vzc2VzIGluIHBsYWNlLiBXZSd2ZSBiZWVuIGRvaW5nIGl0IGZvcgp5
ZWFycyAoQUNQSSwgR3JhcGhpY3MsIC4uKQoKPiBJbiB0aGUgZW5kLCBJIGNhbiBhbG1vc3QgZ3Vh
cmFudGVlIGl0IHdpbGwgbm90IGJlIHdvcnRoIHRoZSBleHRyYQo+IGhhc3NsZSBhbmQgZWZmb3J0
IHlvdSBhcmUgdHJ5aW5nIHRvIGRvIGhlcmUuCgpXZSBkb24ndCB0aGluayB0aGF0IGlzIHRoZSBj
YXNlLCBhbmQgSSdkIGltYWdpbmUgdGhlIE5ldEJTRCwgRnJlZUJTRCwKT3BlbkJTRCwgRHJhZ29u
Zmx5IGFuZCBvdGhlciBwcm9qZWN0cyBwcm9iYWJseSBhbHNvIHByZWZlciBvdXIKYXBwcm9hY2gu
CgpTZXJpb3VzbHksIGdvIHRhbGsgdG8geW91ciBtYW5hZ2VycyBhbmQgY29ycG9yYXRlIGxhd3ll
ciBhYm91dCB0aGlzLAp5b3UgYXJlIGluIGZvciBhIHdvcmxkIG9mIGh1cnQgaWYgeW91IHdhbnQg
dG8gZG8gdGhpcyBpbiBhIHdheSB0aGF0CmFjdHVhbGx5IHdvcmtzIChpLmUuIGRvZXNuJ3QganVz
dCBkZWdyYWRlIHRvIEdQTHYyIG9ubHkgaW5zdGFudGx5LikKCkl0J3MgZmFyIGZyb20gdGhlIG9u
bHkgcHJvamVjdCB3ZSBkbyB0aGlzIHdpdGggZm9yIGF0IGxlYXN0IHRoZSBjb3JlIE9TCmluZGVw
ZW5kZW50IHBhcnRzIG9mIHRoZSBkcml2ZXIuCgpBbGFuCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
