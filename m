From: Matthew R Hurne <matt.hurne@versatile.com>
Subject: Re: no front speaker sound with ALC262
Date: Fri, 14 Mar 2008 16:54:30 -0400
Message-ID: <47DAE606.4060208@versatile.com>
References: <165af2360802221645p9fa6bb0y3a5573caa7bcdbd7@mail.gmail.com>	<47BF84BF.702@versatile.com>
	<47BF8500.1050802@versatile.com>	<7D68F908-875D-4EDE-B25D-CCBDD4E4A339@gmail.com>	<s5h1w6zvrz4.wl%tiwai@suse.de>	<E0172064-A6C6-4874-81A2-B275A0954BD4@gmail.com>	<165af2360802261519y6cdf878avf0af06c7b08db2a9@mail.gmail.com>	<s5hfxveu1cf.wl%tiwai@suse.de>	<165af2360802271016u211854b7yb5158f2dd3e718a@mail.gmail.com>	<s5hfxvds579.wl%tiwai@suse.de>
	<s5hejaxs4xa.wl%tiwai@suse.de>	<01CED47B-533E-4913-BED5-4DD6E9E86414@gmail.com>	<s5hprufpuok.wl%tiwai@suse.de>
	<F7C8EBEB-D77A-43A9-8C96-58D9C4B047E0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mustang.versatile.com (mustang.versatile.com [206.61.179.31])
	by alsa0.perex.cz (Postfix) with ESMTP id C988224526
	for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2008 21:54:30 +0100 (CET)
In-Reply-To: <F7C8EBEB-D77A-43A9-8C96-58D9C4B047E0@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Dohmen <acidjunk@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rene Dohmen wrote:
> Hi List,
> 
> I tried it with the NID's i think are connected to headphone and  
> speaker but so far no luck.
> 
> I'll have more time next friday but i was just wondering:
> Is there a way to be 100% sure that this model is a new, not  
> supported model yet?
> 
> Can you explain what numbers i can use instead of the 0x3060?
> 
> I am trying to get the datasheets of the soundsystem used, i think  
> some custom board is used tot wire up the soundcard tot the internal  
> speakers.
> 
> Thanks
> 
> Grz Rene
> 
> 
> Op Feb 29, 2008, om 5:57 PM heeft Takashi Iwai het volgende geschreven:
> 
>> Instead, ALC262 (and other Realtek codecs) has a special sequence with
>> coefficients to the vendor-defined widget.  Yes, it's a black magic.
>>
>> Try the following sequence:
>>
>> 	0x20 SET_COEF_INDEX 0x07
>> 	0x20 SET_PROC_COEF 0x3060
>>
>> 0x3060 can be different numbers like 0x3070 or 0x3050.
>> If you set a different number, reset the coef index again (i.e. always
>> call as a pair).

Rene,
   Just wanted to let you know that if you still haven't gotten sound working with the Tangent 8000S (we haven't), you should look into its counterpart.  The Tangent 8000S is really the MSI Crystal 945 barebones unit, with parts installed and optionally Windows installed.  MSI has a newer unit with identical case and external connections - the Crystal A410 .  It uses an ATI chipset, but still an ALC262 codec.  We got one in today and audio "just worked" for us!  I suspect that the BIOS on the Crystal A410 is giving ALSA the info it needs when it auto-probes the BIOS, unlike the BIOS on the Crystal 945 (Tangent 8000S).  So, you might want to check it out.  Unfortunately for us, we already have several of the Crystal 945's deployed to customers, so we still need to try and resolve the audio 
 issue with those units.

Regards,
-- 
Matthew Hurne
Versatile Systems, Inc.
717.919.9102
matthew.hurne@versatile.com
