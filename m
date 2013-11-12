From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH] ASoC: fsl-ssi: fix SDMA starvation
Date: Tue, 12 Nov 2013 14:24:41 +0100
Message-ID: <20131112132441.GG30263@pengutronix.de>
References: <1384255056-25673-1-git-send-email-mpa@pengutronix.de>
 <52822529.5090502@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 6C07D2616FA
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2013 14:24:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <52822529.5090502@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: alsa-devel@alsa-project.org, Juergen Beisert <jbe@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, stable@vger.kernel.org, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 12, 2013 at 06:55:05AM -0600, Timur Tabi wrote:
> Markus Pargmann wrote:
> >
> >To ensure the first edge happens after enabling the TX side of the SSI unit and
> >to trigger the SDMA unit successfully enable the CCSR_SSI_SIER_TDMAE on
> >demand only. To be sure, this patch does the same for the CCSR_SSI_SIER_RDMAE
> >(RX side) bit.
> 
> This patch impacts PowerPC as well.  Have you tested it on that platform?

No, I don't have access on PowerPC hardware, so I didn't test it on
PowerPC.

Regards,

Markus Pargmann

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
