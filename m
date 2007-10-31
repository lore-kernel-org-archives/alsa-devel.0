From: Darryl Bond <dbond@nrggos.com.au>
Subject: Re: Wyse Winterm CS5535 Driver
Date: Thu, 01 Nov 2007 08:15:57 +1000
Message-ID: <4728FE9D.5090408@nrggos.com.au>
References: <4727D576.8080907@nrggos.com.au> <s5h1wbbpumy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway.nrggos.com.au (46.37.221.203.static.comindico.com.au
	[203.221.37.46]) by alsa0.perex.cz (Postfix) with ESMTP id B0A1E2434E
	for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2007 23:16:04 +0100 (CET)
In-Reply-To: <s5h1wbbpumy.wl%tiwai@suse.de>
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



Takashi Iwai wrote:
> At Wed, 31 Oct 2007 11:08:06 +1000,
> Darryl Bond wrote:
>   
>> I have a Wyse S50 terminal that I am booting diskless. I have been 
>> trying to get sound working. The box has a cs5535 chipset.
>>
>> After much fiddling in the kernel source (2.6.22.5 <http://2.6.22.5> ) I 
>> have been able to make it work. I'm not sure if it is a cs5535 problem 
>> as the code that fixes it is in ac97_pcm.c.
>>
>> It would appear that the card is getting passed an unexpected rate. The 
>> function sound/pci/ac97/ac97_pcm.c snd_ac97_set_rate()
>> has a section:
>>  case AC97_PCM_FRONT_DAC_RATE:
>>  case AC97_PCM_LR_ADC_RATE:
>>                
>> if ((ac97->regs[AC97_EXTENDED_STATUS] & AC97_EA_VRA) == 0)      /* VRA */
>>                         if (rate != 48000 && rate != 96000)
>>                                  return -EINVAL;
>>                break;
>> If I use 'aplay wavfile' the rate passed to this function is 44100.
>> I I changethe code to:
>> if (rate != 48000 && rate != 96000 && rate != 44100)
>>
>> it plays but at a slightly incorrect rate.
>>     
>
> Apparently your codec doesn't support VRA, so it cannot work except
> for 48kHz (or 96kHz in some cases).  Usually other rates are converted
> via alsa-lib plugin.  In the recent versions, the default PCM
> "default" does such conversions automagically (unless you specify
> explicitly the non-conversion, e.g., passing the device 'hw").
>
>
> Takashi
>   
The main application I need to run (Citrix ICA client) uses OSS sound. 
It works fine with other sound cards and drivers. In this case it passes 
8000 to snd_ac97_set_rate().

Do I need to make sure that I have a recent Alsalibs? It would appear 
that I am using 1.0.10-0.
Does OSS use the alsalibs?

Darryl

__________________________________________________________________________________
                                DISCLAIMER

The contents of this electronic message and any attachments are intended only
for the addressee and may contain legally privileged, personal, sensitive or
confidential information. If you are not the intended addressee, and have
received this email, any transmission, distribution, downloading, printing or
photocopying of the contents of this message or attachments is strictly
prohibited. Any legal privilege or confidentiality attached to this message and
attachments is not waived, lost or destroyed by reason of delivery to any
person other than intended addressee. If you have received this message and
are not the intended addressee you should notify the sender by return email and
destroy all copies of the message and any attachments.  Unless expressly
attributed, the views expressed in this email do not necessarily represent the
views of the company.
