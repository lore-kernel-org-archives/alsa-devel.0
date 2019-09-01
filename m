From: Hui Peng <benquike@gmail.com>
Subject: Re: [PATCH 1/2] Fix an OOB bug in parse_audio_mixer_unit
Date: Sun, 1 Sep 2019 15:43:13 -0400
Message-ID: <df31a1f9-623a-aff6-fa7c-01eba3fd0f63@gmail.com>
References: <20190830214649.27761-1-benquike@gmail.com>
 <20190901125809.GA23334@eldamar.local>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------C17843906CF228CD9BE7D7BA"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190901125809.GA23334@eldamar.local>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: carnil@debian.org
Cc: stable@vger.kernel.org, mathias.payer@nebelwelt.net, perex@perex.cz, tiwai@suse.com, gregkh@linuxfoundation.org, wang6495@umn.edu, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------C17843906CF228CD9BE7D7BA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


On 9/1/19 8:58 AM, Salvatore Bonaccorso wrote:
> On Fri, Aug 30, 2019 at 05:46:49PM -0400, Hui Peng wrote:
>> The `uac_mixer_unit_descriptor` shown as below is read from the
>> device side. In `parse_audio_mixer_unit`, `baSourceID` field is
>> accessed from index 0 to `bNrInPins` - 1, the current implementation
>> assumes that descriptor is always valid (the length  of descriptor
>> is no shorter than 5 + `bNrInPins`). If a descriptor read from
>> the device side is invalid, it may trigger out-of-bound memory
>> access.
>>
>> ```
>> struct uac_mixer_unit_descriptor {
>> 	__u8 bLength;
>> 	__u8 bDescriptorType;
>> 	__u8 bDescriptorSubtype;
>> 	__u8 bUnitID;
>> 	__u8 bNrInPins;
>> 	__u8 baSourceID[];
>> }
>> ```
>>
>> This patch fixes the bug by add a sanity check on the length of
>> the descriptor.
>>
>> CVE: CVE-2018-15117
> FWIW, the correct CVE id should be probably CVE-2019-15117 here.

Yes, the CVE id was wrong. I have updated it in the attached patch.

> But there was already a patch queued and released in 5.2.10 and
> 4.19.68 for this issue (as far I can see; is this correct?)

Yes, it should have been fixed in those branches.

But google asked me to back port it to v4.4.190 and v4.14.141.

I have mentioned it in one previous email, but it was blocked by vger
because it was sent in html format.

Can you apply it to these 2 versions? (it applies to both versions)

Thanks.

> Regards,
> Salvatore

--------------C17843906CF228CD9BE7D7BA
Content-Type: text/x-patch;
 name="0001-Fix-an-OOB-bug-in-parse_audio_mixer_unit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Fix-an-OOB-bug-in-parse_audio_mixer_unit.patch"

>From 09942398a53bbe730264b782673890d4a54068d0 Mon Sep 17 00:00:00 2001
From: Hui Peng <benquike@gmail.com>
Date: Fri, 30 Aug 2019 16:11:00 -0400
Subject: [PATCH 1/2] Fix an OOB bug in parse_audio_mixer_unit

The `uac_mixer_unit_descriptor` shown as below is read from the
device side. In `parse_audio_mixer_unit`, `baSourceID` field is
accessed from index 0 to `bNrInPins` - 1, the current implementation
assumes that descriptor is always valid (the length  of descriptor
is no shorter than 5 + `bNrInPins`). If a descriptor read from
the device side is invalid, it may trigger out-of-bound memory
access.

```
struct uac_mixer_unit_descriptor {
	__u8 bLength;
	__u8 bDescriptorType;
	__u8 bDescriptorSubtype;
	__u8 bUnitID;
	__u8 bNrInPins;
	__u8 baSourceID[];
}
```

This patch fixes the bug by add a sanity check on the length of
the descriptor.

CVE: CVE-2019-15117

Reported-by: Hui Peng <benquike@gmail.com>
Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 sound/usb/mixer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 1f7eb3816cd7..10ddec76f906 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1628,6 +1628,7 @@ static int parse_audio_mixer_unit(struct mixer_build *state, int unitid,
 	int pin, ich, err;
 
 	if (desc->bLength < 11 || !(input_pins = desc->bNrInPins) ||
+	    desc->bLength < sizeof(*desc) + desc->bNrInPins ||
 	    !(num_outs = uac_mixer_unit_bNrChannels(desc))) {
 		usb_audio_err(state->chip,
 			      "invalid MIXER UNIT descriptor %d\n",
-- 
2.17.1


--------------C17843906CF228CD9BE7D7BA--
