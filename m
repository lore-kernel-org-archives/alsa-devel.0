From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] asoc/multi-component: mpc8610: replace
 of_device with platform_device
Date: Fri, 20 Aug 2010 10:28:53 +0100
Message-ID: <1282296533.3084.37.camel@odin>
References: <1282249618-27137-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B67A4103807
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 11:28:57 +0200 (CEST)
Received: by eyd9 with SMTP id 9so1891391eyd.38
	for <alsa-devel@alsa-project.org>; Fri, 20 Aug 2010 02:28:57 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-08-19 at 15:26 -0500, Timur Tabi wrote:
> 'struct of_device' no longer exists, and its functionality has been merged
> into platform_device.  Update the MPC8610 HPCD audio drivers (fsl_ssi, fsl_dma,
> and mpc8610_hpcd) accordingly.
> 
> Also add a #include for slab.h, which is now needed for kmalloc and kfree.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
