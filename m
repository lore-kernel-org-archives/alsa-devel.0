From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: question on SND_SOC_DAPM_MUX
Date: Wed, 5 Jan 2011 19:08:51 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104C119C00F@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A40C103931
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 14:40:12 +0100 (CET)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

I have linein and mic in my codec and a mux which takes these two inputs and
feeds to adc.

So I added this mux as:
static const char *sn95031_mic_texts[] = { "amic", "linein" };

static const struct soc_enum sn95031_micl_enum =
       SOC_ENUM_SINGLE(SN95031_ADCCONFIG, 1, 2, sn95031_mic_texts);

And in my dapm_widget array:
      SND_SOC_DAPM_MUX("Input MICL",
                        SND_SOC_NOPM, 0, 0, &sn95031_micl_mux_control),

I saw at few place in existing codecs that text in MUX (user selection) can be
used as path element (let me know if that's incorrect)


So I added :
  { "MIC1 Enable", "amic", "ADC Left"}

But while adding the routes it returns an error that 
"sn95031: Failed to add route ADC Left->MIC1 Enable "

Is this the right way to go about adding a mux selection?

~Vinod
