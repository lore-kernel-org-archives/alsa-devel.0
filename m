From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA au88x0: Fix IRQ fifo error and
 channels swap of 4 channels playback
Date: Sat, 7 Jan 2012 15:05:37 +0800
Message-ID: <CAN8cciYCHQNET-dVTLL29w4a+yn1xghfHNCb4Y38u8SqqwQCog@mail.gmail.com>
References: <CAN8cciYgJ9U0aS6np4nV+uws_0VEgmRXE2ocaLdc_7MgS6_7+w@mail.gmail.com>
	<CACRof1UDjOjw4XUU3q-WTJi4U6Osg=eHLoV6g0bz2yBC1FdjTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d0442720ade945704b5eacae0
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id DB70724396
	for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2012 08:05:37 +0100 (CET)
Received: by werb12 with SMTP id b12so1866262wer.38
	for <alsa-devel@alsa-project.org>; Fri, 06 Jan 2012 23:05:37 -0800 (PST)
In-Reply-To: <CACRof1UDjOjw4XUU3q-WTJi4U6Osg=eHLoV6g0bz2yBC1FdjTw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Jander <manuel.jander@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--f46d0442720ade945704b5eacae0
Content-Type: text/plain; charset=ISO-8859-1

2012/1/6, Manuel Jander <manuel.jander@gmail.com>:
> Hi,
>
> thanks a lot. I tried your attached patch to 2.6.39 and in compiles
> and works OK as far as I can tell. I have not tested with 4 channel
> items though.
>
> Best Regards,
> Manuel
>
> On Fri, Jan 6, 2012 at 3:22 AM, Raymond Yau <superquad.vortex2@gmail.com>
> wrote:
>> [PATCH ] ALSA au88x0 - Fix IRQ fifo error and channels swap of 4
>> channels playback
>>
>> - Fix IRQ fifo error when playing stereo by set stereo flag of fifo
>> control
>>  This also fix the swap of front and rear channels on au8830
>>
>>
>> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1840
>>
>> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1726
>

The patch only fix "IRQ fifo error"

Still need the following patch to fix the channel swaping of 4 channels playback

Is there any reason to use vortex_adbdma_pausefifo() instead of
vortex_adbdma_stopfifo() for SNDRV_PCM_TRIGGER_STOP event ?

Refer to page 28 of 6167465

Stereo flag 505(i) may be set or reset appropriately, depending on the
type of DMA channel
...
505(c) The channel valid flag indicates that the particular has been
activated and the appropriate sub-buffer table 380, FIFO control
register 505 and FIFO 306 are active


 [PATCH ALSA] Au88x0 - Fix channels swapping of 4 channels playback

- Fix channels swapping of 4 channels playback by
  using vortex_adbdma_stopfifo instead of vortex_adbdma_pausefifo
  for SNDRV_PCM_TRIGGER_STOP event

--f46d0442720ade945704b5eacae0
Content-Type: application/octet-stream;
	name="0002-Au88x0-Fix-channels-swapping-of-4-channels-playbac.patch"
Content-Disposition: attachment;
	filename="0002-Au88x0-Fix-channels-swapping-of-4-channels-playbac.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

RnJvbSAyYWE3NmI4MjI5MjY4NDI3MzljYjE0NDc1ZjdhNjM1ZjlkNmU0MzI2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBTYXQsIDcgSmFuIDIwMTIgMTQ6MzU6MTcgKzA4MDAKU3ViamVjdDogW1BBVENI
IEFMU0FdIEF1ODh4MCAtIEZpeCBjaGFubmVscyBzd2FwcGluZyBvZiA0IGNoYW5uZWxzIHBsYXli
YWNrCgotIEZpeCBjaGFubmVscyBzd2FwcGluZyBvZiA0IGNoYW5uZWxzIHBsYXliYWNrIGJ5CiAg
dXNpbmcgdm9ydGV4X2FkYmRtYV9zdG9wZmlmbyBpbnN0ZWFkIG9mIHZvcnRleF9hZGJkbWFfcGF1
c2VmaWZvCiAgZm9yIFNORFJWX1BDTV9UUklHR0VSX1NUT1AgZXZlbnQKClNpZ25lZC1vZmYtYnk6
IFJheW1vbmQgWWF1IDxzdXBlcnF1YWQudm9ydGV4MkBnbWFpbC5jb20+CgpkaWZmIC0tZ2l0IGEv
c291bmQvcGNpL2F1ODh4MC9hdTg4eDBfY29yZS5jIGIvc291bmQvcGNpL2F1ODh4MC9hdTg4eDBf
Y29yZS5jCmluZGV4IGQ0OWUyYzUuLjY5MzNhMjcgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9hdTg4
eDAvYXU4OHgwX2NvcmUuYworKysgYi9zb3VuZC9wY2kvYXU4OHgwL2F1ODh4MF9jb3JlLmMKQEAg
LTEzMzYsNyArMTMzNiw2IEBAIHN0YXRpYyB2b2lkIHZvcnRleF9hZGJkbWFfcGF1c2VmaWZvKHZv
cnRleF90ICogdm9ydGV4LCBpbnQgYWRiZG1hKQogCWRtYS0+Zmlmb19zdGF0dXMgPSBGSUZPX1BB
VVNFOwogfQogCi0jaWYgMAkJCQkvLyBVc2luZyBwYXVzZSBpbnN0ZWFkCiBzdGF0aWMgdm9pZCB2
b3J0ZXhfYWRiZG1hX3N0b3BmaWZvKHZvcnRleF90ICogdm9ydGV4LCBpbnQgYWRiZG1hKQogewog
CXN0cmVhbV90ICpkbWEgPSAmdm9ydGV4LT5kbWFfYWRiW2FkYmRtYV07CkBAIC0xMzUxLDcgKzEz
NTAsNiBAQCBzdGF0aWMgdm9pZCB2b3J0ZXhfYWRiZG1hX3N0b3BmaWZvKHZvcnRleF90ICogdm9y
dGV4LCBpbnQgYWRiZG1hKQogCWRtYS0+Zmlmb19lbmFibGVkID0gMDsKIH0KIAotI2VuZGlmCiAv
KiBXVERNQSAqLwogCiAjaWZuZGVmIENISVBfQVU4ODEwCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kv
YXU4OHgwL2F1ODh4MF9wY20uYyBiL3NvdW5kL3BjaS9hdTg4eDAvYXU4OHgwX3BjbS5jCmluZGV4
IDhkMDBhYWEuLjVjZGE4MDUgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9hdTg4eDAvYXU4OHgwX3Bj
bS5jCisrKyBiL3NvdW5kL3BjaS9hdTg4eDAvYXU4OHgwX3BjbS5jCkBAIC0zNTMsOCArMzUzLDcg
QEAgc3RhdGljIGludCBzbmRfdm9ydGV4X3BjbV90cmlnZ2VyKHN0cnVjdCBzbmRfcGNtX3N1YnN0
cmVhbSAqc3Vic3RyZWFtLCBpbnQgY21kKQogCQkvL3ByaW50ayhLRVJOX0lORk8gInZvcnRleDog
c3RvcCAlZFxuIiwgZG1hKTsKIAkJc3RyZWFtLT5maWZvX2VuYWJsZWQgPSAwOwogCQlpZiAoVk9S
VEVYX1BDTV9UWVBFKHN1YnN0cmVhbS0+cGNtKSAhPSBWT1JURVhfUENNX1dUKQotCQkJdm9ydGV4
X2FkYmRtYV9wYXVzZWZpZm8oY2hpcCwgZG1hKTsKLQkJLy92b3J0ZXhfYWRiZG1hX3N0b3BmaWZv
KGNoaXAsIGRtYSk7CisJCQl2b3J0ZXhfYWRiZG1hX3N0b3BmaWZvKGNoaXAsIGRtYSk7CiAjaWZu
ZGVmIENISVBfQVU4ODEwCiAJCWVsc2UgewogCQkJcHJpbnRrKEtFUk5fSU5GTyAidm9ydGV4OiB3
dCBzdG9wICVkXG4iLCBkbWEpOwotLSAKMS42LjAuNgoK
--f46d0442720ade945704b5eacae0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--f46d0442720ade945704b5eacae0--
