From: Vipin Kumar <vipin.kumar@st.com>
Subject: Re: [PATCH V3 3/4] ASoC: SPEAr spdif_out: Add spdif
	out support
Date: Fri, 29 Jun 2012 13:05:13 +0530
Message-ID: <4FED5AB1.6030907@st.com>
References: <cover.1340862505.git.rajeev-dlh.kumar@st.com>
	<ef5b01e2bff6cb1e72db4e2d216d1a039a048e62.1340862505.git.rajeev-dlh.kumar@st.com>
	<20120628122727.GI28922@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog112.obsmtp.com (eu1sys200aog112.obsmtp.com
	[207.126.144.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A16B610BA1B
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jun 2012 09:35:22 +0200 (CEST)
In-Reply-To: <20120628122727.GI28922@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>, "tiwai@suse.de" <tiwai@suse.de>, spear-devel <spear-devel@list.st.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 6/28/2012 5:57 PM, Mark Brown wrote:
> On Thu, Jun 28, 2012 at 12:31:39PM +0530, Rajeev Kumar wrote:
>
>> +	void *io_base;
>
> Should be __iomem.  Looking at the code I suspect this might benefit
> from using regmap like Tegra, you'd save having to open code your mute
> control if nothing else.
>

OK

>> +static const struct snd_kcontrol_new spdif_out_controls[] = {
>> +	SOC_SINGLE_BOOL_EXT("SPDIF Play Mute", (unsigned long)&spdif_out_mute,
>> +			spdif_mute_get, spdif_mute_put),
>
> Should be "IEC958 Playback Switch".
>

OK

>> +int spdif_soc_dai_probe(struct snd_soc_dai *dai)
>> +{
>> +	struct snd_soc_card *card = dai->card;
>> +	struct snd_soc_pcm_runtime *rtd = card->rtd;
>> +	struct snd_soc_codec *codec = rtd->codec;
>> +
>> +	return snd_soc_add_codec_controls(codec, spdif_out_controls,
>> +				ARRAY_SIZE(spdif_out_controls));
>
> We should add a framework thing for this...
>
>> +	.ops = (struct snd_soc_dai_ops *)&spdif_out_dai_ops,
>
> Why do you need this cast?

It was a const I think

Regards
Vipin
