From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 1/1] ASoC: Fix compilation error with
 davinci-sffsdr module
Date: Thu, 15 Jan 2009 15:50:52 -0700
Message-ID: <496FBDCC.7030604@boundarydevices.com>
References: <1231277025-2100-1-git-send-email-hugo@hugovil.com>	<20090106213116.GA3549@sirena.org.uk>	<20090106164120.bd2fb16b.hugo@hugovil.com>	<20090106220005.GB3549@sirena.org.uk>	<20090114155406.a086c6ef.hugo@hugovil.com>	<20090115111806.GB2147@sirena.org.uk>	<20090115145454.17178d53.hugo@hugovil.com>	<20090115200121.GH12768@sirena.org.uk>	<496FB439.1090900@boundarydevices.com>
	<20090115172818.8a216670.hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth00.csee.onr.siteprotect.com
	(smtpauth00.csee.onr.siteprotect.com [64.26.60.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 753291038B7
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 23:50:59 +0100 (CET)
In-Reply-To: <20090115172818.8a216670.hugo@hugovil.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Hugo Villeneuve wrote:
> On Thu, 15 Jan 2009 15:10:01 -0700
> Troy Kisky <troy.kisky@boundarydevices.com> wrote:
> 
>>> Hopefully a comparison of the mainline and DaVinci trees will show
>>> something...
>> In davinci-sffsdr.c I see
>>
>> 	ret = snd_soc_dai_set_fmt(cpu_dai,
>> 				  SND_SOC_DAIFMT_RIGHT_J |
>> 				  SND_SOC_DAIFMT_CBM_CFS |
>> 				  SND_SOC_DAIFMT_IB_NF);
>>
>> When I changed the evm board flags passed, I didn't change this file.
>> So, you'll need something like
>>
>> 	ret = snd_soc_dai_set_fmt(cpu_dai,
>> 				  SND_SOC_DAIFMT_DSP_A |
>> 				  SND_SOC_DAIFMT_CBM_CFS |
>> 				  SND_SOC_DAIFMT_NB_NF);
> 



Actually, that should be

 	ret = snd_soc_dai_set_fmt(cpu_dai,
 				  SND_SOC_DAIFMT_DSP_B |
 				  SND_SOC_DAIFMT_CBM_CFS |
 				  SND_SOC_DAIFMT_NB_NF);


I had dsp_a and dsp_b backwards again.


Troy
