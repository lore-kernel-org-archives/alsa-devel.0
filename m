From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/7] ALSA: firewire-tascam: add skeleton
 for TASCAM FireWire series
Date: Sun, 4 Oct 2015 20:54:44 +0900
Message-ID: <56111384.30201@sakamocchi.jp>
References: <1443704537-3345-2-git-send-email-o-takashi@sakamocchi.jp>
 <201510012147.nfdOjouA%fengguang.wu@intel.com> <s5hd1wxdyr7.wl-tiwai@suse.de>
 <560ED14A.2060404@ladisch.de> <560F3EB0.7020508@sakamocchi.jp>
 <560F9C6E.70800@ladisch.de> <560FA68E.8050501@sakamocchi.jp>
 <20151003125402.7581963b@kant>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 3976D260523
 for <alsa-devel@alsa-project.org>; Sun,  4 Oct 2015 13:54:48 +0200 (CEST)
In-Reply-To: <20151003125402.7581963b@kant>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: alsa-devel@alsa-project.org, kbuild test robot <lkp@intel.com>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, kbuild-all@01.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

SGkgU3RlZmFuLAoKT24gT2N0IDAzIDIwMTUgMTk6NTQsIFN0ZWZhbiBSaWNodGVyIHdyb3RlOgo+
IE9uIE9jdCAwMyBUYWthc2hpIFNha2Ftb3RvIHdyb3RlOgo+PiBPbiAyMDE15bm0MTDmnIgwM+aX
pSAxODoxNCwgQ2xlbWVucyBMYWRpc2NoIHdyb3RlOgo+Pj4gTW9zdCBkYXRhIGluIHRoZSBhY3R1
YWwgY29uZmlndXJhdGlvbiBST00gaXMgb3JnYW5pemVkIGFzIGJpZy1lbmRpYW4gMzItCj4+PiBi
aXQgdmFsdWVzLCBzbyB0aGUgRmlyZVdpcmUgY29yZSBjb252ZXJ0cyBfYWxsXyB3b3JkcyBmcm9t
IGJpZyBlbmRpYW4gdG8KPj4+IENQVSBlbmRpYW4uICBUaGUgd29yZHMgdGhhdCBhcmUgbm90IGFj
dHVhbGx5IDMyLWJpdCB2YWx1ZXMgYnV0IHN0cmluZ3MKPj4+IGhhdmUgdG8gYmUgY29udmVydGVk
IGJhY2s7IHRoZSBjb3JyZWN0IGZ1bmN0aW9uIGZvciB0aGlzIGlzIGNwdV90b19iZTMyKCkuCj4+
Cj4+IFllcy4gQW5kIEkgZm9yZ290IGEgcGFpciBvZiBjcHVfdG9fYmUzMi9iZTMyX3RvX2NwdSBp
cyBzeW1tZXRyaWMgZWFjaCBvdGhlciEKPj4gKEknbSByZWFsbHkgYSBzdHVwaWQgZ3V5LCBzaWdo
Li4uKQo+IAo+IE5haCwgaXQncyBlYXN5IHRvIG1pc3MgdGhhdCBzdHJ1Y3QgZndfZGV2aWNlLmNv
bmZpZ19yb20gaXN0IG5vdCBpZGVudGljYWwKPiB3aXRoIHRoZSBvbi10aGUtd2lyZSBmb3JtYXQg
KG9uIGxpdHRsZSBlbmRpYW4gaG9zdHMsIHRoYXQgaXMpLiAgVGhpcyBoYXMKPiBpcnJpdGF0ZWQg
b3RoZXJzIGJlZm9yZS4gIEkgdGhpbmsgdGhpcyBDUFUtZW5kaWFuIFJPTSBidWZmZXIgY2F0ZXJz
IHRvCj4gc2ltcGxlciBST00gcGFyc2luZyBjb2RlIGluIHRoZSBvdmVyYWxsIHBpY3R1cmUuICBU
ZXh0IGxlYWYgcGFyc2luZyBzZWVtcwo+IHRvIGJlIHRoZSBvbmx5IGV4Y2VwdGlvbiB3aGVyZSBh
IGJpZy1lbmRpYW4gYnVmZmVyIHdvdWxkIGJlIHByZWZlcmFibGUsCj4gYnV0IGJlZm9yZSB5b3Vy
IFRBU0NBTSBkcml2ZXIgYWxsIG9mIHRoZSB0ZXh0IGxlYWYgcGFyc2luZyB3YXMKPiBjb25jZW50
cmF0ZWQgaW4gY29yZS1kZXZpY2UuYzo6dGV4dHVhbF9sZWFmX3RvX3N0cmluZygpLgoKWWVwLiBJ
IGRpZG4ndCBjb25zaWRlciBhYm91dCB0aGUgcGFpciBvZiBtYWNyb3MgYXJlIHByZXByb2Nlc3Nl
ZAphY2NvcmRpbmcgdG8gQ1BVLWVuZGlhbm5lc3MuCkFueXdheSB0aGlzIGRyaXZlciByZXF1aXJl
IGVub3VnaCBpbXBsZW1lbnRhdGlvbiB0byBwYXJzZSB0aGUgc3RyaW5nLgoKClRoYW5rcwoKVGFr
YXNoaSBTYWthbW90bwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcK
aHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2
ZWwK
