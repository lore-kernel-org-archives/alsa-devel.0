From: <peter.ujfalusi@nokia.com>
Subject: Re: question on SND_SOC_DAPM_MUX
Date: Wed, 5 Jan 2011 19:03:09 +0000
Message-ID: <CF32F28EDF8D20468EEDCBE4975DA0272AA367@008-AM1MPN1-027.mgdnok.nokia.com>
References: <438BB0150E931F4B9CE701519A44630104C119C00F@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id BA44C2413B
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 20:07:51 +0100 (CET)
In-Reply-To: <438BB0150E931F4B9CE701519A44630104C119C00F@bgsmsx502.gar.corp.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com, alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hi
> ________________________________________
> From: alsa-devel-bounces@alsa-project.org [alsa-devel-bounces@alsa-project.org] on behalf of ext Koul, Vinod [vinod.koul@intel.com]
> Sent: Wednesday, January 05, 2011 15:38
> To: alsa-devel@alsa-project.org
> Cc: Mark Brown; Liam Girdwood
> Subject: [alsa-devel] question on SND_SOC_DAPM_MUX
> 
> Hi,
> 
> I have linein and mic in my codec and a mux which takes these two inputs and
> feeds to adc.
> 
> So I added this mux as:
> static const char *sn95031_mic_texts[] = { "amic", "linein" };
> 
> static const struct soc_enum sn95031_micl_enum =
>        SOC_ENUM_SINGLE(SN95031_ADCCONFIG, 1, 2, sn95031_mic_texts);
> 
> And in my dapm_widget array:
>       SND_SOC_DAPM_MUX("Input MICL",
>                         SND_SOC_NOPM, 0, 0, &sn95031_micl_mux_control),
> 
> I saw at few place in existing codecs that text in MUX (user selection) can be
> used as path element (let me know if that's incorrect)
> 
> 
> So I added :
>   { "MIC1 Enable", "amic", "ADC Left"}

You need to specify the route like:
  { "Input MICL", "amic", "ADC Left"}

So, if the "Input MICL" MUX is in amic position, it will connect to "ADC Left"

> But while adding the routes it returns an error that
> "sn95031: Failed to add route ADC Left->MIC1 Enable "

Since the "MIC1 Enable" widget does not have the amic route, I believe.

Peter
