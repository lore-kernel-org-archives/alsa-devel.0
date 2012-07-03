From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH V3 3/4] ASoC: SPEAr spdif_out: Add spdif
	out support
Date: Tue, 3 Jul 2012 09:50:26 +0530
Message-ID: <4FF2730A.4000900@st.com>
References: <cover.1340862505.git.rajeev-dlh.kumar@st.com>
	<ef5b01e2bff6cb1e72db4e2d216d1a039a048e62.1340862505.git.rajeev-dlh.kumar@st.com>
	<20120628122727.GI28922@opensource.wolfsonmicro.com>
	<4FF12AE9.6000001@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog103.obsmtp.com (eu1sys200aog103.obsmtp.com
	[207.126.144.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E5682436A
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2012 06:20:35 +0200 (CEST)
In-Reply-To: <4FF12AE9.6000001@st.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Rajeev kumar <rajeev-dlh.kumar@st.com>, "tiwai@suse.de" <tiwai@suse.de>, Vipin KUMAR <vipin.kumar@st.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On 7/2/2012 10:30 AM, Rajeev kumar wrote:
> Hello Mark,
>
> On 6/28/2012 5:57 PM, Mark Brown wrote:
>>> +int spdif_soc_dai_probe(struct snd_soc_dai *dai)
>>> > +{
>>> > + struct snd_soc_card *card = dai->card;
>>> > + struct snd_soc_pcm_runtime *rtd = card->rtd;
>>> > + struct snd_soc_codec *codec = rtd->codec;
>>> > +
>>> > + return snd_soc_add_codec_controls(codec, spdif_out_controls,
>>> > + ARRAY_SIZE(spdif_out_controls));
>> We should add a framework thing for this...
>>
>
> I was going through the simaple-card.c file and I think that the above
> is possible if we have a pointer of "snd_kcontrol_new" in
> asoc_simple_card_info structure. In this case we can pass all the
> controls from board file (arch/arm/mach-*). Please share your opinion.
>
> or,
>
> Is there any other way to do this ?
>

Waiting for your reply,

Best Regards
Rajeev

> Best Regards
> Rajeev
>
