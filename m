From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: atmel: test wrong variable
Date: Mon, 22 Nov 2010 20:27:07 +0000
Message-ID: <20101122202705.GA577@rakim.wolfsonmicro.main>
References: <1290361216-15166-1-git-send-email-segoon@openwall.com>
	<20101122094353.f76830b5.jhnikula@gmail.com>
	<20101122155913.GA9089@albatros>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0D8802442D
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 21:27:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101122155913.GA9089@albatros>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 22, 2010 at 06:59:13PM +0300, Vasiliy Kulikov wrote:
> After clk_get() mclk is checked second time instead of pllb check.
> In patch v1 Jarkko Nikula noticed that PTR_ERR() is also has wrong argument.
> 
> Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>

Applied, thanks.
