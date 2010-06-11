From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Remove unused header
Date: Fri, 11 Jun 2010 10:50:40 +0100
Message-ID: <1276249840.3242.0.camel@odin>
References: <20100610235348.29652.91350.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 10A73103997
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jun 2010 11:50:56 +0200 (CEST)
Received: by wwf26 with SMTP id 26so578113wwf.38
	for <alsa-devel@alsa-project.org>; Fri, 11 Jun 2010 02:50:54 -0700 (PDT)
In-Reply-To: <20100610235348.29652.91350.stgit@angua>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Herb Peyerl <hpeyerl@beer.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-06-10 at 17:54 -0600, Grant Likely wrote:
> The header contains an extern that isn't used by anything.  Remove.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Jon Smirl <jonsmirl@gmail.com>
> Cc: Herb Peyerl <hpeyerl@beer.org>
> ---
>  sound/soc/fsl/mpc5200_psc_i2s.c |    1 -
>  sound/soc/fsl/mpc5200_psc_i2s.h |   12 ------------
>  2 files changed, 0 insertions(+), 13 deletions(-)
>  delete mode 100644 sound/soc/fsl/mpc5200_psc_i2s.h

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
