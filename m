From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: omap: Stop DMA re enabling in
 self linkage mode
Date: Mon, 6 Dec 2010 22:47:08 +0000
Message-ID: <20101206224707.GE2862@opensource.wolfsonmicro.com>
References: <1889FA7136B567478A67D4B0F85B0CCEA4C52E81@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7C60210382A
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 23:46:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCEA4C52E81@dlee06.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 06, 2010 at 04:34:47PM -0600, Olaya, Margarita wrote:
> From: Hari Nagalla <hnagalla@ti.com>
> 
> While using self linking, there is a chance that the DMA
> has re-enabled the channel just after disabling it.
> 
> This patch stops the OMAP4 DMA re-enabling after stoping the
> DMA channel.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
