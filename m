From: Tim Howe <tim.howe@cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: cs4349: Fix suspend/resume
Date: Thu, 30 Jul 2015 16:23:26 -0500
Message-ID: <alpine.DEB.2.10.1507301621520.8028@ChromiumBuilder>
References: <1437300918-4612-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m0077474.ppops.net (mx0b-001ae601.pphosted.com [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id B0F1926070C
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2015 23:23:56 +0200 (CEST)
In-Reply-To: <1437300918-4612-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Tim Howe <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org



On Sun, 19 Jul 2015, Lars-Peter Clausen wrote:

> dev_get_drvdata() will not return the snd_soc_runtime to which this CODEC
> is attached, so the current code will result in undefined behavior.
> To fix this just use regmap_update_bits(cs4349->regmap, ...) directly
> instead of snd_soc_update_bits(rtd->codec, ...).
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  sound/soc/codecs/cs4349.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
For both patches
Thank you!
Acked-by: Tim Howe <tim.howe@cirrus.com>
