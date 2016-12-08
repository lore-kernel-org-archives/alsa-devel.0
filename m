From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 02/14] ASoC: Intel: sst: remove unused
	'msg_high'
Date: Thu,  8 Dec 2016 23:01:25 +0530
Message-ID: <1481218297-17568-3-git-send-email-vinod.koul@intel.com>
References: <1481218297-17568-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 820EB2674ED
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 18:32:20 +0100 (CET)
In-Reply-To: <1481218297-17568-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

SW4gcHJvY2Vzc19md19hc3luY19tc2coKSwgYSB2YXJpYWJsZSAnbXNnX2hpZ2gnIGlzIGluaXRp
YWxpemVkIGJ1dApub3QgdXNlZC4gU28gcmVtb3ZlIGl0LgoKc291bmQvc29jL2ludGVsL2F0b20v
c3N0L3NzdF9pcGMuYzogSW4gZnVuY3Rpb24g4oCYcHJvY2Vzc19md19hc3luY19tc2figJk6CnNv
dW5kL3NvYy9pbnRlbC9hdG9tL3NzdC9zc3RfaXBjLmM6MjYzOjI0OiB3YXJuaW5nOiB2YXJpYWJs
ZSDigJhtc2dfaGlnaOKAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlh
YmxlXQogIHVuaW9uIGlwY19oZWFkZXJfaGlnaCBtc2dfaGlnaDsKClNpZ25lZC1vZmYtYnk6IFZp
bm9kIEtvdWwgPHZpbm9kLmtvdWxAaW50ZWwuY29tPgotLS0KIHNvdW5kL3NvYy9pbnRlbC9hdG9t
L3NzdC9zc3RfaXBjLmMgfCAyIC0tCiAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9zb3VuZC9zb2MvaW50ZWwvYXRvbS9zc3Qvc3N0X2lwYy5jIGIvc291bmQvc29j
L2ludGVsL2F0b20vc3N0L3NzdF9pcGMuYwppbmRleCAzNzRiYjYxYzU5NmQuLjE0YzJkOWQxODE4
MCAxMDA2NDQKLS0tIGEvc291bmQvc29jL2ludGVsL2F0b20vc3N0L3NzdF9pcGMuYworKysgYi9z
b3VuZC9zb2MvaW50ZWwvYXRvbS9zc3Qvc3N0X2lwYy5jCkBAIC0yNjAsMTAgKzI2MCw4IEBAIHN0
YXRpYyB2b2lkIHByb2Nlc3NfZndfYXN5bmNfbXNnKHN0cnVjdCBpbnRlbF9zc3RfZHJ2ICpzc3Rf
ZHJ2X2N0eCwKIAl1MzIgZGF0YV9zaXplLCBpOwogCXZvaWQgKmRhdGFfb2Zmc2V0OwogCXN0cnVj
dCBzdHJlYW1faW5mbyAqc3RyZWFtOwotCXVuaW9uIGlwY19oZWFkZXJfaGlnaCBtc2dfaGlnaDsK
IAl1MzIgbXNnX2xvdywgcGlwZV9pZDsKIAotCW1zZ19oaWdoID0gbXNnLT5tcmZsZF9oZWFkZXIu
cC5oZWFkZXJfaGlnaDsKIAltc2dfbG93ID0gbXNnLT5tcmZsZF9oZWFkZXIucC5oZWFkZXJfbG93
X3BheWxvYWQ7CiAJbXNnX2lkID0gKChzdHJ1Y3QgaXBjX2RzcF9oZHIgKiltc2ctPm1haWxib3hf
ZGF0YSktPmNtZF9pZDsKIAlkYXRhX29mZnNldCA9IChtc2ctPm1haWxib3hfZGF0YSArIHNpemVv
ZihzdHJ1Y3QgaXBjX2RzcF9oZHIpKTsKLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
