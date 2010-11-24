From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: HDA: Remove unconnected PCM devices
 for	Intel HDMI
Date: Wed, 24 Nov 2010 14:50:34 +0100
Message-ID: <4CED182A.3010204@canonical.com>
References: <4CDD615A.7000807@canonical.com> <s5hy68kpl6s.wl%tiwai@suse.de>
	<4CEB8968.5090205@canonical.com> <20101123151536.GB26749@localhost>
	<4CEBE081.10705@canonical.com> <20101123155432.GA32248@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 01990103964
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 14:50:38 +0100 (CET)
In-Reply-To: <20101123155432.GA32248@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wu Fengguang <wfg@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 2010-11-23 16:54, Wu Fengguang wrote:
> On Tue, Nov 23, 2010 at 04:40:49PM +0100, David Henningsson wrote:
>> On 2010-11-23 16:15, Wu Fengguang wrote:
>>>>>  From ca84aa8edbfb66e46266677249b141b5419d6e0a Mon Sep 17 00:00:00 2001
>>>> From: David Henningsson<david.henningsson@canonical.com>
>>>> Date: Tue, 23 Nov 2010 10:23:40 +0100
>>>> Subject: [PATCH] ALSA: HDA: Remove unconnected PCM devices for Intel HDMI
>>>>
>>>> Some newer chips have more than one HDMI output, but usually not
>>>
>>> Please point out the model name here (where this patch actually makes
>>> a difference)?
>>
>> I'm attaching the codec-proc file for the relevant machine, which
>> lists as "Intel Cougarpoint HDMI".
>
> Yes it's different from old models:
>
>    Pin Default 0x58560010: [N/A] Digital Out at Int HDMI
>    Pin Default 0x58560020: [N/A] Digital Out at Int HDMI
>    Pin Default 0x18560030: [Jack] Digital Out at Int HDMI

Seems like the BIOS writers actually did what they should in this case, 
as opposed to leaving them all as "Jack"s?

>>>> all of them are exposed as physical jacks. Removing the unused
>>>> PCM devices (as indicated by BIOS in the pin config default) will
>>>> reduce user confusion as they currently have to choose between
>>>> several HDMI devices, some of them not working anyway.
>>>>
>>>> Signed-off-by: David Henningsson<david.henningsson@canonical.com>
>>>> ---
>>>>   sound/pci/hda/patch_hdmi.c |   41 ++++++++++++++++++++++++++++++++---------
>>>>   1 files changed, 32 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
>>>> index d3e49aa..14a1087 100644
>>>> --- a/sound/pci/hda/patch_hdmi.c
>>>> +++ b/sound/pci/hda/patch_hdmi.c
>>>> @@ -905,23 +905,28 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
>>>>   	spec->pin[spec->num_pins] = pin_nid;
>>>>   	spec->num_pins++;
>>>>
>>>> -	/*
>>>> -	 * It is assumed that converter nodes come first in the node list and
>>>> -	 * hence have been registered and usable now.
>>>> -	 */
>>>>   	return hdmi_read_pin_conn(codec, pin_nid);
>>>>   }
>>>>
>>>>   static int hdmi_add_cvt(struct hda_codec *codec, hda_nid_t nid)
>>>>   {
>>>> +	int i, found_pin = 0;
>>>>   	struct hdmi_spec *spec = codec->spec;
>>>>
>>>> -	if (spec->num_cvts>= MAX_HDMI_CVTS) {
>>>> -		snd_printk(KERN_WARNING
>>>> -			   "HDMI: no space for converter %d\n", nid);
>>>> -		return -E2BIG;
>>>
>>>> +	for (i = 0; i<   spec->num_pins; i++)
>>>> +		if (nid == spec->pin_cvt[i]) {
>>>> +			found_pin = 1;
>>>> +			break;
>>>> +		}
>>>> +
>>>> +	if (!found_pin) {
>>>
>>> Can test this instead:
>>>
>>>          if (hda_node_index(spec->pin_cvt, nid)<   0) {
>>
>> Yes, that would probably be simpler.
>>
>>>> +		snd_printdd("HDMI: Skipping node %d (no connection)\n", nid);
>>>> +		return -EINVAL;
>>>>   	}
>>>
>>> The above return actually will hide the device for cvt 3:
>>>
>>>                 +---- pin 4
>>>                /
>>>          cvt 2 ------ pin 5
>>>                \
>>>                 +---- pin 6
>>>
>>>          cvt 3
>>>
>>> Which is the default connection for Intel ibexpeak/sandybridge codecs.
>>> It might be a problem when the user uses dual displays (which may be
>>> configured at runtime). I have no such a setup, so cannot assure
>>> things will work or not work..
>>
>> Hmm, is this really relevant? Looking at the current patch_hdmi.c, I
>> can't see that it ever tries to change pin<->  cvt connections, but
>> I might be missing something.
>
> I just feel uncertain. Perhaps when there comes a need in future, we
> can further do a patch to "restore" the hidden device at runtime?

Ok. Well, we could just disable cvt's that has no possible connections 
to a Jack (as compared to no *active* connections), but on the other 
hand - the day we need to change pin-cvt connections at runtime, we'll 
probably have to revisit this patch, as well as a lot of other code in 
patch_hdmi.c.

It seems like an unusual use case to me to need two different HDMI audio 
streams to two different displays, but who knows...

>> In fact, I have yet to see an HDMI codec where you can actually
>> perform that change, perhaps you can post such a codec-proc file?
>
> Here is the SandyBridge model. IbexPeak is almost the same.

Thanks!

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
