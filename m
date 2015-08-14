From: Julian Scheel <julian@jusst.de>
Subject: Re: [PATCH] ALSA: usb-audio: Recurse before saving
 terminal properties
Date: Fri, 14 Aug 2015 15:25:12 +0200
Message-ID: <55CDEC38.7000006@jusst.de>
References: <1439410499-28630-1-git-send-email-julian@jusst.de>
 <s5hr3n6t3wt.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender163-mail.zoho.com (sender163-mail.zoho.com
 [74.201.84.163])
 by alsa0.perex.cz (Postfix) with ESMTP id B04F22654B3
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2015 15:25:18 +0200 (CEST)
In-Reply-To: <s5hr3n6t3wt.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Am 14.08.2015 um 15:06 schrieb Takashi Iwai:
> On Wed, 12 Aug 2015 22:14:59 +0200,
> Julian Scheel wrote:
>>
>> When the descriptor parser recurses into the clock source descriptor, the
>> terminals properties, like name and type, are set to the values of the clock
>> selector as check_input_term overwrites term->name and others in the recursive
>> call. As we want to only fill missing values using the descriptors higher in
>> the recursion tree the properties taken from the actual descriptor must be
>> applied after recursing.
>>
>> Signed-off-by: Julian Scheel <julian@jusst.de>
>
> Thanks for the patch.  I vaguely remember of a similar patch, maybe
> you who already sent.

Hm, I couldn't remember to have sent a similar patch before :)

> One thing I find uncertain is whether this
> breaks the current logic completely, namely:
>
>> @@ -715,15 +715,16 @@ static int check_input_term(struct mixer_build *state, int id,
>>   				term->name = d->iTerminal;
>>   			} else { /* UAC_VERSION_2 */
>>   				struct uac2_input_terminal_descriptor *d = p1;
>> -				term->type = le16_to_cpu(d->wTerminalType);
>> -				term->channels = d->bNrChannels;
>> -				term->chconfig = le32_to_cpu(d->bmChannelConfig);
>> -				term->name = d->iTerminal;
>>
>>   				/* call recursively to get the clock selectors */
>>   				err = check_input_term(state, d->bCSourceID, term);
>>   				if (err < 0)
>>   					return err;
>> +
>> +				term->type = le16_to_cpu(d->wTerminalType);
>> +				term->channels = d->bNrChannels;
>> +				term->chconfig = le32_to_cpu(d->bmChannelConfig);
>> +				term->name = d->iTerminal;
>
> ... by this override, essentially all fields except for id are
> restored.  Then what's the point to call check_input_term() for the
> clock source?

This is a good point indeed, but due do my understanding the recursion 
is not about filling missing information, but about verifying a valid 
descriptor. So in case there are broken references in the descriptor it 
gets abandoned. I'm happy to be corrected if this understanding is wrong.

When overriding the value in the recursion as it is without this patch 
it leads to virtually any control getting the name of the Clock 
Selector... I wondered about this on several UAC2 devices (like the XMOS 
stuff), before I looked into it.

-Julian
