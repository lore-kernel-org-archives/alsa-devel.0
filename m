From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: HDA: Remove unconnected PCM devices
 for	Intel HDMI
Date: Tue, 23 Nov 2010 15:19:58 +0100
Message-ID: <4CEBCD8E.9020101@canonical.com>
References: <4CDD615A.7000807@canonical.com>	<s5hy68kpl6s.wl%tiwai@suse.de>	<4CEB8968.5090205@canonical.com>	<20101123110639.GA15688@localhost>
	<s5hlj4krvv0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A8F5103A7C
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 15:20:03 +0100 (CET)
In-Reply-To: <s5hlj4krvv0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Wu Fengguang <wfg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 2010-11-23 14:51, Takashi Iwai wrote:
> At Tue, 23 Nov 2010 19:06:39 +0800,
> Wu Fengguang wrote:
>>
>> On Tue, Nov 23, 2010 at 10:29:12AM +0100, David Henningsson wrote:
>>> On 2010-11-23 08:12, Takashi Iwai wrote:
>>>> At Fri, 12 Nov 2010 16:46:34 +0100,
>>>> David Henningsson wrote:
>>>>>
>>>>> Since I'm a little new in HDMI land and the patch is non-trivial, I
>>>>> wouldn't mind some comments on this one. Also thanks to Jaroslav who
>>>>> cleared a few things out about the logical and physical devices which
>>>>> helped me figure out what I should do about it :-)
>>>>>
>>>>> Anyway, here's the patch.
>>>>>
>>>>> Some newer chips have more than one HDMI output, but usually not
>>>>> all of them are exposed as physical jacks. Removing the unused
>>>>> PCM devices (as indicated by BIOS in the pin config default) will
>>>>> reduce user confusion as they currently have to choose between
>>>>> several HDMI devices, some of them not working anyway.
>>>>>
>>>>> Signed-off-by: David Henningsson<david.henningsson@canonical.com>
>>>>
>>>> The patch looks mostly OK.
>>>> But this gives a few errors and warnings via checkpatch.pl.
>>>> Could you fix errors, at least?
>>>>
>>>> Also some review comments:
>>>>
>>>>>   static int hdmi_add_cvt(struct hda_codec *codec, hda_nid_t nid)
>>>>>   {
>>>>> +	int i;
>>>>>   	struct hdmi_spec *spec = codec->spec;
>>>>>
>>>>> -	if (spec->num_cvts>= MAX_HDMI_CVTS) {
>>>>> -		snd_printk(KERN_WARNING
>>>>> -			   "HDMI: no space for converter %d\n", nid);
>>>>> +	for (i = 0; spec->pin_cvt[i] != nid; i++)
>>>>
>>>> I'd write with a normal loop like for (i = 0; i<   spec->num_pins; i++)
>>>> This is easier to read.
>>>>
>>>>> +		if (!spec->pin[i]) {
>>>>> +			snd_printd("HDMI: Skipping node %d (no connection)\n", nid);
>>>>
>>>> Better to use snd_printdd().  snd_printd() is enabled on many distros,
>>>> and such an unnecessary kernel message may make user worry.
>>>>
>>>>> @@ -951,17 +954,33 @@ static int hdmi_parse_codec(struct hda_codec *codec)
>>>> ...
>>>>>   		case AC_WID_PIN:
>>>>>   			caps = snd_hda_param_read(codec, nid, AC_PAR_PIN_CAP);
>>>>>   			if (!(caps&   (AC_PINCAP_HDMI | AC_PINCAP_DP)))
>>>>>   				continue;
>>>>> +
>>>>> +			config = snd_hda_codec_read(codec, nid, 0,
>>>>> +					     AC_VERB_GET_CONFIG_DEFAULT, 0);
>>>>> +			if (((config&   AC_DEFCFG_PORT_CONN)>>
>>>>> +			    AC_DEFCFG_PORT_CONN_SHIFT) == AC_JACK_PORT_NONE)
>>>>
>>>> You can use get_defcfg_connect() here.
>>>
>>> Thanks for the review, Takashi! I usually run checkpatch.pl these
>>> days but this one must have slipped. What do you think of this patch
>>> (untested)?
>>
>> Thanks for the patch, I'll help test it out :)
>>
>> I didn't do such feature because I'm not sure if the BIOS provided
>> info can be trusted,

Perhaps Wu knows what Intel's default is, would that be all outputs 
configured as Jacks, or as N/A? I'm thinking that if it is Jacks, then 
BIOS changing that to N/A probably knows what it's doing. If it is the 
other way around - perhaps we should add something saying that if it's 
all N/A, ignore the extra check and enable all outputs.

Anyway it's overridable through user_pin_configs / driver_pin_configs.

>> or if that's merely the default configuration
>> that may be changed runtime on user request (eg. switching from
>> A+A view to A+B view etc.).

Ah, interesting. But if A+B view is possible, wouldn't BIOS then 
configure both HDMI outputs as Jacks?

> Well, whether this BIOS setup is really reliable is still an open
> question.  David, do you know (or have) the case whether your patch
> works on a real machine, right?

Yes; although this latest version of the patch has not been tested on 
that machine yet.

> Other than that, I don't see any problem in the patch.
> I'm going to apply it (but for 2.6.38) later.

Just to clarify, will it be applied to the sound-2.6 tree soon (i e the 
branch that you create your daily snapshots from)?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
