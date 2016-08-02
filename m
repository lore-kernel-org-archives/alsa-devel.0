From: "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
Subject: Re: [PATCH 2/2] ASoC: cs53l30: Constify
 cs53l30_mclk_coeffs and cs53l30_mclkx_coeffs tables
Date: Tue, 2 Aug 2016 19:48:13 +0000
Message-ID: <3bddb668-09d5-4598-85f1-330aff6be240@EX3.ad.cirrus.com>
References: <1470116911-7592-2-git-send-email-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A748266739
 for <alsa-devel@alsa-project.org>; Tue,  2 Aug 2016 21:48:16 +0200 (CEST)
In-Reply-To: <1470116911-7592-2-git-send-email-axel.lin@ingics.com>
Content-Language: en-US
Content-ID: <6721CE7ED71DBD4486077EB77F29B7E3@ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "Austin,
 Brian" <Brian.Austin@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 8/2/16, 12:48 AM, "Axel Lin" <axel.lin@ingics.com> wrote:

>Signed-off-by: Axel Lin <axel.lin@ingics.com>
>---
> sound/soc/codecs/cs53l30.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
>index 227c556..b69c483 100644
>--- a/sound/soc/codecs/cs53l30.c
>+++ b/sound/soc/codecs/cs53l30.c
>@@ -466,7 +466,7 @@ struct cs53l30_mclk_div {
> 	u8 mclk_int_scale;
> };
> 
>-static struct cs53l30_mclk_div cs53l30_mclk_coeffs[] = {
>+static const struct cs53l30_mclk_div cs53l30_mclk_coeffs[] = {
> 	/* NOTE: Enable MCLK_INT_SCALE to save power. */
> 
> 	/* MCLK, Sample Rate, asp_rate, internal_fs_ratio, mclk_int_scale */
>@@ -511,7 +511,7 @@ struct cs53l30_mclkx_div {
> 	u8 mclkdiv;
> };
> 
>-static struct cs53l30_mclkx_div cs53l30_mclkx_coeffs[] = {
>+static const struct cs53l30_mclkx_div cs53l30_mclkx_coeffs[] = {
> 	{5644800,  1, CS53L30_MCLK_DIV_BY_1},
> 	{6000000,  1, CS53L30_MCLK_DIV_BY_1},
> 	{6144000,  1, CS53L30_MCLK_DIV_BY_1},

Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
