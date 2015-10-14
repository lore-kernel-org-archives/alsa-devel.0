From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: Add info callback for SX_TLV controls
Date: Wed, 14 Oct 2015 08:10:49 -0500
Message-ID: <alpine.DEB.2.10.1510140807570.10499@heelroid>
References: <1444825884-11827-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id BBEEC266052
 for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2015 15:09:46 +0200 (CEST)
In-Reply-To: <1444825884-11827-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

On Wed, 14 Oct 2015, Charles Keepax wrote:

> SX_TLV controls are intended for situations where the register behind
> the control has some non-zero value indicating the minimum gain
> and then gains increasing from there and eventually overflowing through
> zero.
> 
> Currently every CODEC implementing these controls specifies the minimum
> as the non-zero value for the minimum and the maximum as the number of
> gain settings available.
> 
> This means when the info callback subtracts the minimum value from the
> maximum value to calculate the number of gain levels available it is
> actually under reporting the available levels. This patch fixes this
> issue by adding a new snd_soc_info_volsw_sx callback that does not
> subtract the minimum value.
> 
> Fixes: 1d99f2436d0d ("ASoC: core: Rework SOC_DOUBLE_R_SX_TLV add SOC_SINGLE_SX_TLV")
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
Thank you sir!

Acked-by: Brian Austin <brian.austin@cirrus.com>
