From: Julian Scheel <julian@jusst.de>
Subject: Re: [PATCH] ALSA: usb-audio: Recurse before saving
 terminal properties
Date: Mon, 17 Aug 2015 10:35:00 +0200
Message-ID: <55D19CB4.3080208@jusst.de>
References: <1439410499-28630-1-git-send-email-julian@jusst.de>
 <s5hr3n6t3wt.wl-tiwai@suse.de> <55CDEC38.7000006@jusst.de>
 <55D077D0.90005@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender163-mail.zoho.com (sender163-mail.zoho.com
 [74.201.84.163])
 by alsa0.perex.cz (Postfix) with ESMTP id EED732605F0
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 10:35:06 +0200 (CEST)
In-Reply-To: <55D077D0.90005@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

On 16.08.2015 13:45, Daniel Mack wrote:
> Hi,
>
> On 08/14/2015 03:25 PM, Julian Scheel wrote:
>> Am 14.08.2015 um 15:06 schrieb Takashi Iwai:
>
>>>> @@ -715,15 +715,16 @@ static int check_input_term(struct mixer_build *state, int id,
>>>>    				term->name = d->iTerminal;
>>>>    			} else { /* UAC_VERSION_2 */
>>>>    				struct uac2_input_terminal_descriptor *d = p1;
>>>> -				term->type = le16_to_cpu(d->wTerminalType);
>>>> -				term->channels = d->bNrChannels;
>>>> -				term->chconfig = le32_to_cpu(d->bmChannelConfig);
>>>> -				term->name = d->iTerminal;
>>>>
>>>>    				/* call recursively to get the clock selectors */
>>>>    				err = check_input_term(state, d->bCSourceID, term);
>>>>    				if (err < 0)
>>>>    					return err;
>>>> +
>>>> +				term->type = le16_to_cpu(d->wTerminalType);
>>>> +				term->channels = d->bNrChannels;
>>>> +				term->chconfig = le32_to_cpu(d->bmChannelConfig);
>>>> +				term->name = d->iTerminal;
>>>
>>> ... by this override, essentially all fields except for id are
>>> restored.  Then what's the point to call check_input_term() for the
>>> clock source?
>>
>> This is a good point indeed, but due do my understanding the recursion
>> is not about filling missing information, but about verifying a valid
>> descriptor. So in case there are broken references in the descriptor it
>> gets abandoned. I'm happy to be corrected if this understanding is wrong.
>
> Hmm, good point. It' been a while since I worked on this, but looking at
> the code right now, you're right, the mixer unit for input terminal is
> indeed just overridden by the information of the clock selector on UAC2.
> That doesn't seem right.
>
> I guess what we really want is to add a 2nd mixer control in such cases,
> and that would mean we need to call into parse_audio_selector_unit()
> instead.

I just had another look at this. In fact all mixer controls are properly 
created with the current code. This happens in the loop over all 
descriptors in snd_usb_mixer_controls. parse_audio_unit is called for 
each of them. For clock selectors and selector units it calls 
parse_audio_selector_unit where the actual clock selector/selector units 
are parsed and mixer ctls are created.
So I'd renew my first comment about the recursion. It is only needed to 
verify the integrity of descriptors and hence shall not overwrite any 
values.

After patching my device to offer 2 clocks on the clock selector the 
mixer looks like this with my patch:
--
Simple mixer control 'Master',0
   Capabilities: pvolume pvolume-joined pswitch pswitch-joined
   Playback channels: Mono
   Limits: Playback 0 - 44
   Mono: Playback 26 [59%] [-36.00dB] [on]
Simple mixer control 'Clock Selector',0
   Capabilities: enum
   Items: 'Internal Clock' 'Fake Clock'
   Item0: 'Internal Clock'
Simple mixer control 'Input Selector',0
   Capabilities: enum
   Items: 'USB' 'S/PDIF'
   Item0: 'USB'
--

Running the same without my patch results in:
--
Simple mixer control 'Master',0
   Capabilities: pvolume pvolume-joined pswitch pswitch-joined
   Playback channels: Mono
   Limits: Playback 0 - 44
   Mono: Playback 26 [59%] [-36.00dB] [on]
Simple mixer control 'Clock Selector',0
   Capabilities: enum
   Items: 'Internal Clock' 'Fake Clock'
   Item0: 'Internal Clock'
Simple mixer control 'Input Selector',0
   Capabilities: enum
   Items: 'Clock Selector' 'Clock Selector'
   Item0: 'Clock Selector'
--

So you can see, in both cases the mixer controls are generated as it 
should be. But the original code applies the wrong labels to all the 
Input Terminals associated to Input Selector. I think keeping the 
recursion, but not using any of the term values from the recursion is 
the correct approach as it ensures there are no dead ends in the 
descriptor hierarchy (i.e. referencing non-existant clock entities), but 
keeps the actual terminal properties correct.
What shall be changed in my original patch is that the term->id shall 
also be reset after recursing into check_input_term, as otherwise the 
input terminals are stored with the clock selectors id. Would you agree 
on that?

Thanks,
Julian
