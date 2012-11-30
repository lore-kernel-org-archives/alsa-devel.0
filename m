From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 1/5] ALSA: hda - Rearrange INPUT_PIN_ATTR_*
Date: Fri, 30 Nov 2012 08:31:46 +0100
Message-ID: <50B860E2.9060207@canonical.com>
References: <1354202489-12769-1-git-send-email-tiwai@suse.de>
 <1354202489-12769-2-git-send-email-tiwai@suse.de>
 <50B7F5B3.1030206@canonical.com> <s5hd2yv4lo5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id ED96D2615F7
 for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2012 08:31:47 +0100 (CET)
In-Reply-To: <s5hd2yv4lo5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/30/2012 08:03 AM, Takashi Iwai wrote:
> At Fri, 30 Nov 2012 00:54:27 +0100,
> David Henningsson wrote:
>>
>> On 11/29/2012 04:21 PM, Takashi Iwai wrote:
>>> Put INPUT_PIN_ATTR_FRONT after INPUT_PIN_ATTR_REAR, and define
>>> INPUT_PIN_ATTR_LAST to point to the last element.
>>>
>>> This is a preliminary work for cleaning up Realtek auto-mic parser.
>>
>> What practical effect does switching "Rear Mic" and "Front Mic" actually
>> have?
>
> For making the front jack in a higher priority than the rear jack.
> This logic is used in the later patch in the series.

Ok, then including that in the commit message, and maybe also something 
about that the order matters for priority as a code comment, would 
probably be a good improvement to this patch.

>
>
> Takashi
>
>>
>>
>>
>>>
>>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>> ---
>>>    sound/pci/hda/hda_auto_parser.c | 2 +-
>>>    sound/pci/hda/hda_auto_parser.h | 3 ++-
>>>    sound/pci/hda/patch_via.c       | 2 +-
>>>    3 files changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
>>> index 4ec6dc8..90d5b39 100644
>>> --- a/sound/pci/hda/hda_auto_parser.c
>>> +++ b/sound/pci/hda/hda_auto_parser.c
>>> @@ -375,7 +375,7 @@ static const char *hda_get_input_pin_label(struct hda_codec *codec,
>>>    {
>>>    	unsigned int def_conf;
>>>    	static const char * const mic_names[] = {
>>> -		"Internal Mic", "Dock Mic", "Mic", "Front Mic", "Rear Mic",
>>> +		"Internal Mic", "Dock Mic", "Mic", "Rear Mic", "Front Mic"
>>>    	};
>>>    	int attr;
>>>
>>> diff --git a/sound/pci/hda/hda_auto_parser.h b/sound/pci/hda/hda_auto_parser.h
>>> index 632ad0a..b7d7103 100644
>>> --- a/sound/pci/hda/hda_auto_parser.h
>>> +++ b/sound/pci/hda/hda_auto_parser.h
>>> @@ -51,8 +51,9 @@ enum {
>>>    	INPUT_PIN_ATTR_INT,	/* internal mic/line-in */
>>>    	INPUT_PIN_ATTR_DOCK,	/* docking mic/line-in */
>>>    	INPUT_PIN_ATTR_NORMAL,	/* mic/line-in jack */
>>> -	INPUT_PIN_ATTR_FRONT,	/* mic/line-in jack in front */
>>>    	INPUT_PIN_ATTR_REAR,	/* mic/line-in jack in rear */
>>> +	INPUT_PIN_ATTR_FRONT,	/* mic/line-in jack in front */
>>> +	INPUT_PIN_ATTR_LAST = INPUT_PIN_ATTR_FRONT,
>>>    };
>>>
>>>    int snd_hda_get_input_pin_attr(unsigned int def_conf);
>>> diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
>>> index 274644f..9f04f33 100644
>>> --- a/sound/pci/hda/patch_via.c
>>> +++ b/sound/pci/hda/patch_via.c
>>> @@ -1894,7 +1894,7 @@ static void mangle_smart51(struct hda_codec *codec)
>>>    	int i, j, nums, attr;
>>>    	int pins[AUTO_CFG_MAX_INS];
>>>
>>> -	for (attr = INPUT_PIN_ATTR_REAR; attr >= INPUT_PIN_ATTR_NORMAL; attr--) {
>>> +	for (attr = INPUT_PIN_ATTR_LAST; attr >= INPUT_PIN_ATTR_NORMAL; attr--) {
>>>    		nums = 0;
>>>    		for (i = 0; i < cfg->num_inputs; i++) {
>>>    			unsigned int def;
>>>
>>
>>
>>
>> --
>> David Henningsson, Canonical Ltd.
>> https://launchpad.net/~diwic
>>
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
