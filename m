From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l35: Clear reset_gpio on the
 error path in probe
Date: Mon, 27 Mar 2017 11:04:49 -0500
Message-ID: <cd6a5b2d-8874-4adb-b940-54a11c68ef03@EX3.ad.cirrus.com>
References: <1490630067-23455-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id A825726583C
 for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2017 18:00:42 +0200 (CEST)
In-Reply-To: <1490630067-23455-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 27 Mar 2017, Charles Keepax wrote:

> The error path in probe attempts to put the device back into reset.
> Should we fail to get the reset_gpio (such as a probe defer) we will
> leave the error value in there, which the gpiod_set_value_cansleep on
> the error path will attempt to deference.
> 
> Fix this issue by clearing reset_gpio before we head into the error
> path.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
Acked-by: Brian Austin <brian.austin@cirrus.com>
