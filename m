From: "Murphy, Dan" <dmurphy@ti.com>
Subject: Re: [PATCH 2/2] ASoC: tas2552: Add DAPM calls for amp
	and PLL
Date: Fri, 25 Jul 2014 18:15:37 +0000
Message-ID: <00FC9A978A94B7418C33AFAE8A35ED49DA8C34@DFLE09.ent.ti.com>
References: <1405704668-8038-1-git-send-email-dmurphy@ti.com>
 <1405704668-8038-2-git-send-email-dmurphy@ti.com>
 <20140721115353.GV17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 23A662608ED
 for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2014 20:15:40 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Mark
On 07/21/2014 06:54 AM, Mark Brown wrote:

On Fri, Jul 18, 2014 at 12:31:08PM -0500, Dan Murphy wrote:



+static int tas2552_class_d_en(struct snd_soc_dapm_widget *w,
+                          struct snd_kcontrol *kcontrol, int event)
+{
+       switch (event) {
+       case SND_SOC_DAPM_PRE_PMU:
+               snd_soc_update_bits(w->codec, TAS2552_CFG_2,
+                                                TAS2552_CLASSD_EN_MASK, TAS2552_CLASSD_EN_MASK);
+               break;
+       case SND_SOC_DAPM_POST_PMD:
+               snd_soc_update_bits(w->codec, TAS2552_CFG_2,
+                                                TAS2552_CLASSD_EN_MASK, 0);
+               break;
+       }
+
+       return 0;
+}
+
+static const struct snd_soc_dapm_widget tas2552_dapm_widgets[] =
+{
+SND_SOC_DAPM_PRE("Class D Enable", tas2552_class_d_en),
+SND_SOC_DAPM_POST("Class D Disable", tas2552_class_d_en),
+SND_SOC_DAPM_POST("PLL Disable", tas2552_pll_disable),
+};



This seems broken, having to use _PRE or _POST widgets for simple
register writes (or almost anything really) should never be required and
error prone - what is this actually trying to do?  I'd expect the class
D to be a PGA or OUTPUT widget and the PLL to be a SUPPLY widget.


I need a little help here.
I am not seeing the PLL being disabled or Class D being disabled when
I am using the DAPM calls

My implementation is like this.  And I use set these widgets and audio
map in the call back functions in the struct snd_soc_codec_driver.

When I look at the registers after stream playback I see that
the TAS2552_CFG_2 register is untouched

static const struct snd_soc_dapm_widget tas2552_dapm_widgets[] =
{
SND_SOC_DAPM_AIF_IN("DAC IN", NULL, 0, SND_SOC_NOPM, 0, 0),
SND_SOC_DAPM_DAC("DAC", NULL, SND_SOC_NOPM, 0, 0),
SND_SOC_DAPM_OUT_DRV("ClassD Enable", TAS2552_CFG_2, 7, 0, NULL, 0),
SND_SOC_DAPM_OUT_DRV("ClassD Disable", TAS2552_CFG_2, 7, 1, NULL, 0),
SND_SOC_DAPM_SUPPLY("PLL Disable", TAS2552_CFG_2, 3, 1, NULL, 0),
SND_SOC_DAPM_OUTPUT("OUT")
};

static const struct snd_soc_dapm_route tas2552_audio_map[] = {
    {"DAC", NULL, "DAC IN"},
    {"ClassD Enable", NULL, "DAC"},
    {"OUT", NULL, "ClassD Enable"},
    {"ClassD Disable", NULL, "OUT"},
    {"PLL Disable", NULL, "ClassD Disable"}
};

Any information would help here

Thanks in advance

--
------------------
Dan Murphy
