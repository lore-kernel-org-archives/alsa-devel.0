From: "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
Subject: Re: [PATCH] ASoC: cs53l30: Set idle_bias_off true
Date: Mon, 20 Jun 2016 15:35:51 +0000
Message-ID: <D38D7758.14D0B%Paul.Handrigan@cirrus.com>
References: <1466213517-18523-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id D8CE12654B7
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 17:35:53 +0200 (CEST)
In-Reply-To: <1466213517-18523-1-git-send-email-nicoleotsuka@gmail.com>
Content-Language: en-US
Content-ID: <1919694E975E7A4484A2C030BA78044E@ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "Austin, Brian" <Brian.Austin@cirrus.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



On 6/17/16, 8:31 PM, "Nicolin Chen" <nicoleotsuka@gmail.com> wrote:

>The driver is using the set_bias_level to control the power on and
>off so it should get SND_SOC_BIAS_OFF in order to proceed normal
>powering sequences. This patch enables the idle_bias_off option so
>the DAPM core will set the bias level to SND_SOC_BIAS_OFF instead
>of stopping at SND_SOC_BIAS_STANDBY.
>
>Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
>---
> sound/soc/codecs/cs53l30.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
>index a5976f3..b0a64a1 100644
>--- a/sound/soc/codecs/cs53l30.c
>+++ b/sound/soc/codecs/cs53l30.c
>@@ -879,6 +879,7 @@ static int cs53l30_codec_probe(struct snd_soc_codec
>*codec)
> static struct snd_soc_codec_driver cs53l30_driver = {
> 	.probe = cs53l30_codec_probe,
> 	.set_bias_level = cs53l30_set_bias_level,
>+	.idle_bias_off = true,
> 
> 	.dapm_widgets = cs53l30_dapm_widgets,
> 	.num_dapm_widgets = ARRAY_SIZE(cs53l30_dapm_widgets),
>-- 
>2.1.4
Thanks!

Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>


>
