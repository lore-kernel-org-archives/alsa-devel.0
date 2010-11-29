From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Add missing dev_set_drvdata in
 mpc8610_hpcd_probe
Date: Mon, 29 Nov 2010 16:12:31 +0000
Message-ID: <20101129161231.GA5881@opensource.wolfsonmicro.com>
References: <1291013698.19113.1.camel@mola>
 <4CF3BE7C.2000006@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E71F7245A5
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 17:12:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4CF3BE7C.2000006@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: Axel Lin <axel.lin@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 29, 2010 at 08:53:48AM -0600, Timur Tabi wrote:
> Axel Lin wrote:
> > Otherwise, calling dev_get_drvdata in mpc8610_hpcd_remove returns NULL.
> > 
> > Signed-off-by: Axel Lin <axel.lin@gmail.com>

> Both patches:

> Acked-by: Timur Tabi <timur@freescale.com>

Applied now.
