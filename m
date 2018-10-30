From: =?UTF-8?Q?Ren=c3=a9_Santing?= <rene.santing@wearespindle.com>
Subject: Bug report - Dell-WD15-Dock not working caused by ucm
 profile in alsa-lib 1.1.7
Date: Tue, 30 Oct 2018 10:10:07 +0100
Message-ID: <16a7a277-0677-9ca6-6765-1e109d6dc3be@wearespindle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by alsa0.perex.cz (Postfix) with ESMTP id AC3652675BA
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2018 10:10:09 +0100 (CET)
Received: by mail-ed1-f48.google.com with SMTP id t10-v6so9765153eds.12
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2018 02:10:09 -0700 (PDT)
Received: from ?IPv6:2a00:8080:298:0:9f49:c389:673a:d5ee?
 ([2a00:8080:298:0:9f49:c389:673a:d5ee])
 by smtp.gmail.com with ESMTPSA id f16-v6sm6386940edt.93.2018.10.30.02.10.07
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Oct 2018 02:10:08 -0700 (PDT)
Content-Language: en-US-large
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SGVsbG8gQWxzYSBkZXZlbG9wZXJzLAoKSSB3b3VsZCBsaWtlIHRvIGZpbGUgYSBidWcgcmVwb3J0
IGFib3V0IHRoZSBEZWxsLVdEMTUtRG9jay4gVGhpcyBkb2NrCnN0b3BwZWQgd29ya2luZyBmb3Ig
bWUgb24gYXJjaGxpbnV4L2tkZS4gVGhlIGRldmljZSB3YXMgbm90IHBpY2tlZCB1cCBhdAphbGwg
YnkgcHVsc2UgYXVkaW8gYWZ0ZXIgc29tZSB1cGRhdGVzIEkgaW5zdGFsbGVkIGxhc3Qgd2Vlay4K
QnkgdHJpYWwgYW5kIGVycm9yIEkgZm91bmQgb3V0IGl0IHdhcyBjYXVzZWQgYnkgdGhlIHVjbSBw
cm9maWxlIHRoYXQgd2FzCmFkZGVkIGluIGFsc2EtbGliIDEuMS43LgpSdW5uaW5nIHRoZSBmb2xs
b3dpbmcgcmVzdG9yZWQgZnVuY3Rpb25hbGl0eS4KCsKgc3VkbyBtdiAvdXNyL3NoYXJlL2Fsc2Ev
dWNtL0RlbGwtV0QxNS1Eb2NrL0RlbGwtV0QxNS1Eb2NrLmNvbmYKL3Vzci9zaGFyZS9hbHNhL3Vj
bS9EZWxsLVdEMTUtRG9jay9EZWxsLVdEMTUtRG9jay5iYWsKwqBwdWxzZWF1ZGlvIC1rCgpJIHVw
bG9hZGVkIDMgYWxzYS1pbmZvLnNoIHByb2ZpbGVzLgoKMS4xLjYKaHR0cDovL3d3dy5hbHNhLXBy
b2plY3Qub3JnL2RiLz9mPWE5YTRjNTNkMWU0MTdjM2QyZWYzMDRmZTA3Nzg1ODFjMzViN2E5NWUK
KHdvcmtpbmcpCjEuMS43Cmh0dHA6Ly93d3cuYWxzYS1wcm9qZWN0Lm9yZy9kYi8/Zj1iYjQ3NGE2
ODc2OTJlMjVmNWU1NGM0NzVmMTZmN2NlNGVmMjEwZjdhCihub3Qgd29ya2luZykKMS4xLjcKaHR0
cDovL3d3dy5hbHNhLXByb2plY3Qub3JnL2RiLz9mPTU4NmRkMDU5YWFhMDhlODM5ZWI5ZGY1Zjdi
NDk5OTBhNWY0YWQxYTUKKHdvcmtpbmcgYnV0IG1vdmVkIHRoZSB3ZDE1IHVjbSBwcm9maWxlKQoK
aHR0cHM6Ly9hbHNhLXByb2plY3Qub3JnL21haW4vaW5kZXgucGhwL0J1Z19UcmFja2luZyBwb2lu
dGVkIG1lIHRvIHRoaXMKbWFpbGluZyBsaXN0IHRvIHN1Ym1pdCB0aGlzIHJlcG9ydC4gSWYgdGhp
cyBpcyB0aGUgd3JvbmcgcGxhY2Ugb3IgdGhlcmUKaXMgbW9yZSBpbmZvcm1hdGlvbiBuZWVkIGNv
dWxkIHlvdSBsZXQgbWUga25vdyBzbyBJIGNhbiBzZW5kIGl0IHRvIHRoZQpwcm9wZXIgY2hhbm5l
bHM/CgpCZXN0IHJlZ2FyZHMsCgpSZW7DqSBTYW50aW5nCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
