From: Wang Xingchao <wangxingchao2011@gmail.com>
Subject: Re: [PATCH 2/2] ALSA: hda - get realtime ELD info when
 codec suspended
Date: Fri, 12 Jul 2013 02:13:44 -0400
Message-ID: <CA+v+29g2RvJfC-rkp-Qbwo1je-s86t+uACUY4k6vgerJHUPKrg@mail.gmail.com>
References: <1372074324-13563-1-git-send-email-xingchao.wang@linux.intel.com>
 <1372074324-13563-2-git-send-email-xingchao.wang@linux.intel.com>
 <s5hmwqfvizc.wl%tiwai@suse.de>
 <46B810F6945F7C4788E11DCE57EC489011833B68@SHSMSX104.ccr.corp.intel.com>
 <s5hk3ljvhu2.wl%tiwai@suse.de> <51C83FC5.3090005@canonical.com>
 <s5h38s7vf2v.wl%tiwai@suse.de> <51C94A80.70709@canonical.com>
 <s5hobauzkse.wl%tiwai@suse.de> <51C95CA3.7000001@canonical.com>
 <46B810F6945F7C4788E11DCE57EC4890118344E1@SHSMSX104.ccr.corp.intel.com>
 <51C96640.2020103@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7bd9037cefccc104e14a6aa1
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
 [209.85.192.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D4732650FE
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 08:14:05 +0200 (CEST)
Received: by mail-pd0-f170.google.com with SMTP id x11so8322854pdj.1
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 23:14:04 -0700 (PDT)
In-Reply-To: <51C96640.2020103@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
 Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

--047d7bd9037cefccc104e14a6aa1
Content-Type: text/plain; charset=ISO-8859-1

Hi David/Takashi,

Here's some update on this topic.
I used evtest to monitor hotplug input event for Headphone, it doesnot
report the hotplug event when audio controller/codec in runtime
suspend mode.
if it's during audio playback(both controller and codec are active),
the events could be monitored correctly.
However even the controller/codec in runtime suspend mode, the hotplug
event was not missed when waken up from suspend mode. After exit from
suspend mode, the hotplug event would be reported asap.
So userspace will not receive the event notification from driver when
controller/codec in suspend mode, but it will get them once audio
controller/codec become active.
I think it's acceptable for audio playback functinality, it will not
harm audio routing in fact. i'm not sure there's other potential risk,
i.e. user space will show/hide the devices in UI according to the
event, in that case , user will never see the Headphone device for
playback before audio controller/codec was waken up in another way.

Meanwhile i tested attached patch to monitor WAKEEN events, it doesnot
work well as Spec said. it would not wake up audio controller/codec
when plug in/out headphone in runtime suspend mode, and the status
register always be 0.

thanks
--xingchao


2013/6/25 David Henningsson <david.henningsson@canonical.com>:
> On 06/25/2013 11:33 AM, Wang, Xingchao wrote:
>>
>> Hi David,
>>
>>
>>> -----Original Message-----
>>> From: alsa-devel-bounces@alsa-project.org
>>> [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of David
>>> Henningsson
>>> Sent: Tuesday, June 25, 2013 5:02 PM
>>> To: Wang, Xingchao
>>> Cc: Takashi Iwai; alsa-devel@alsa-project.org
>>> Subject: Re: [alsa-devel] [PATCH 2/2] ALSA: hda - get realtime ELD info
>>> when
>>> codec suspended
>>>
>>> On 06/25/2013 09:55 AM, Takashi Iwai wrote:
>>>>
>>>> At Tue, 25 Jun 2013 09:45:04 +0200,
>>>> David Henningsson wrote:
>>>>>>
>>>>>> There is a low power mode that allows the jack detection, but this
>>>>>> is different from the aggressive power-saving with runtime D3.
>>>>>
>>>>>
>>>>> If "aggressive power-saving with runtime D3" is the same as
>>>>> AZX_DCAPS_PM_RUNTIME, this is also enabled for analog codecs
>>>>> connected to a Lynx point controller.
>>>>>
>>>>> It looks like userspace have problems getting notifications for e g
>>>>> headphone insertion on Lynx point controllers, so this is not only an
>>>>> HDMI/DP problem?
>>>>
>>>>
>>>> Yes.
>>>>
>>>>> Trying to read up a little on this, there seem to be an option to set
>>>>> the WAKEEN register to have jack detection working even when the
>>>>> controller is in D3. (refer HDA specification 4.5.9.2:
>>>>> Codec Wake From System S0, Controller D3.) But it seems we do not
>>>>> (yet) use this feature. Is this something that could/should be
>>>>> implemented to fix the jack detection problems that seems to be
>>>>> happening otherwise?
>>>>
>>>>
>>>> It sounds feasible, at least for traditional jack detection of analog
>>>> pins.  But I'm not sure whether this would help for the Intel graphics
>>>> case.  Just need testing.
>>>
>>>
>>> Xingchao, what are your thoughts about using WAKEEN to wakeup both Lynx
>>> point and Haswell HDMI?
>>
>>
>> That's okay for me, I would do some test on that. do you have some test
>> cases?
>> That would help me verify them when enable WAKEEN feature.
>
>
> Since we still enable the legacy jack feature through /dev/input/event*, the
> easiest way to test would probably to run evtest (which is in the Ubuntu
> repositories). Find the correct /dev/input/event file by checking dmesg (or
> just trying them one by one), then run "sudo evtest /dev/input/<filename>".
>
> Now check if you get events correctly on HDMI/DP/Headphone/Mic/etc plug and
> unplug, even if the controller is runtime suspended.
>
> Also note that WAKEEN should probably be disabled during system S3, because
> we don't want to wake up the entire computer just because somebody unplugs
> his headphone, right?
>
>
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--047d7bd9037cefccc104e14a6aa1
Content-Type: application/octet-stream;
	name="0001-ALSA-hda-Enable-WAKEEN-for-codecs-blindly-for-test.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-hda-Enable-WAKEEN-for-codecs-blindly-for-test.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hj0kmzmh0

RnJvbSBjNzA1NjZlMDFiYTJlZDhhMGU3MDg5YjdlOTgxZDc4MDBkNDJlYTk5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBXYW5nIFhpbmdjaGFvIDx4aW5nY2hhby53YW5nQGxpbnV4Lmlu
dGVsLmNvbT4KRGF0ZTogVGh1LCAxMSBKdWwgMjAxMyAxODo1NDoyMCAtMDQwMApTdWJqZWN0OiBb
UEFUQ0hdIEFMU0E6IGhkYSAtIEVuYWJsZSBXQUtFRU4gZm9yIGNvZGVjcyBibGluZGx5IGZvciB0
ZXN0CgpBcyBIREEgU3BlYyg0LjUuOS4yKSBzYWlkLCBXQUtFRU4gYml0cyBlbmFibGUgd2FraW5n
IHVwIGNhcGFiaWxpdHkKd2hlbiBjb250cm9sbGVyIGluIEQzIG9yIHN5c3RlbSBpbiBTMy4gVGhp
cyBwYXRjaCBlbmFibGVkIGFsbCBXQUtFRU4KYml0cyBibGluZGx5IGZvciB0ZXN0LgoKU2lnbmVk
LW9mZi1ieTogV2FuZyBYaW5nY2hhbyA8eGluZ2NoYW8ud2FuZ0BsaW51eC5pbnRlbC5jb20+Ci0t
LQogc291bmQvcGNpL2hkYS9oZGFfaW50ZWwuYyB8IDExICsrKysrKysrKystCiAxIGZpbGUgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3NvdW5k
L3BjaS9oZGEvaGRhX2ludGVsLmMgYi9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCmluZGV4IGNj
NTQ4ZTAwLi5mOWEyNTE4IDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jCisr
KyBiL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKQEAgLTEyOTAsNiArMTI5MCw5IEBAIHN0YXRp
YyB2b2lkIGF6eF9pbml0X2NoaXAoc3RydWN0IGF6eCAqY2hpcCwgaW50IGZ1bGxfcmVzZXQpCiAJ
YXp4X3dyaXRlbChjaGlwLCBEUExCQVNFLCAodTMyKWNoaXAtPnBvc2J1Zi5hZGRyKTsKIAlhenhf
d3JpdGVsKGNoaXAsIERQVUJBU0UsIHVwcGVyXzMyX2JpdHMoY2hpcC0+cG9zYnVmLmFkZHIpKTsK
IAorCS8qIGVuYWJsZSBjb250cm9sbGVyIFdha2UgVXAgZXZlbnQqLworCWF6eF93cml0ZWIoY2hp
cCwgV0FLRUVOLCBhenhfcmVhZGIoY2hpcCwgV0FLRUVOKSB8CisJCSAgMHhGRik7CiAJY2hpcC0+
aW5pdGlhbGl6ZWQgPSAxOwogfQogCkBAIC0xMzc0LDcgKzEzNzcsNyBAQCBzdGF0aWMgaXJxcmV0
dXJuX3QgYXp4X2ludGVycnVwdChpbnQgaXJxLCB2b2lkICpkZXZfaWQpCiB7CiAJc3RydWN0IGF6
eCAqY2hpcCA9IGRldl9pZDsKIAlzdHJ1Y3QgYXp4X2RldiAqYXp4X2RldjsKLQl1MzIgc3RhdHVz
OworCXUzMiBzdGF0dXMsIGV2ZW50OwogCXU4IHNkX3N0YXR1czsKIAlpbnQgaSwgb2s7CiAKQEAg
LTEzODMsNiArMTM4NiwxMiBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgYXp4X2ludGVycnVwdChpbnQg
aXJxLCB2b2lkICpkZXZfaWQpCiAJCXJldHVybiBJUlFfTk9ORTsKICNlbmRpZgogCisJc3RhdHVz
ID0gYXp4X3JlYWRiKGNoaXAsIFNUQVRFU1RTKTsKKwlpZiAoc3RhdHVzKSB7CisJCWV2ZW50ID0g
YXp4X3JlYWRiKGNoaXAsIFdBS0VFTik7CisJCXNuZF9wcmludGRkKCJ3YWtlIHVwIGV2ZW50ICV4
IHN0YXR1cyAleFxuIiwgZXZlbnQsIHN0YXR1cyk7CisJfQorCiAJc3Bpbl9sb2NrKCZjaGlwLT5y
ZWdfbG9jayk7CiAKIAlpZiAoY2hpcC0+ZGlzYWJsZWQpIHsKLS0gCjEuOC4zLjIKCg==
--047d7bd9037cefccc104e14a6aa1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--047d7bd9037cefccc104e14a6aa1--
