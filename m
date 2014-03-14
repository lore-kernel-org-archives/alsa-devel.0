From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 16/39] firewire-lib: Add some AV/C general
	commands
Date: Fri, 14 Mar 2014 23:10:56 +0900
Message-ID: <53230DF0.6090105@sakamocchi.jp>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-17-git-send-email-o-takashi@sakamocchi.jp>
 <531CDE06.40604@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id C41D3265317
 for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2014 15:11:01 +0100 (CET)
In-Reply-To: <531CDE06.40604@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Q2xlbWVucywKCigyMDE05bm0MDPmnIgxMOaXpSAwNjozMiksIENsZW1lbnMgTGFkaXNjaCB3cm90
ZToKPiBBbGwgdGhlc2UgZnVuY3Rpb25zIHJldHVybiBlcnJvcnMgd2l0aCB0d28gZGlmZmVyZW50
IG1lY2hhbmlzbXMsIHRoZSBBVi9DCj4gcmVzcG9uc2UgY29kZSBvciBhIG5lZ2F0aXZlIExpbnV4
IGVycm9yIGNvZGUuICBUaGlzIGZvcmNlcyB0aGUgY2FsbGVyIHRvCj4gYWRkIGEgc2Vjb25kIGVy
cm9yIGNoZWNrIHRoYXQgZHVwbGljYXRlcyB0aGUgb25lIGluc2lkZSB0aGUgZnVuY3Rpb246CgpJ
IHJlYWxpemUgYSBuZWVkIHRvIHNpbXBsaWZ5IHRoZXNlIHJldHVybiB2YWx1ZSBhbmQgZGVjaWRl
IHRvIHdvcmsgZm9yIApkZWZlcnJlZCB0cmFuc2FjdGlvbiBkZWZpbmVkIGluICdBVi9DIERpZ2l0
YWwgSW50ZXJmYWNlIENvbW1hbmQgU2V0IApHZW5lcmFsIFNwZWNpZmljYXRpb24nLiBJZiBmaXJl
d2lyZS1saWIgY2FuIGhhbmRsZSBkZWZlcnJlZCB0cmFuc2FjdGlvbiwgCml0J3MgT0sgdGhhdCBB
Vi9DIGZ1bmN0aW9ucyBpbiBmaXJld2lyZS1saWIgcmV0dXJucyBMaW51eCBlcnJvciBjb2RlcyAK
aW5zdGVhZCBvZiBjb21iaW5hdGlvbiBlcnJvciBjb2RlcyBhbmQgcmVzcG9uc2UgY29kZXMuCgpX
ZWxsLCBjYW4gSSByZXF1ZXN0IHlvdXIgY29tbWVudHMgYWJvdXQgY29ycmVzcG9uZGluZyBiZXR3
ZWVuIHJlc3BvbnNlIApjb2RlcyBhbmQgTGludXggZXJyb3IgY29kZXM/CgpDdXJyZW50IG15IGlk
ZWEgaXMgYmVsb3cuCgpSZXR1cm4gY29kZXMgb2YgQ09OVFJPTCBjb21tYW5kOgppZiAoZXJyICE9
IDgpIC8qIGxlbmd0aCBvZiByZXNwb25zZSBpcyBvdXQgb2Ygc3BlY2lmaWNhdGlvbiAqLwoJZXJy
ID0gLUVJTzsKZWxzZSBpZiAoYnVmWzBdID09IDB4MDgpIC8qIE5PVCBJTVBMRU1FTlRFRCAqLwoJ
ZXJyID0gLUVOT1NZUzsKZWxzZSBpZiAoYnVmWzBdID09IDB4MGEpIC8qIFJFSkVDVEVEICovCgll
cnIgPSAtRUlOVkFMOwoKUmV0dXJuIGNvZGVzIG9mIFNUQVRVUyBjb21tYW5kOgppZiAoZXJyICE9
IDgpICAvKiBsZW5ndGggb2YgcmVzcG9uc2UgaXMgbm90IG91ciBleHBlY3RhdGlvbiAqLwoJZXJy
ID0gLUVJTzsKZWxzZSBpZiAoYnVmWzBdID09IDB4MDgpIC8qIE5PVCBJTVBMRU1FTlRFRCAqLwoJ
ZXJyID0gLUVOT1NZUzsKZWxzZSBpZiAoYnVmWzBdID09IDB4MGEpIC8qIFJFSkVDVEVEICovCgll
cnIgPSAtRUlOVkFMOwplbHNlIGlmIChidWZbMF0gPT0gMHgwYikgLyogSU4gVFJBTlNJVElPTiAq
LwoJZXJyID0gLUVBR0FJTjsKCkFyZSB0aGVzZSBiZXR0ZXI/CgoKUmVnYXJkcwoKVGFrYXNoaSBT
YWthbW90bwpvLXRha2FzaGlAc2FrYW1vY2NoaS5qcAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZl
bEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbHNhLWRldmVsCg==
