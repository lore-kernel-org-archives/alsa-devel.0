From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: UDA1380: DATAI is slave only
Date: Tue, 3 Mar 2009 15:50:54 +0000
Message-ID: <20090303155054.GA19642@rakim.wolfsonmicro.main>
References: <1236093054-1952-1-git-send-email-philipp.zabel@gmail.com>
	<1236093054-1952-2-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8C81110385D
	for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2009 16:50:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1236093054-1952-2-git-send-email-philipp.zabel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 03, 2009 at 04:10:52PM +0100, Philipp Zabel wrote:

> -	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) == SND_SOC_DAIFMT_CBM_CFM)
> -		iface |= R01_SIM;
> +	/* DATAI is slave only, so in single-link mode, this has to be slave */
> +	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBS_CFS)
> +		return -EINVAL;

Hrm, is R01_SIM not required to be set?  I've no idea what it does so
quite possibly.
