From: Julian Scheel <julian@jusst.de>
Subject: Re: [PATCH] ALSA: usb-audio: Recurse before saving
 terminal properties
Date: Mon, 17 Aug 2015 07:56:48 +0200
Message-ID: <55D177A0.9020501@jusst.de>
References: <1439410499-28630-1-git-send-email-julian@jusst.de>
 <s5hr3n6t3wt.wl-tiwai@suse.de> <55CDEC38.7000006@jusst.de>
 <55D077D0.90005@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender163-mail.zoho.com (sender163-mail.zoho.com
 [74.201.84.163])
 by alsa0.perex.cz (Postfix) with ESMTP id E648526053D
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 07:56:54 +0200 (CEST)
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

On 16.08.15 13:45, Daniel Mack wrote:
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

Ah, you're right. The Clock Selector shall actually be exposed as a 
mixer unit. This never happened with the current code, but it just 
renamed all other selectors to the name of the clock selector if it existed.

> I can cook up or test a patch next week, when I have access to test
> hardware.

I can update my patch to reflect this as well. If you haven't done 
before I'll try to do it later today.

-Julian
