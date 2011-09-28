From: Ryan Mallon <rmallon@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: Add BUG() assertion if max98088_get_channel
 returns -EINVAL
Date: Thu, 29 Sep 2011 09:15:03 +1000
Message-ID: <4E83AA77.9040700@gmail.com>
References: <1317218471.8008.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317218471.8008.3.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Peter Hsiang <peter.hsiang@maxim-ic.com>, Jesse Marroquin <jesse.marroquin@maxim-ic.com>
List-Id: alsa-devel@alsa-project.org

On 29/09/11 00:01, Axel Lin wrote:
> The callers use the return value of max98088_get_channel as array index to
> access max98088->dai[] array.
> Add BUG() assertion for out of bound access of max98088->dai[] array.

BUG() is pretty heavy handed for a driver. Why not fix the problem
properly in the callers?

----
Check the return value of max98088_get_channel in the callers and
propagate any errors up.

Signed-off-by: Ryan Mallon <rmallon@gmail.com>
---

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index ac65a2d..e07700e 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1811,6 +1811,9 @@ static int max98088_put_eq_enum(struct snd_kcontrol *kcontrol,
        struct max98088_cdata *cdata;
        int sel = ucontrol->value.integer.value[0];
 
+       if (channel < 0)
+	       return channel;
+
        cdata = &max98088->dai[channel];
 
        if (sel >= pdata->eq_cfgcnt)
@@ -1838,6 +1841,9 @@ static int max98088_get_eq_enum(struct snd_kcontrol *kcontrol,
        int channel = max98088_get_channel(kcontrol->id.name);
        struct max98088_cdata *cdata;
 
+       if (channel < 0)
+	       return channel;
+
        cdata = &max98088->dai[channel];
        ucontrol->value.enumerated.item[0] = cdata->eq_sel;
        return 0;
