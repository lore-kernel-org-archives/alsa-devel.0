From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Cherry trail and Nau 88l24 codec
Date: Mon, 5 Dec 2016 12:10:09 -0600
Message-ID: <30f62f0d-1e3e-0839-8d85-df9e209b5cf9@linux.intel.com>
References: <CAPoeEY_Tve2TAgBqY+MqPEUGnbadYHg9Z90DQ=YQumWebfW++A@mail.gmail.com>
 <62e35b1dac6b4000beb73d857f780f04@NTHCML01B.nuvoton.com>
 <CAPoeEY8=A949-cuVwfyov2GfpQc=hAjPsDG-suXmT_TDytOKBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 22EAA266B78
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2016 19:10:11 +0100 (CET)
In-Reply-To: <CAPoeEY8=A949-cuVwfyov2GfpQc=hAjPsDG-suXmT_TDytOKBQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joseph Wang <joequant@gmail.com>, KCHSU0@nuvoton.com
Cc: alsa-devel@alsa-project.org, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

On 12/5/16 12:45 AM, Joseph Wang wrote:
>>
>> [    2.681633] snd_intel_sst: Requesting FW fw_sst_22a8.bin now...
>>
>
> Hi,
>
> This is the firmware that I am using.  Right now the problem is that I'm
> getting timeouts.  I've confirmed that the device runs fine under the
> Windows WDM Audio drivers and the Windows NAUL88 codec.  So what appears to
> be happening is that machine driver is doing something incorrectly.
>
> If you can look at
>
> https://github.com/joequant/nau8824/blob/master/linux-4.8/cht_bsw_nau8824.c

The only thing that comes to my mind and that might tie firmware with 
the machine driver is the use of this:

fmt = SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_NB_NF
				| SND_SOC_DAIFMT_CBS_CFS;

I am not aware of any other drivers using LEFT_J, why can't you use I2S 
for 2ch links?

>
> And check to see how the initialization is different than the Windows
> driver, this would be very useful.  I don't know how the device is wired,
> but I do know that it appears to work with the Cherry Trail windows
> drivers.  That being the case, I think the issue is my misinitialization
> rather than device quirk.
>
> Also to answer your other question.  I am no longer getting kernel errors
> in the codec.  I believe that at one point I was loading old versions of
> the codec, but once I did a clean build with the sources that you've
> provided me, I get no issues with the codec, and I've removed the
> workaround code.  The problems that I'm having with the firmware appear to
> arise from the machine drivers.
>
> One other thing, I was wondering if you have a Cherry Trail dev environment
> that you can test to see if you can load in my machine driver and replicate
> the firmware time outs.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
