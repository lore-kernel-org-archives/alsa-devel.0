From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH V2 7/9] sound:asoc: Add support for SPEAr
 ASoC machine driver.
Date: Mon, 25 Jun 2012 15:58:14 +0530
Message-ID: <4FE83D3E.1070900@st.com>
References: <cover.1340273261.git.rajeev-dlh.kumar@st.com>
	<6eb72cea276e7dc191713cff9e4a0ce8ed6b2faf.1340273261.git.rajeev-dlh.kumar@st.com>
	<20120623110113.GU4037@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog113.obsmtp.com (eu1sys200aog113.obsmtp.com
	[207.126.144.135])
	by alsa0.perex.cz (Postfix) with ESMTP id 1504910416D
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jun 2012 12:29:16 +0200 (CEST)
In-Reply-To: <20120623110113.GU4037@opensource.wolfsonmicro.com>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On 6/23/2012 4:31 PM, Mark Brown wrote:
> On Thu, Jun 21, 2012 at 03:54:55PM +0530, Rajeev Kumar wrote:
>
>> +	/* set codec DAI configuration */
>> +	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
>> +			SND_SOC_DAIFMT_CBS_CFM);
>
> You can se this in the dai_link structure rather than having to set it
> in hw_params() every time.
>

Ok, I will do that.

>> +static struct platform_driver spear_evb_driver = {
>> +       .driver = {
>> +               .name = "spear-evb",
>> +               .owner = THIS_MODULE,
>> +               .pm =&snd_soc_pm_ops,
>> +       },
>> +       .probe = spear_evb_probe,
>> +       .remove = __devexit_p(spear_evb_remove),
>> +};
>
> I'd expect to see an of_match_table in the device too given that you're
> parsing OF compatible data.  Given how simple this is I wonder if you
> can instead add DT support to the simple-card driver which Morimoto-san
> recently contributed rather than adding a new driver?
>

I am not well-versed with device-tree framework. It will take me some 
time to study and incorporate the changes. I will get back on this point 
as soon as I finish the same.

In the meanwhile can I send the V3 of rest patches which is not applied, 
namely

1. [PATCH V2 1/9] sound:asoc: Add support for spdif in Audio Codec.
2. [PATCH V2 2/9] sound:asoc: Add support for STA529 Audio Codec.
3. [PATCH V2 6/9] sound:asoc:spdif_out: Add spdif out support


>> +MODULE_ALIAS("platform:spear evb");
>
> This won't match against anything in the driver.

OK.

Best Regards
Rajeev
