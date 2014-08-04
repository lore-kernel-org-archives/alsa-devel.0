From: =?UTF-8?B?QnVyYWsgTUVUxLBO?= <metinburak@gmail.com>
Subject: Alsa simultaneous use of usb-sound card - BW problem
Date: Mon, 4 Aug 2014 17:19:39 +0300
Message-ID: <CADG_eVr=n8EgFpyST2=g9xUDThr+JeKFMKMoWyO=epX0Wyo4QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f182.google.com (mail-vc0-f182.google.com
 [209.85.220.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 85B3526084B
 for <alsa-devel@alsa-project.org>; Mon,  4 Aug 2014 16:19:49 +0200 (CEST)
Received: by mail-vc0-f182.google.com with SMTP id hy4so11361301vcb.13
 for <alsa-devel@alsa-project.org>; Mon, 04 Aug 2014 07:19:40 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SGksCgpJIGhhdmUgMiBDTTY1NzEgdXNiIHNvdW5kIGNhcmRzLgoKSW4gVWJ1bnR1LCBpIHdhbnQg
dG8gdXNlIHRoZXNlIDIgY2FyZGRzIHNpbXVsdGFuZW91c2x5LiBJIG9wZW4gMiB0ZXJtaW5hbHMs
CmFuZCBhcmVjb3JkIC1EIHBsdWdodzoxLDAgfCBhcGxheSAtRCBwbHVnaHc6MSwwIGluIG9uZSB0
ZXJtaW5hbCwgaXQgd29ya3MKd2VsbC4gYnV0IHdoZW4gaSB0eXBlIGFyZWNvcmQgLUQgcGx1Z2h3
OjIsMCB8IGFwbGF5IC1EIHBsdWdodzoyLDAgaW4KYW5vdGhlciB0ZXJtaW5hbCwgaW4gc2Vjb25k
IHRlcm1pbmFsLCBpdCBzYXlzCgpSZWNvcmRpbmcgV0FWRSAnc3RkaW4nIDogVW5zaWduZWQgOCBi
aXQsIFJhdGUgODAwMCBIeiwgTW9ubwphcmVjb3JkOiB4cnVuOjE1NTI6IFBsYXlpbmcgV0FWRSAn
c3RkaW4nIDogcmVhZC93cml0ZSBlcnJvciwgc3RhdGUgPQpQUkVQQVJFRFVuc2lnbmVkIDggYml0
LApSYXRlIDgwMDAgSHosIE1vbm8KYXBsYXk6IHNldF9wYXJhbXM6MTI5NzogVW5hYmxlIHRvIGlu
c3RhbGwgaHcgcGFyYW1zOgpBQ0NFU1M6ICBSV19JTlRFUkxFQVZFRApGT1JNQVQ6ICBVOApTVUJG
T1JNQVQ6ICBTVEQKU0FNUExFX0JJVFM6IDgKRlJBTUVfQklUUzogOApDSEFOTkVMUzogMQpSQVRF
OiA4MDAwClBFUklPRF9USU1FOiAxMjUwMDAKUEVSSU9EX1NJWkU6IDEwMDAKUEVSSU9EX0JZVEVT
OiAxMDAwClBFUklPRFM6IDQKQlVGRkVSX1RJTUU6IDUwMDAwMApCVUZGRVJfU0laRTogNDAwMApC
VUZGRVJfQllURVM6IDQwMDAKVElDS19USU1FOiAwCgpXaGVuIMSxIGRtZXNnLCBpdCBzYXlzOgoK
WyA1NDE4LjkxMzE2MF0gcmV0aXJlX3BsYXliYWNrX3VyYjogMTY3MyBjYWxsYmFja3Mgc3VwcHJl
c3NlZApbIDU0MTkuMjUzNDM2XSBjYW5ub3Qgc3VibWl0IHVyYiAwLCBlcnJvciAtMjg6IG5vdCBl
bm91Z2ggYmFuZHdpZHRoClsgNTQxOS4yNTQ4ODddIGNhbm5vdCBzdWJtaXQgdXJiIDAsIGVycm9y
IC0yODogbm90IGVub3VnaCBiYW5kd2lkdGgKCkkgdGhpbmsgaXQgaXMgYWJvdXQgdGhlIHVzYiBk
cml2ZXIgaW4gYWxzYSwgYW55IGlkZWFzPwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2Et
cHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2Fsc2EtZGV2ZWwK
