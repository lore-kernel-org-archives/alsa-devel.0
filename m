From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] General fix for Palm27x aSoC driver
Date: Tue, 14 Apr 2009 20:50:36 +0100
Message-ID: <20090414195035.GA6902@sirena.org.uk>
References: <200904121858.42931.marek.vasut@gmail.com>
	<200904121920.15488.marek.vasut@gmail.com>
	<20090412175800.GA8209@sirena.org.uk>
	<200904122051.19335.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 617BD103876
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 21:50:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200904122051.19335.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 12, 2009 at 08:51:19PM +0200, Marek Vasut wrote:

> +static struct pxa2xx_ac97_platform_data palmld_ac97_pdata = {
> +	.reset_gpio	= 95,
> +};

The type of this will need changing to reflect the patch that got merged
for this but other than that minor point this approach is fine.
