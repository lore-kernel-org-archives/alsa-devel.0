From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/3] ASoC: rt5677: Remove never used
	variables
Date: Tue, 18 Jul 2017 20:34:19 +0300
Message-ID: <20170718173419.65980-4-andriy.shevchenko@linux.intel.com>
References: <20170718173419.65980-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 158722671F9
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 19:34:25 +0200 (CEST)
In-Reply-To: <20170718173419.65980-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, John Keeping <john@metanate.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

VGhlcmUgYXJlIHR3byB2YXJpYWJsZXMgdGhhdCBoYXZlIG5ldmVyIGJlZW4gdXNlZC4KCnNvdW5k
L3NvYy9jb2RlY3MvcnQ1Njc3LmM6Nzg1OjM1OiB3YXJuaW5nOiDigJhpbl92b2xfdGx24oCZIGRl
ZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dCnN0YXRpYyBjb25z
dCBERUNMQVJFX1RMVl9EQl9TQ0FMRShpbl92b2xfdGx2LCAtMzQ1MCwgMTUwLCAwKTsKCnNvdW5k
L3NvYy9jb2RlY3MvcnQ1Njc3LmM6NzgzOjM1OiB3YXJuaW5nOiDigJhvdXRfdm9sX3RsduKAmSBk
ZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQpzdGF0aWMgY29u
c3QgREVDTEFSRV9UTFZfREJfU0NBTEUob3V0X3ZvbF90bHYsIC00NjUwLCAxNTAsIDApOwoKU2lt
cGxlIHJlbW92ZSB0aGVtLgoKU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXku
c2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+Ci0tLQogc291bmQvc29jL2NvZGVjcy9ydDU2Nzcu
YyB8IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Nv
dW5kL3NvYy9jb2RlY3MvcnQ1Njc3LmMgYi9zb3VuZC9zb2MvY29kZWNzL3J0NTY3Ny5jCmluZGV4
IGEzY2NlNTc3MzljMy4uOWU5ZGUwZTI3NGVhIDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvY29kZWNz
L3J0NTY3Ny5jCisrKyBiL3NvdW5kL3NvYy9jb2RlY3MvcnQ1Njc3LmMKQEAgLTc4MCw5ICs3ODAs
NyBAQCBzdGF0aWMgaW50IHJ0NTY3N19zZXRfZHNwX3ZhZChzdHJ1Y3Qgc25kX3NvY19jb2RlYyAq
Y29kZWMsIGJvb2wgb24pCiAJcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyBjb25zdCBERUNMQVJFX1RM
Vl9EQl9TQ0FMRShvdXRfdm9sX3RsdiwgLTQ2NTAsIDE1MCwgMCk7CiBzdGF0aWMgY29uc3QgREVD
TEFSRV9UTFZfREJfU0NBTEUoZGFjX3ZvbF90bHYsIC02NTI1LCA3NSwgMCk7Ci1zdGF0aWMgY29u
c3QgREVDTEFSRV9UTFZfREJfU0NBTEUoaW5fdm9sX3RsdiwgLTM0NTAsIDE1MCwgMCk7CiBzdGF0
aWMgY29uc3QgREVDTEFSRV9UTFZfREJfU0NBTEUoYWRjX3ZvbF90bHYsIC0xNzI1LCA3NSwgMCk7
CiBzdGF0aWMgY29uc3QgREVDTEFSRV9UTFZfREJfU0NBTEUoYWRjX2JzdF90bHYsIDAsIDEyMDAs
IDApOwogc3RhdGljIGNvbnN0IERFQ0xBUkVfVExWX0RCX1NDQUxFKHN0X3ZvbF90bHYsIC00NjUw
LCAxNTAsIDApOwotLSAKMi4xMS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJv
amVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2Fsc2EtZGV2ZWwK
