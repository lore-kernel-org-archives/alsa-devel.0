From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: Add ADAU1701 codec driver
Date: Fri, 10 Jun 2011 18:27:35 +0100
Message-ID: <20110610172734.GI26441@sirena.org.uk>
References: <1307726331-28618-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 84602103814
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 19:27:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1307726331-28618-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, device-drivers-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 10, 2011 at 07:18:49PM +0200, Lars-Peter Clausen wrote:
> This patch adds support for the Analog Devices ADAU1701 SigmaDSP.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Looks OK but one thing it'd be nice to do:

> +static unsigned int adau1701_register_size(unsigned int reg)
> +{
> +	switch (reg) {
> +	case ADAU1701_DSPCTRL:
> +	case ADAU1701_SEROCTL:
> +	case ADAU1701_AUXNPOW:
> +	case ADAU1701_OSCIPOW:
> +	case ADAU1701_DACSET:
> +		return 2;
> +	case ADAU1701_SERICTL:
> +		return 1;
> +	}
> +
> +	return 0;
> +}

I'd be happier if this complained loudly when it fell through the
switch in case something goes wrong.  You've got checks in the callers
but I'd feel safer if the log were here in case we missed a caller.

Also someone should remonstrate with the hardware designers.
