From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/2] ASoC: cs35l36: Add support for
 Cirrus CS35L36 Amplifier
Date: Thu, 7 Feb 2019 11:54:49 +0000
Message-ID: <20190207115449.GC6336@imbe.wolfsonmicro.main>
References: <1549479996-4792-1-git-send-email-james.schulman@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id A90082673DD
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2019 12:54:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1549479996-4792-1-git-send-email-james.schulman@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Schulman <james.schulman@cirrus.com>
Cc: mark.rutland@arm.com, brian.austin@cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com, robh+dt@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 06, 2019 at 01:06:36PM -0600, James Schulman wrote:
> Add driver support for Cirrus Logic CS35L36 boosted
> speaker amplifier
> 
> Signed-off-by: James Schulman <james.schulman@cirrus.com>
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Acked-by: Brian Austin <brian.austin@cirrus.com>
> ---
>  include/sound/cs35l36.h    |   43 +
>  sound/soc/codecs/Kconfig   |    5 +
>  sound/soc/codecs/Makefile  |    2 +
>  sound/soc/codecs/cs35l36.c | 1960 ++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/cs35l36.h |  446 ++++++++++
>  5 files changed, 2456 insertions(+)
>  create mode 100644 include/sound/cs35l36.h
>  create mode 100644 sound/soc/codecs/cs35l36.c
>  create mode 100644 sound/soc/codecs/cs35l36.h
> 
> diff --git a/include/sound/cs35l36.h b/include/sound/cs35l36.h
> new file mode 100644
> index 0000000..f1cf121
> --- /dev/null
> +++ b/include/sound/cs35l36.h
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * linux/sound/cs35l36.h -- Platform data for CS35L36
> + *
> + * Copyright 2018 Cirrus Logic, Inc.
> + *
> + * Author: James Schulman <james.schulman@cirrus.com>
> + *
> + */

This isn't quite right you should still be using /* */ for the
SPDX in header files.

> diff --git a/sound/soc/codecs/cs35l36.c b/sound/soc/codecs/cs35l36.c
> new file mode 100644
> index 0000000..261bc0b
> --- /dev/null
> +++ b/sound/soc/codecs/cs35l36.c
> @@ -0,0 +1,1960 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * cs35l36.c -- CS35L36 ALSA SoC audio driver
> + *
> + * Copyright 2018 Cirrus Logic, Inc.
> + *
> + * Author: James Schulman <james.schulman@cirrus.com>
> + *
> + */

And Mark will have wanted all of this as a C++ comment.

See this patch for a good example of the advised style:

commit ba34f253711a8427d2ef29475afe406b2d6e5118
ASoC: nau8822: convert to SPDX identifiers

Thanks,
Charles
