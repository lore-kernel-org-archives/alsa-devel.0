From: Eric Laurent <elaurent@google.com>
Subject: compress offload patch
Date: Thu, 3 Mar 2016 08:09:52 -0800
Message-ID: <CAL-7xP8m+p2XZHwM1y+KrH+FZUiux33dy6Y6LVEuAEiW6g5mDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113ead288a0a6c052d273a89
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 3109526149E
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 17:09:53 +0100 (CET)
Received: by mail-wm0-f52.google.com with SMTP id p65so41725414wmp.1
 for <alsa-devel@alsa-project.org>; Thu, 03 Mar 2016 08:09:53 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--001a113ead288a0a6c052d273a89
Content-Type: text/plain; charset=UTF-8

Takashi, Vinod,

Can you help with merging the attached patch for compress offload core
upstream?

Thanks.

Eric.

--001a113ead288a0a6c052d273a89
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-compress-allow-writes-in-SNDRV_PCM_STATE_PREPAR.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-compress-allow-writes-in-SNDRV_PCM_STATE_PREPAR.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ilcgvysz0

RnJvbSAxMTY2YWRmNGI2M2VhM2VlMWQxMTljNDZkOTdmYTY1Yzc2YTA4NDQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFcmljIExhdXJlbnQgPGVsYXVyZW50QGdvb2dsZS5jb20+CkRh
dGU6IFdlZCwgMiBNYXIgMjAxNiAwOTo1NDo1NyAtMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6
IGNvbXByZXNzOiBhbGxvdyB3cml0ZXMgaW4gU05EUlZfUENNX1NUQVRFX1BSRVBBUkVECiBzdGF0
ZQoKQWxsb3cgd3JpdGVzIGluIFNORFJWX1BDTV9TVEFURV9QUkVQQVJFRCBzdGF0ZSBzbyB0aGF0
IG1vcmUKdGhhbiBvbmUgYnVmZmVyIGZyYWdtZW50IGNhbiBiZSB3cml0dGVuIGZyb20gdXNlciBz
cGFjZQpiZWZvcmUgY2FsbGluZyBTTkRSVl9DT01QUkVTU19TVEFSVC4KClNpZ25lZC1vZmYtYnk6
IEVyaWMgTGF1cmVudCA8ZWxhdXJlbnRAZ29vZ2xlLmNvbT4KLS0tCiBzb3VuZC9jb3JlL2NvbXBy
ZXNzX29mZmxvYWQuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZm
IC0tZ2l0IGEvc291bmQvY29yZS9jb21wcmVzc19vZmZsb2FkLmMgYi9zb3VuZC9jb3JlL2NvbXBy
ZXNzX29mZmxvYWQuYwppbmRleCAxYjc3ODUyLi43YzU3ZjM3IDEwMDY0NAotLS0gYS9zb3VuZC9j
b3JlL2NvbXByZXNzX29mZmxvYWQuYworKysgYi9zb3VuZC9jb3JlL2NvbXByZXNzX29mZmxvYWQu
YwpAQCAtMjgxLDYgKzI4MSw3IEBAIHN0YXRpYyBzc2l6ZV90IHNuZF9jb21wcl93cml0ZShzdHJ1
Y3QgZmlsZSAqZiwgY29uc3QgY2hhciBfX3VzZXIgKmJ1ZiwKIAltdXRleF9sb2NrKCZzdHJlYW0t
PmRldmljZS0+bG9jayk7CiAJLyogd3JpdGUgaXMgYWxsb3dlZCB3aGVuIHN0cmVhbSBpcyBydW5u
aW5nIG9yIGhhcyBiZWVuIHN0ZXVwICovCiAJaWYgKHN0cmVhbS0+cnVudGltZS0+c3RhdGUgIT0g
U05EUlZfUENNX1NUQVRFX1NFVFVQICYmCisJICAgIHN0cmVhbS0+cnVudGltZS0+c3RhdGUgIT0g
U05EUlZfUENNX1NUQVRFX1BSRVBBUkVEICYmCiAJCQlzdHJlYW0tPnJ1bnRpbWUtPnN0YXRlICE9
IFNORFJWX1BDTV9TVEFURV9SVU5OSU5HKSB7CiAJCW11dGV4X3VubG9jaygmc3RyZWFtLT5kZXZp
Y2UtPmxvY2spOwogCQlyZXR1cm4gLUVCQURGRDsKLS0gCjIuNy4wLnJjMy4yMDcuZzBhYzUzNDQK
Cg==
--001a113ead288a0a6c052d273a89
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--001a113ead288a0a6c052d273a89--
