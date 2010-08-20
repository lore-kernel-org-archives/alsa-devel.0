From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] asoc/multi-component: mpc8610: replace
	of_device with platform_device
Date: Fri, 20 Aug 2010 07:43:57 -0500
Message-ID: <1E324AB3-D941-4FB8-896E-97227A0CBCE7@freescale.com>
References: <1282249618-27137-1-git-send-email-timur@freescale.com>
	<20100820094113.GB13668@rakim.wolfsonmicro.main>
Mime-Version: 1.0 (iPad Mail 7B405)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by alsa0.perex.cz (Postfix) with ESMTP id 3E97F103817
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 14:42:50 +0200 (CEST)
Received: from mail27-tx2 (localhost.localdomain [127.0.0.1])	by
	mail27-tx2-R.bigfish.com (Postfix) with ESMTP id 4D23C14856C	for
	<alsa-devel@alsa-project.org>; Fri, 20 Aug 2010 12:42:46 +0000 (UTC)
Received: from TX2EHSMHS023.bigfish.com (unknown [10.9.14.240])	by
	mail27-tx2.bigfish.com (Postfix) with ESMTP id 0D6EEA7804C	for
	<alsa-devel@alsa-project.org>; Fri, 20 Aug 2010 12:42:45 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o7KCgVtd013804	for
	<alsa-devel@alsa-project.org>; Fri, 20 Aug 2010 05:42:43 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o7KCtpFI011277	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 07:55:51 -0500 (CDT)
In-Reply-To: <20100820094113.GB13668@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

I based it off the for-2.6.37 branch, so it has to apply as is.  Can you tell me where the conflict is?

On Aug 20, 2010, at 4:41 AM, "Mark Brown" <broonie@opensource.wolfsonmicro.com> wrote:

> On Thu, Aug 19, 2010 at 03:26:58PM -0500, Timur Tabi wrote:
>> 'struct of_device' no longer exists, and its functionality has been merged
>> into platform_device.  Update the MPC8610 HPCD audio drivers (fsl_ssi, fsl_dma,
>> and mpc8610_hpcd) accordingly.
>> 
>> Also add a #include for slab.h, which is now needed for kmalloc and kfree.
>> 
>> Signed-off-by: Timur Tabi <timur@freescale.com>
> 
> This doesn't apply against current for-2.6.37 (presumably as a result of
> the merge up of 2.6.36-rc1) - could you check please?
> 
