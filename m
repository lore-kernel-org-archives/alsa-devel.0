From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2 v2] ASoC: SSM2602: convert to soc-cache
Date: Sat, 26 Mar 2011 12:48:12 +0000
Message-ID: <20110326124812.GG28537@opensource.wolfsonmicro.com>
References: <1301124539-527-2-git-send-email-vapier@gentoo.org>
	<1301124975-2963-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DEA1D24431
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 13:48:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1301124975-2963-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 26, 2011 at 03:36:15AM -0400, Mike Frysinger wrote:
> From: Cliff Cai <cliff.cai@analog.com>
> 
> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

The conversion itself is good but one thing:

> +	for (i = 0; i < ARRAY_SIZE(ssm2602_reg); i++)
> +		snd_soc_write(codec, i, cache[i]);

The core cache sync stuff would be good here - that can be fixed in an
incremental patch if Liam is OK with this version.
