From: CAG <cag@fsk-hh.org>
Subject: Re: M-Delta Audiophile 192 (ice1724) Recording
Date: Thu, 31 Jan 2008 18:33:30 +0100
Message-ID: <47A2066A.1050202@fsk-hh.org>
References: <479DCA8C.7070209@fsk-hh.org>	<s5h7ihr4ivs.wl%tiwai@suse.de>	<47A1ECC6.6040608@fsk-hh.org>	<s5hfxwe0y3k.wl%tiwai@suse.de>	<47A2014A.1040107@fsk-hh.org>
	<s5h7ihp29eu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.nadir.org (mail.nadir.org [217.114.68.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A620243FF
	for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2008 18:35:23 +0100 (CET)
In-Reply-To: <s5h7ihp29eu.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Takashi Iwai schrieb:
> At Thu, 31 Jan 2008 18:11:38 +0100,
> CAG wrote:
>> HI,
>>
>> Takashi Iwai schrieb:
>>> At Thu, 31 Jan 2008 16:44:06 +0100,
>>> CAG wrote:
>>>> Hi,
>>>>
>>>> we ran the alsa-info.sh script to provide more information on our setup:
>>>> http://pastebin.ca/886260
>>>>
>>>> The output of /proc/asound/card0/ice1724 is at
>>>> http://pastebin.ca/884589
>>> Thanks.  One more thing - could you tell how did you test the analog
>>> recording exactly?  I just need to make sure about your test method.
>> Well, we tried with arecord, ecasound, jack & audacity, but in the 
>> alsamixer / mixer gui in kde, at capture there's just one "Multi Track 
>> Peak" without capture switch.
>>
>> What would be the best record method to test ?
> 
> Usually arecord is the best as a primary test.
> Simply run
> 	% arecord -fdat -vv somefile.wav
> To avoid any possible bugs in alsa-lib, also try
> 	% arecord -Dplughw:0 -fdat -vv somefile.wav
We will try.

> 
>>> The patch below enables AK4114, and possibly fixes some ADC setup.
>>> Give it a try.
>> Cool! we will try it this evening and give a feedback. It is a patch for 
>> 1.0.16rc2 or 1.0.15 ?
> 
> For 1.0.16rc2.  Don't forget to update alsa-lib and alsa-utils, too.

All right, but I can't find alsa-utils-1.0.16rc2.tar.bz2 on the website. 
There's just a link for 
ftp://ftp.alsa-project.org/pub/utils/alsa-utils-1.0.16rc1.tar.bz2

Do we find them anywhere else ?


Toast

> 
> 
> Takashi
