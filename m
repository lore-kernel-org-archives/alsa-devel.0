From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: mic on macbook air
Date: Mon, 27 Sep 2010 11:15:21 -0700
Message-ID: <4CA0DF39.7040206@gmail.com>
References: <1285540323.2205.11.camel@vino> <s5hvd5rxncg.wl%tiwai@suse.de>
	<4CA0C81E.5030103@gmail.com>
	<AANLkTikbkubbhOnc0hCRmWRv5H6vqQTRjE6afmmJ48t=@mail.gmail.com>
	<4CA0D537.1000209@gmail.com>
	<AANLkTi=1KbpHrTC9oNL2PPL5yTOOVbqKunVY8h-Tgf1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 02384243F6
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Sep 2010 20:15:11 +0200 (CEST)
Received: by pvg13 with SMTP id 13so1845509pvg.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2010 11:15:11 -0700 (PDT)
In-Reply-To: <AANLkTi=1KbpHrTC9oNL2PPL5yTOOVbqKunVY8h-Tgf1b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Reimundo Heluani <rheluani@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/27/2010 10:47 AM, Reimundo Heluani wrote:
> On Mon, Sep 27, 2010 at 2:32 PM, Justin P. Mattock
> <justinmattock@gmail.com>  wrote:
>> On 09/27/2010 09:40 AM, Reimundo Heluani wrote:
>>>
>>> As far as I know I wrote the only patch for macbook air 2,1 that
>>> shipped with 2.6.34 but that was for the internal speaker only. I
>>> could never get the mic going.
>>>
>>> Cheers,
>>>
>>> R.
>>
>> when doing a cat codec#0 | grep Pin on my iMac9,1
>> I can see:
>>
>> Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
>>   Pincap 0x0000373c: IN OUT HP Detect
>>   Pin Default 0x90a00110: [Fixed] Mic at Int N/A
>>   Pin-ctls: 0x24: IN VREF_80
>>
>> when doing the same for the mba1,1 I didn't see anything in there that said
>> Mic.. I'm wondering if the Mic is there, it's just not being shown when
>> doing cat codec#0 due to apple changing something with the hardware. did you
>> try different pin numbers?(even though none of the pins say Mic)
>>
>> Justin P. Mattock
>>
>
> Well, here it could just be my ignorance, but I think last year when I
> was trying, I tried all possible pins and didn't find the mic
> anywhere. Then I thought that it could be some vendor parameters on
> 0x20, but then I saw the plist file in the kext and the only thing
> they adjust is the pindefault to 0x90a00110: [Fixed] Mic at Int N/A on
> what it seems to be either pin 0x1c (which I tried) or 0x27 (which is
> nonexistent). There's a thread at the ubuntu forums with people
> running alsa on air 2,1 but I couldn't get anyone to play with
> hda-verb.
>
> Cheers,
>
> R.
>

ahh.. clears that idea up.. was wondering if that might be the case with 
that, but it's not. last I remember I went into the apple store and 
looked at the hardware settings, which seem pretty basic..

one thing I remember with the iMac, is the mic doesn't work right away 
i.e. need to toggle the Line/Mic back and forth before anything starts 
to work(which Im pretty sure you tried already), code for that is

hda_input_mux alc889A_imac91_capture_source = {

but I'm still uncertain where to find those numbers(ended up just 
guessing, and used the one that worked the best).

Justin P. Mattock
