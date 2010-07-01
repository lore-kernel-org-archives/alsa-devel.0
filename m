From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: DaVinci: Added selection of clk
 input pin for McBSP
Date: Thu, 1 Jul 2010 15:36:38 +0100
Message-ID: <20100701143638.GD8742@rakim.wolfsonmicro.main>
References: <1277905678-4695-1-git-send-email-lamiaposta71@gmail.com>
	<1277905678-4695-3-git-send-email-lamiaposta71@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C7E9510384B
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Jul 2010 16:36:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1277905678-4695-3-git-send-email-lamiaposta71@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raffaele Recalcati <lamiaposta71@gmail.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Troy Kisky <troy.kisky@boundarydevices.com>, Davide Bonfanti <davide.bonfanti@bticino.it>, Raffaele Recalcati <raffaele.recalcati@bticino.it>, Chaithrika U S <chaithrika@ti.com>, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 30, 2010 at 03:47:57PM +0200, Raffaele Recalcati wrote:

> +	/* To be used when cpu gets clock from external pin */
> +	int clk_input_pin;
> +

As previously indicated please say how to use this.

> +		default:
> +			printk(KERN_ERR "%s:bad clk_input_pin\n", __func__);

Use dev_err().
