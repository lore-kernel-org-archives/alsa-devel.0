From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 1/5] ASoC: Apply msbits constraint for
 sample size bigger than the msbits
Date: Wed, 18 Jan 2012 11:34:33 +0000
Message-ID: <20120118113433.GJ8732@opensource.wolfsonmicro.com>
References: <1326885506-6140-1-git-send-email-peter.ujfalusi@ti.com>
	<1326885506-6140-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 39C45103B3C
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 12:34:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326885506-6140-2-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 18, 2012 at 12:18:22PM +0100, Peter Ujfalusi wrote:

> In order to avoid confusing the applications with msbits bigger
> than the selected sample size apply the msbits constraint only
> to sample seze bigger than the requested msbits.

>  	for (i = 0; i < ARRAY_SIZE(sample_sizes); i++) {
> +		if (sample_sizes[i] <= bits)
> +			break;

This isn't terribly legible and is the opposite test to the one in the
changelog.  A continue statement or a while loop would both be better.
