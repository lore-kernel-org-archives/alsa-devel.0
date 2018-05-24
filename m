From: Shreyas NC <shreyas.nc@intel.com>
Subject: Re: [PATCH v5 1/3] ASoC: Add initial support for
 multiple CPU DAIs
Date: Thu, 24 May 2018 11:04:13 +0530
Message-ID: <20180524053411.GB4205@snc-desk>
References: <1526985623-2606-1-git-send-email-shreyas.nc@intel.com>
 <1526985623-2606-2-git-send-email-shreyas.nc@intel.com>
 <471c42d3-881f-692a-8713-a6f2c4917bd7@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id C8812267345
 for <alsa-devel@alsa-project.org>; Thu, 24 May 2018 07:35:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <471c42d3-881f-692a-8713-a6f2c4917bd7@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

> >@@ -1120,6 +1123,9 @@ struct snd_soc_pcm_runtime {
> >  	struct snd_soc_dai **codec_dais;
> >  	unsigned int num_codecs;
> >+	struct snd_soc_dai **cpu_dais;
> >+	unsigned int num_cpu_dai;
> >+
> This structure is becoming difficult to interpret:
> =

> =A0=A0=A0 struct snd_soc_dai *codec_dai;
> =A0=A0=A0 struct snd_soc_dai *cpu_dai;
> =

> =A0=A0=A0 struct snd_soc_dai **codec_dais;
> =A0=A0=A0 unsigned int num_codecs;
> =

> =A0=A0=A0 struct snd_soc_dai **cpu_dais;
> =A0=A0=A0 unsigned int num_cpu_dai;
> =

> What is the intended usage of codec_dai vs. codec_dais and cpu_dai vs.
> cpu_dais?

rtd->cpu_dai is used in many drivers to get cpu_dai from soc_pcm_runtime.
Similarly cpu_dais is addded to get multiple cpu_dais from runtime.

TBH, I have shadowed the codec_dais implementation for sake of
convenience and being conformal :)

> If this is only to handle the single codec_dai/single cpu_dai as an
> exception, should we port the code to support multiple cpu_dais/multiple
> codec_dais?
> =


As mentioned in [1] (in cover letter), there are discussions to unify cpu a=
nd
codec dais and this is the first step towards that. So, yes, eventually we
should port the code as you have suggested :)

> >  	/* close any waiting streams */
> >@@ -552,16 +565,21 @@ int snd_soc_suspend(struct device *dev)
> >  	}
> >  	list_for_each_entry(rtd, &card->rtd_list, list) {
> >-		struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
> >+		struct snd_soc_dai *cpu_dai;
> >-		if (rtd->dai_link->ignore_suspend)
> >-			continue;
> >+		for (i =3D 0; i < rtd->num_cpu_dai; i++) {
> >+			cpu_dai =3D rtd->cpu_dais[i];
> >+
> >+			if (rtd->dai_link->ignore_suspend)
> >+				continue;
> this test needs to be outside of the for loop? the 'continue' should resu=
lt
> in moving to the next element of the list, not to the next cpu_dai.
> see below, this statement is indeed outside for the resume part.

Yes, will fix this. Thanks :)

> >+static int snd_soc_init_single_cpu_dai(struct snd_soc_card *card,
> >+				   struct snd_soc_dai_link *dai_link)
> >+{
> >+	if (dai_link->cpu_name || dai_link->cpu_of_node ||
> >+					dai_link->cpu_dai_name) {
> >+		dai_link->num_cpu_dai =3D 1;
> >+		dai_link->cpu_dai =3D devm_kzalloc(card->dev,
> >+				sizeof(struct snd_soc_dai_link_component),
> >+				GFP_KERNEL);
> >+
> >+		if (!dai_link->cpu_dai)
> >+			return -ENOMEM;
> >+
> >+		dai_link->cpu_dai[0].name =3D dai_link->cpu_name;
> >+		dai_link->cpu_dai[0].of_node =3D dai_link->cpu_of_node;
> >+		dai_link->cpu_dai[0].dai_name =3D dai_link->cpu_dai_name;
> >+	} else if (!dai_link->cpu_dai) {
> >+		dev_err(card->dev, "ASoC: DAI link has no DAIs\n");
> >+		return -EINVAL;
> >+	}
> >+
> >+	return 0;
> >+}
> >+
> >  static int soc_init_dai_link(struct snd_soc_card *card,
> >  				   struct snd_soc_dai_link *link)
> >  {
> >@@ -1054,6 +1128,12 @@ static int soc_init_dai_link(struct snd_soc_card =
*card,
> >  		return ret;
> >  	}
> >+	ret =3D snd_soc_init_single_cpu_dai(card, link);
> >+	if (ret) {
> >+		dev_err(card->dev, "ASoC: failed to init cpu\n");
> >+		return ret;
> >+	}
> >+
> >  	for (i =3D 0; i < link->num_codecs; i++) {
> >  		/*
> >  		 * Codec must be specified by 1 of name or OF node,
> >@@ -1089,24 +1169,28 @@ static int soc_init_dai_link(struct snd_soc_card=
 *card,
> >  	 * can be left unspecified, and will be matched based on DAI
> >  	 * name alone..
> >  	 */
> >-	if (link->cpu_name && link->cpu_of_node) {
> >-		dev_err(card->dev,
> >-			"ASoC: Neither/both cpu name/of_node are set for %s\n",
> >-			link->name);
> >-		return -EINVAL;
> >-	}
> >-	/*
> >-	 * At least one of CPU DAI name or CPU device name/node must be
> >-	 * specified
> >-	 */
> >-	if (!link->cpu_dai_name &&
> >-	    !(link->cpu_name || link->cpu_of_node)) {
> >-		dev_err(card->dev,
> >-			"ASoC: Neither cpu_dai_name nor cpu_name/of_node are set for %s\n",
> >-			link->name);
> >-		return -EINVAL;
> >-	}
> >+	for (i =3D 0; i < link->num_cpu_dai; i++) {
> >+		if (link->cpu_dai[i].name &&
> >+			link->cpu_dai[i].of_node) {
> >+			dev_err(card->dev,
> >+			    "ASoC: Neither/both cpu name/of_node are set for %s\n",
> >+					link->cpu_dai[i].name);
> >+			return -EINVAL;
> >+		}
> >+
> >+		/*
> >+		 * At least one of CPU DAI name or CPU device name/node must be
> >+		 * specified
> >+		 */
> >+		if (!link->cpu_dai[i].dai_name &&
> >+			!(link->cpu_dai[i].name || link->cpu_dai[i].of_node)) {
> This doesn't seem to be the logical translation of the initial condition
> based on link->cpu_name and link->cpu_of_node?
> =


pasting the code added from the function above to show the mapping b/w name,
of_node and dai_name:

		dai_link->cpu_dai[0].name =3D dai_link->cpu_name;
		dai_link->cpu_dai[0].of_node =3D dai_link->cpu_of_node;
		dai_link->cpu_dai[0].dai_name =3D dai_link->cpu_dai_name;

and the original condition was:
		if (!link->cpu_dai_name &&
			!(link->cpu_name || link->cpu_of_node)) {

So, it does look correct to me, unless I am missing something obvious :(

> >+			dev_err(card->dev,
> >+			    "ASoC: Neither cpu_dai_name nor cpu_name/of_node are set for %s\=
n",
> >+				link->name);
> >+			return -EINVAL;
> >+		}
> >+	}
> >  	return 0;
> >  }
> >@@ -1426,6 +1510,9 @@ static int soc_link_dai_widgets(struct snd_soc_car=
d *card,
> >  	if (rtd->num_codecs > 1)
> >  		dev_warn(card->dev, "ASoC: Multiple codecs not supported yet\n");
> >+	if (rtd->num_cpu_dai > 1)
> >+		dev_warn(card->dev, "ASoC: Multiple CPU DAIs not supported yet\n");
> >+
> >  	/* link the DAI widgets */
> >  	sink =3D codec_dai->playback_widget;
> >  	source =3D cpu_dai->capture_widget;
> >@@ -1460,7 +1547,6 @@ static int soc_probe_link_dais(struct snd_soc_card=
 *card,
> >  		struct snd_soc_pcm_runtime *rtd, int order)
> >  {
> >  	struct snd_soc_dai_link *dai_link =3D rtd->dai_link;
> >-	struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
> >  	int i, ret;
> >  	dev_dbg(card->dev, "ASoC: probe %s dai link %d late %d\n",
> >@@ -1469,9 +1555,11 @@ static int soc_probe_link_dais(struct snd_soc_car=
d *card,
> >  	/* set default power off timeout */
> >  	rtd->pmdown_time =3D pmdown_time;
> >-	ret =3D soc_probe_dai(cpu_dai, order);
> >-	if (ret)
> >-		return ret;
> >+	for (i =3D 0; i < rtd->num_cpu_dai; i++) {
> >+		ret =3D soc_probe_dai(rtd->cpu_dais[i], order);
> >+		if (ret)
> >+			return ret;
> >+	}
> >  	/* probe the CODEC DAI */
> >  	for (i =3D 0; i < rtd->num_codecs; i++) {
> >@@ -1507,9 +1595,13 @@ static int soc_probe_link_dais(struct snd_soc_car=
d *card,
> >  		soc_dpcm_debugfs_add(rtd);
> >  #endif
> >-	if (cpu_dai->driver->compress_new) {
> >+	if (rtd->cpu_dais[0]->driver->compress_new) {
> >+		if (rtd->num_cpu_dai > 1)
> >+			dev_warn(card->dev,
> >+				"ASoC: multi-cpu compress dais not supported");
> Not sure this is right, you could have a case where the compress dai is n=
ot
> on the cpu_dai[0]?

I am not able to comprehend that we can have multi CPU DAIS in a DAI Link
with one of the DAI being compress and the other being a PCM DAI.

Any such systems that you can think of ?

Thanks for the review!

--Shreyas

-- =
