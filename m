From: =?UTF-8?Q?Johan_Aires_Rast=C3=A9n?= <johan@oljud.se>
Subject: Re: [PATCH] ALSA: usb-audio: Recurse before saving
 terminal properties
Date: Sun, 6 Sep 2015 17:34:23 +0200
Message-ID: <CAMFLXsB8FAt4S9i2Lb2g60KJ9G-u=DnzTYwrqq6OE0yeFMSFig@mail.gmail.com>
References: <1439410499-28630-1-git-send-email-julian@jusst.de>
 <s5hr3n6t3wt.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 98E40261569
 for <alsa-devel@alsa-project.org>; Sun,  6 Sep 2015 17:34:23 +0200 (CEST)
Received: by wiclk2 with SMTP id lk2so60546806wic.1
 for <alsa-devel@alsa-project.org>; Sun, 06 Sep 2015 08:34:23 -0700 (PDT)
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
Cc: Julian Scheel <julian@jusst.de>, alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

On 14 August 2015 at 15:06, Takashi Iwai <tiwai@suse.de> wrote:
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
> you who already sent.  One thing I find uncertain is whether this
> breaks the current logic completely, namely:
>

Maybe that vague memory relates to me asking about this code a while
ago. I never sent any patch though because I couldn't figure out what
the correct behaviour should be. Hats off to Julian for fixing it,
this is a step on the way to get the Asus U7 fully working.

>> @@ -715,15 +715,16 @@ static int check_input_term(struct mixer_build *state, int id,
>>                               term->name = d->iTerminal;
>>                       } else { /* UAC_VERSION_2 */
>>                               struct uac2_input_terminal_descriptor *d = p1;
>> -                             term->type = le16_to_cpu(d->wTerminalType);
>> -                             term->channels = d->bNrChannels;
>> -                             term->chconfig = le32_to_cpu(d->bmChannelConfig);
>> -                             term->name = d->iTerminal;
>>
>>                               /* call recursively to get the clock selectors */
>>                               err = check_input_term(state, d->bCSourceID, term);
>>                               if (err < 0)
>>                                       return err;
>> +
>> +                             term->type = le16_to_cpu(d->wTerminalType);
>> +                             term->channels = d->bNrChannels;
>> +                             term->chconfig = le32_to_cpu(d->bmChannelConfig);
>> +                             term->name = d->iTerminal;
>
> ... by this override, essentially all fields except for id are
> restored.  Then what's the point to call check_input_term() for the
> clock source?
>
> Maybe Daniel can answer better how the original code is supposed to
> work.  Daniel?
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
