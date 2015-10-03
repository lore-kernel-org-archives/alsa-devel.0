From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 1/7] ALSA: firewire-tascam: add skeleton
 for TASCAM FireWire series
Date: Sat, 3 Oct 2015 12:54:02 +0200
Message-ID: <20151003125402.7581963b@kant>
References: <1443704537-3345-2-git-send-email-o-takashi@sakamocchi.jp>
 <201510012147.nfdOjouA%fengguang.wu@intel.com>
 <s5hd1wxdyr7.wl-tiwai@suse.de> <560ED14A.2060404@ladisch.de>
 <560F3EB0.7020508@sakamocchi.jp> <560F9C6E.70800@ladisch.de>
 <560FA68E.8050501@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id AF4C62615FC
 for <alsa-devel@alsa-project.org>; Sat,  3 Oct 2015 12:54:08 +0200 (CEST)
In-Reply-To: <560FA68E.8050501@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, kbuild test robot <lkp@intel.com>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, kbuild-all@01.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

T24gT2N0IDAzIFRha2FzaGkgU2FrYW1vdG8gd3JvdGU6Cj4gT24gMjAxNeW5tDEw5pyIMDPml6Ug
MTg6MTQsIENsZW1lbnMgTGFkaXNjaCB3cm90ZToKPiA+IE1vc3QgZGF0YSBpbiB0aGUgYWN0dWFs
IGNvbmZpZ3VyYXRpb24gUk9NIGlzIG9yZ2FuaXplZCBhcyBiaWctZW5kaWFuIDMyLQo+ID4gYml0
IHZhbHVlcywgc28gdGhlIEZpcmVXaXJlIGNvcmUgY29udmVydHMgX2FsbF8gd29yZHMgZnJvbSBi
aWcgZW5kaWFuIHRvCj4gPiBDUFUgZW5kaWFuLiAgVGhlIHdvcmRzIHRoYXQgYXJlIG5vdCBhY3R1
YWxseSAzMi1iaXQgdmFsdWVzIGJ1dCBzdHJpbmdzCj4gPiBoYXZlIHRvIGJlIGNvbnZlcnRlZCBi
YWNrOyB0aGUgY29ycmVjdCBmdW5jdGlvbiBmb3IgdGhpcyBpcyBjcHVfdG9fYmUzMigpLgo+IAo+
IFllcy4gQW5kIEkgZm9yZ290IGEgcGFpciBvZiBjcHVfdG9fYmUzMi9iZTMyX3RvX2NwdSBpcyBz
eW1tZXRyaWMgZWFjaCBvdGhlciEKPiAoSSdtIHJlYWxseSBhIHN0dXBpZCBndXksIHNpZ2guLi4p
CgpOYWgsIGl0J3MgZWFzeSB0byBtaXNzIHRoYXQgc3RydWN0IGZ3X2RldmljZS5jb25maWdfcm9t
IGlzdCBub3QgaWRlbnRpY2FsCndpdGggdGhlIG9uLXRoZS13aXJlIGZvcm1hdCAob24gbGl0dGxl
IGVuZGlhbiBob3N0cywgdGhhdCBpcykuICBUaGlzIGhhcwppcnJpdGF0ZWQgb3RoZXJzIGJlZm9y
ZS4gIEkgdGhpbmsgdGhpcyBDUFUtZW5kaWFuIFJPTSBidWZmZXIgY2F0ZXJzIHRvCnNpbXBsZXIg
Uk9NIHBhcnNpbmcgY29kZSBpbiB0aGUgb3ZlcmFsbCBwaWN0dXJlLiAgVGV4dCBsZWFmIHBhcnNp
bmcgc2VlbXMKdG8gYmUgdGhlIG9ubHkgZXhjZXB0aW9uIHdoZXJlIGEgYmlnLWVuZGlhbiBidWZm
ZXIgd291bGQgYmUgcHJlZmVyYWJsZSwKYnV0IGJlZm9yZSB5b3VyIFRBU0NBTSBkcml2ZXIgYWxs
IG9mIHRoZSB0ZXh0IGxlYWYgcGFyc2luZyB3YXMKY29uY2VudHJhdGVkIGluIGNvcmUtZGV2aWNl
LmM6OnRleHR1YWxfbGVhZl90b19zdHJpbmcoKS4KLS0gClN0ZWZhbiBSaWNodGVyCi09PT09PS09
PT09PSA9LT0tIC0tLT09Cmh0dHA6Ly9hcmNncmFwaC5kZS9zci8KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxz
YS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
