From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] powerpc/8610: add probing for
 individual DMA channels, not just DMA controllers
Date: Wed, 5 May 2010 12:22:08 +0100
Message-ID: <20100505112208.GD5754@opensource.wolfsonmicro.com>
References: <1272923655-31807-1-git-send-email-timur@freescale.com>
	<2928D88F-057B-498C-8A11-F7193429A90D@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 91331246AC
	for <alsa-devel@alsa-project.org>;
	Wed,  5 May 2010 13:21:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2928D88F-057B-498C-8A11-F7193429A90D@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, May 04, 2010 at 12:20:13PM -0500, Kumar Gala wrote:
> On May 3, 2010, at 4:54 PM, Timur Tabi wrote:

> > A future version of the MPC8610 HPCD's ASoC DMA driver will probe on individual
> > DMA channel nodes, so the DMA controller nodes' compatible string must be listed
> > in mpc8610_ids[] for the probe to work.
> > 
> > Also remove the "gianfar" compatible from mpc8610_ids[], since there is no
> > gianfar (or any other networking device) on the 8610.
> > 
> > Signed-off-by: Timur Tabi <timur@freescale.com>

> Acked-by: Kumar Gala <galak@kernel.crashing.org>

Just looking at the scheduling here with regard to the merge window and
the fact that this doesn't seem to hurt the existing drivers perhaps it
makes sense to merge this via the PowerPC tree immediately?
