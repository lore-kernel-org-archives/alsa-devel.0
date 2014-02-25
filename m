From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [PATCH v4] ASoC: add RT286 CODEC driver
Date: Tue, 25 Feb 2014 14:35:43 +0000
Message-ID: <1393338943.2300.16.camel@loki>
References: <1393311589-14315-1-git-send-email-bardliao@realtek.com>
 <s5htxbnvbwa.wl%tiwai@suse.de>
 <ABFD875FF5FB574BA706497D987D48D7380472@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A2FC32655DE
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 15:35:49 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D7380472@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2014-02-25 at 08:58 +0000, Bard Liao wrote:
> > 
> > Don't include this header here.
> > The HD-audio verbs are defined in sound/hda_verbs.h in the usptream tree, so
> > include it instead.
> 
> I will modify it.
> Thanks.

Best to make sure it builds too. Can you apply the following diff for
v5:-

@@ -1131,16 +1131,16 @@ static int rt286_set_dai_sysclk(struct snd_soc_dai *dai,
 	rt286->sys_clk = freq;
 
 	return 0;
 }
 
-static int rt286_set_dai_dfs(struct snd_soc_dai *dai, unsigned int fs)
+static int rt286_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
 {
 	struct snd_soc_codec *codec = dai->codec;
 
-	dev_dbg(codec->dev, "%s fs=%d\n", __func__, fs);
-	if (50 == fs)
+	dev_dbg(codec->dev, "%s ratio=%d\n", __func__, ratio);
+	if (50 == ratio)
 		rt286_index_update_bits(codec, RT286_VENDOR_REGISTERS,
 			RT286_I2S_CTRL1, 0x1000, 0x1000);
 	else
 		rt286_index_update_bits(codec, RT286_VENDOR_REGISTERS,
 			RT286_I2S_CTRL1, 0x1000, 0x0);
@@ -1175,14 +1175,14 @@ static int rt286_set_bias_level(struct snd_soc_codec *codec,
 static irqreturn_t rt286_irq(int irq, void *data)
 {
 	struct rt286_priv *rt286 = data;
 	bool hp = false;
 	bool mic = false;
+	int status = 0;
 
 	rt286_jack_detect(rt286->codec, &hp, &mic);
 
-	int status = 0;
 	if (hp == true)
 		status |= SND_JACK_HEADPHONE;
 
 	if (mic == true)
 		status |= SND_JACK_MICROPHONE;
@@ -1257,11 +1257,11 @@ static int rt286_probe(struct snd_soc_codec *codec)
 
 struct snd_soc_dai_ops rt286_aif_dai_ops = {
 	.hw_params = rt286_hw_params,
 	.set_fmt = rt286_set_dai_fmt,
 	.set_sysclk = rt286_set_dai_sysclk,
-	.set_dfs = rt286_set_dai_dfs,
+	.set_bclk_ratio = rt286_set_bclk_ratio,
 };
 
 struct snd_soc_dai_driver rt286_dai[] = {
 	{
 	 .name = "rt286-aif1",


---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
