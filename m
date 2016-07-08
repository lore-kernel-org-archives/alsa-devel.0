From: "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
Subject: Re: [PATCH v2] ASoC: cs4270: fix DAPM stream name
	mismatch
Date: Fri, 8 Jul 2016 21:23:04 +0000
Message-ID: <D3A5836B.155CA%Paul.Handrigan@cirrus.com>
References: <alpine.LNX.2.00.1607020220500.27037@acc-1004367-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 5426E266A6E
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2016 23:23:07 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1607020220500.27037@acc-1004367-dev>
Content-Language: en-US
Content-ID: <7C8EE1687AB4DF4F96064989F65D20D9@ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: murray foster <mrafoster@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: "Austin, Brian" <Brian.Austin@cirrus.com>, "timur@freescale.com" <timur@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 7/2/16, 4:21 AM, "murray foster" <mrafoster@gmail.com> wrote:

>
>Mismatching stream names in DAPM route and widget definitions are
>causing compilation errors. Fixing these names allows the cs4270
>driver to compile and function.
>
>Signed-off-by: Murray Foster <mrafoster@gmail.com>
>---
>Changes in v2:
>  - Remove the 's' typo at the beginning of the codec driver.
>
> sound/soc/codecs/cs4270.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
>index e07807d..3670086 100644
>--- a/sound/soc/codecs/cs4270.c
>+++ b/sound/soc/codecs/cs4270.c
>@@ -148,11 +148,11 @@ SND_SOC_DAPM_OUTPUT("AOUTR"),
> };
>
> static const struct snd_soc_dapm_route cs4270_dapm_routes[] = {
>-	{ "Capture", NULL, "AINA" },
>-	{ "Capture", NULL, "AINB" },
>+	{ "Capture", NULL, "AINL" },
>+	{ "Capture", NULL, "AINR" },
>
>-	{ "AOUTA", NULL, "Playback" },
>-	{ "AOUTB", NULL, "Playback" },
>+	{ "AOUTL", NULL, "Playback" },
>+	{ "AOUTR", NULL, "Playback" },
> };
Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
