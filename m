From: Hui Wang <hui.wang@canonical.com>
Subject: Re: 2 speakers are assigned to the same DAC,
 this can't support 4.0/2.1 channles
Date: Fri, 12 Jun 2015 11:25:09 +0800
Message-ID: <557A5115.6050403@canonical.com>
References: <5576B419.5010505@canonical.com> <s5h1thlqeus.wl-tiwai@suse.de>
 <5576E994.2080300@canonical.com> <5577BAEE.50506@canonical.com>
 <s5h1thjoo14.wl-tiwai@suse.de> <s5hoakmjn6i.wl-tiwai@suse.de>
 <557A30CC.6030601@canonical.com>
 <CAN8cciZSoKXRETza1BcDPBCJcFXsVL-4kOn6fCTsGYoF8qitwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A1EC3266638
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 05:25:14 +0200 (CEST)
In-Reply-To: <CAN8cciZSoKXRETza1BcDPBCJcFXsVL-4kOn6fCTsGYoF8qitwg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 06/12/2015 09:22 AM, Raymond Yau wrote:
>>>>>>> A cleaner way would be to prepare a different badness table for the
>>>>>>> speaker, and increase the value for shared_surr.  An untested patch
> is
>>>>>>> below.
>>>>>> Got it, I will test it soon. Thanks.
>>>>>>
>>>>> Hi Takashi,
>>>>>
>>>>> Your patch can fix the problem, it works very well.
>>>> OK, good to know.  I'd like to test a bit more via hda-emu whether
>>>> this gives any ill effects.  So far, this seems fixing a few other
>>>> machines, too, so it's a good thing to have in general.
>>> This change alone results in regressions on machines that are capable
>>> of 4.0/5.1 surrounds.  For avoiding it, the badness for multi-io has
>>> to be increased as well.  It's damn sensitive.
>>>
>>> But, now I wonder now whether blindly applying this is good.  Suppose
>>> a machine with 2.1 speaker and one headphone, but the codec has only
>>> two DACs.  With this setup, now the headphone and the speaker share
>>> the same DAC, as the cost of having individual 2.1 speaker volume.
>>> Is this more useful than having individual volumes for speaker and
>>> headphone?
>> If having individual volumes for speaker and headphone (the speakers
> share the same DAC), there will be no "Front Speaker" and "Bass Speaker",
> as a result, in the userspace, pulseaudio can't regard the 2.1 channels is
> a valid profile.
> Do you mean you can still hear high frequency from the subwoofer of 92hd91
> (i.e. pulseaudio lfe filtering is much better than the band pass filter in
> 92hd91)
I don't mean we will definitely enable the lfe filter in the pulseaudio, 
if the codec has HW filter, we can disable the lfe filter in the 
pulseaudio. The problem is if we don't choose 2.1 channels, the 
pulseaudio will not feed the data to the subwoofer speaker, so there is 
no sound coming from the subwoofer speaker.

2.1 channles != enabling lfe filter.
>
> How much auddional cpu need to enable lfe filtering ?
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
