From: "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
Subject: Re: [PATCH -next] ASoC: cs53l30: Fix non static symbol
	warnings
Date: Fri, 17 Jun 2016 18:53:03 +0000
Message-ID: <D389B11E.14C8F%Paul.Handrigan@cirrus.com>
References: <1466184120-13062-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id DC8FA265192
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2016 20:53:11 +0200 (CEST)
In-Reply-To: <1466184120-13062-1-git-send-email-weiyj_lk@163.com>
Content-Language: en-US
Content-ID: <D885D9038289F846AE3D1561B5923417@ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "weiyj_lk@163.com" <weiyj_lk@163.com>, "Austin, Brian" <Brian.Austin@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



On 6/17/16, 12:22 PM, "weiyj_lk@163.com" <weiyj_lk@163.com> wrote:

>From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
>Fixes the following sparse warnings:
>
>sound/soc/codecs/cs53l30.c:182:20: warning:
> symbol 'input1_sel_values' was not declared. Should it be static?
>sound/soc/codecs/cs53l30.c:202:20: warning:
> symbol 'input2_sel_values' was not declared. Should it be static?
>sound/soc/codecs/cs53l30.c:734:20: warning:
> symbol 'cs53l30_src_rates' was not declared. Should it be static?
>
>Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>---
> sound/soc/codecs/cs53l30.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
>index 714e579..a9949ad 100644
>--- a/sound/soc/codecs/cs53l30.c
>+++ b/sound/soc/codecs/cs53l30.c
>@@ -179,7 +179,7 @@ static const char * const input1_sel_text[] = {
> 	"DMIC1 Off ADC1 Off",
> };
> 
>-unsigned int const input1_sel_values[] = {
>+static unsigned int const input1_sel_values[] = {
> 	CS53L30_CH_TYPE,
> 	CS53L30_ADCxB_PDN | CS53L30_CH_TYPE,
> 	CS53L30_ADCxA_PDN | CS53L30_CH_TYPE,
>@@ -199,7 +199,7 @@ static const char * const input2_sel_text[] = {
> 	"DMIC2 Off ADC2 Off",
> };
> 
>-unsigned int const input2_sel_values[] = {
>+static unsigned int const input2_sel_values[] = {
> 	0x0,
> 	CS53L30_ADCxB_PDN,
> 	CS53L30_ADCxA_PDN,
>@@ -731,7 +731,7 @@ static int cs53l30_set_tristate(struct snd_soc_dai
>*dai, int tristate)
> 				  CS53L30_ASP_3ST_MASK, val);
> }
> 
>-unsigned int const cs53l30_src_rates[] = {
>+static unsigned int const cs53l30_src_rates[] = {
> 	8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000
> };

Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
