From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/10] sound/soc/nuc900/nuc900-ac97.c: add
	missing clk_put
Date: Wed, 1 Jun 2011 19:21:14 +0100
Message-ID: <20110601182114.GC16396@opensource.wolfsonmicro.com>
References: <1306948213-20767-2-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 444B11038B7
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jun 2011 20:21:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1306948213-20767-2-git-send-email-julia@diku.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia@diku.dk>
Cc: Timur Tabi <timur@freescale.com>, Wan ZongShun <mcuos.com@gmail.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org, Axel Lin <axel.lin@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 01, 2011 at 07:10:05PM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> This goto is after the call to clk_get, so it should go to the label that
> includes a call to clk_put.

Applied, thanks.  Please do try to use subject lines for your patches
consistent with the code you're submitting against.
