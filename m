From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: update stream only on stream IPC
	msgs
Date: Fri,  1 Aug 2014 23:10:43 +0800
Message-ID: <1406905843-31223-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id EE8A0265529
 for <alsa-devel@alsa-project.org>; Fri,  1 Aug 2014 17:09:46 +0200 (CEST)
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
Cc: mengdong.lin@intel.com, broonie@kernel.org, pawel.piskorski@intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

RnJvbTogUGF3ZcWCIFBpc2tvcnNraSA8cGF3ZWwucGlza29yc2tpQGludGVsLmNvbT4KCk9ubHkg
dXBkYXRlIHRoZSBzdHJlYW0gd2hlbiB0aGUgSVBDIG1lc3NhZ2UgdHlwZSBtYXRjaGVzIHN0cmVh
bSB0eXBlLgoKU2lnbmVkLW9mZi1ieTogUGF3ZcWCIFBpc2tvcnNraSA8cGF3ZWwucGlza29yc2tp
QGludGVsLmNvbT4KU2lnbmVkLW9mZi1ieTogTGlhbSBHaXJkd29vZCA8bGlhbS5yLmdpcmR3b29k
QGxpbnV4LmludGVsLmNvbT4KU2lnbmVkLW9mZi1ieTogSmllIFlhbmcgPHlhbmcuamllQGludGVs
LmNvbT4KLS0tCiBzb3VuZC9zb2MvaW50ZWwvc3N0LWhhc3dlbGwtaXBjLmMgfCAzICsrLQogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L3NvdW5kL3NvYy9pbnRlbC9zc3QtaGFzd2VsbC1pcGMuYyBiL3NvdW5kL3NvYy9pbnRlbC9zc3Qt
aGFzd2VsbC1pcGMuYwppbmRleCAwZmVjNjg2Li5kYTI3ZjkwIDEwMDY0NAotLS0gYS9zb3VuZC9z
b2MvaW50ZWwvc3N0LWhhc3dlbGwtaXBjLmMKKysrIGIvc291bmQvc29jL2ludGVsL3NzdC1oYXN3
ZWxsLWlwYy5jCkBAIC03ODAsNyArNzgwLDggQEAgc3RhdGljIGludCBoc3dfcHJvY2Vzc19yZXBs
eShzdHJ1Y3Qgc3N0X2hzdyAqaHN3LCB1MzIgaGVhZGVyKQogCX0KIAogCS8qIHVwZGF0ZSBhbnkg
c3RyZWFtIHN0YXRlcyAqLwotCWhzd19zdHJlYW1fdXBkYXRlKGhzdywgbXNnKTsKKwlpZiAobXNn
X2dldF9nbG9iYWxfdHlwZShoZWFkZXIpID09IElQQ19HTEJfU1RSRUFNX01FU1NBR0UpCisJCWhz
d19zdHJlYW1fdXBkYXRlKGhzdywgbXNnKTsKIAogCS8qIHdha2UgdXAgYW5kIHJldHVybiB0aGUg
ZXJyb3IgaWYgd2UgaGF2ZSB3YWl0ZXJzIG9uIHRoaXMgbWVzc2FnZSA/ICovCiAJbGlzdF9kZWwo
Jm1zZy0+bGlzdCk7Ci0tIAoxLjguMy4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2Et
cHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2Fsc2EtZGV2ZWwK
