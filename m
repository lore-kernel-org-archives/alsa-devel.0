From: Frank <frashman@freenet.de>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Thu, 16 Jul 2009 12:37:04 +0200
Message-ID: <4A5F02D0.5080200@freenet.de>
References: <4A5DB59B.2010407@freenet.de> <s5hvdltnfrp.wl%tiwai@suse.de>
	<4A5F016F.1030305@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout5.freenet.de (mout5.freenet.de [195.4.92.95])
	by alsa0.perex.cz (Postfix) with ESMTP id 09A59246A6
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jul 2009 12:37:08 +0200 (CEST)
In-Reply-To: <4A5F016F.1030305@freenet.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Oh sorry ... I mean ... SIDE and SURROUND (==REAR) are swapped!

Frashman schrieb:
>
>
> Takashi Iwai schrieb:
>> At Wed, 15 Jul 2009 12:55:23 +0200,
>> Frashman wrote:
>>  
>>> Hi Takashi,
>>>
>>> first of all, thank you for developing this driver.
>>> I tested it today. It works, so far.
>>>
>>> But two annoying things. As you mentioned, I got problems, if the 
>>> onboard sound modules are loaded. Then i get no sound out auf my xfi.
>>>     
>>
>> It's likely the collision of PCI device ID.
>> Some X-Fi models support both HD-audio and emu20kx-native modes.  The
>> modes are switched by some magical sequence.
>>
>> Anyway, please run alsa-info.sh with --no-upload option, and attach
>> the generated file.
>>   
> I let the kernel auto probe all sound modules and generated then the 
> alsa-info.txt
> It's attached.
>>  
>>> If I disable the loading of snd-hda-intel modules while booting, 
>>> then it works.
>>>
>>> The second problem is, that SIDE and SURROUND connectors are 
>>> interchanged. I'm absolutly sure, it works fine under windows and 
>>> the connector colors are also correct.
>>>
>>> If I run speaker-test -c8 the SIDE Speakers sounds come out of my 
>>> REAR (SURROUND) Speakers, while nothing is coming out of my rear 
>>> speakers, if i'm using speaker-test -c6
>>>     
>>
>> So, the side channels (channel 7 & 8) and the rear channels (3 & 4)
>> are swapped when running with 8 channel mode?
>>   
> The REAR and SURROUND channels are swapped in 4, 6 and 8channel mode 
> ... so they always swapped. (speaker-test)
> AND because there are swapped in 6channel mode too .... there is 
> nothing coming out of the rear channels, if I connect everything 
> right. I double checked it with windows and with cable colors.
>
>
> Sincerely,
> Frashman
>> Takashi
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>   
> ------------------------------------------------------------------------
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
