From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc/multi-component: mpc8610: replace
 of_device with platform_device
Date: Fri, 20 Aug 2010 10:41:13 +0100
Message-ID: <20100820094113.GB13668@rakim.wolfsonmicro.main>
References: <1282249618-27137-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 04D181038D1
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 11:41:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1282249618-27137-1-git-send-email-timur@freescale.com>
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
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 19, 2010 at 03:26:58PM -0500, Timur Tabi wrote:
> 'struct of_device' no longer exists, and its functionality has been merged
> into platform_device.  Update the MPC8610 HPCD audio drivers (fsl_ssi, fsl_dma,
> and mpc8610_hpcd) accordingly.
> 
> Also add a #include for slab.h, which is now needed for kmalloc and kfree.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

This doesn't apply against current for-2.6.37 (presumably as a result of
the merge up of 2.6.36-rc1) - could you check please?
