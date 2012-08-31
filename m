From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 1/3] ALSA: pcm - introduce device_buffer
Date: Fri, 31 Aug 2012 20:35:32 +0530
Message-ID: <1346425532.1895.103.camel@vkoul-udesk3>
References: <1346375684-4145-1-git-send-email-vinod.koul@linux.intel.com>
 <1346375684-4145-2-git-send-email-vinod.koul@linux.intel.com>
 <CAN8ccibyigPF3W-ntvK_OofNrgKc=QKGo8qxMR1=CD-MQ5rddg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 00F95265B9C
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2012 17:05:47 +0200 (CEST)
In-Reply-To: <CAN8ccibyigPF3W-ntvK_OofNrgKc=QKGo8qxMR1=CD-MQ5rddg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: tiwai@suse.de, vkoul@infradead.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

T24gRnJpLCAyMDEyLTA4LTMxIGF0IDEwOjA2ICswODAwLCBSYXltb25kIFlhdSB3cm90ZToKPiAK
PiAyMDEyLTgtMzEg5LiK5Y2IOTowOCDmlrwgIlZpbm9kIEtvdWwiIDx2aW5vZC5rb3VsQGxpbnV4
LmludGVsLmNvbT4g5a+r6YGT77yaCj4gPgo+ID4gSW4gbWFueSBtb2Rlcm4gU29DcyB0aGUgYXVk
aW8gRFNQIGNhbiBidWZmZXIgdGhlIFBDTSByaW5nIGJ1ZmZlcgo+IGRhdGEsIHR5cGljYWxseQo+
ID4gaW4gU1JBTXMgb3IgYW55IG90aGVyIG1lbW9yeSBhdmFpbGFibGUuCj4gPiBUb2RheSB3ZSBo
YXZlIG5vIG1lYW5zIHRvIHJlcHJlc2VudCB0aGlzIGJ1ZmZlcmluZyBhbmQgQUxTQSBpbiBzb21l
Cj4gY2FzZXMgd2hlbgo+ID4gZGV2aWNlIHN0aWxsIGhhcyB0byByZW5kZXIgdGhpcyBidWZmZXIg
YnV0IGFwcF9wdHIgaXMgZXF1YWwgdG8KPiBod19wdHIgYWxzYQo+ID4gd3JvbmdseSBkZXRlY3Rz
IGFuIG92ZXJydW4KPiA+Cj4gPiBUaGlzIHBhdGNoIHRyaWVzIHRvIGFkZCBhIG5ldyBmaWVsZCAi
ZGV2aWNlX2J1ZmZlciIgdG8gcmVwcmVzZW50Cj4gYnVmZmVyaW5nIGRvbmUgaW4KPiA+IERTUHMu
IFRoaXMgdmFsdWUgaXMgYWxzbyB1c2VkIGZvciB0aGUgeHJ1biBjYWxjdWxhdGlvbnMgaW4gQUxT
QQo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFZpbm9kIEtvdWwgPHZpbm9kLmtvdWxAbGludXguaW50
ZWwuY29tPgo+ID4gLS0tCj4gCj4gCj4gYXJlIHRoZXNlIGJ1ZmZlciBzaW1pbGFyIHRvIGhkYSAn
cyBGSUZPID8KTm8gRklGTyBzaG91bGQgb25seSBiZSByZXByZXNlbnRlZCBieSAiZGVsYXkiIG5v
dCBieSB0aGlzIG9uZS4KPiAKPiBjYW4gdGhlIGFsc2EgYXBwbGljYXRpb24gdXNlIHNuZF9wY21f
cmV3aW5kIHRvIHJld2luZCB0aGUgYXBwX3B0ciA/CldlbGwgeWVzLCBidXQgaWYgZGV2aWNlIGlz
IGRlZXAgYnVmZmVyaW5nIHRoYXQgaXQgY2FuIGNhdXNlIGlzc3Vlcy4gV2UKZGlzY3Vzc2VkIHRo
aXMgYW5kIHBlcmhhcHMgaXQgd291bGQgYmUgZ29vZCB0byB0ZWxsIGRldmljZSBhYm91dCBhcHAK
cG9pbnRlciBhbmQgYWxzbyByZXdpbmQvZndkLCBzbyB0aGF0IGl0IGNhbiBjb250cm9sIHRoaXMg
YnVmZmVyaW5nCgotLSAKflZpbm9kCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJv
amVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2Fsc2EtZGV2ZWwK
