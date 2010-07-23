From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH][v2] powerpc: rename immap_86xx.h to
 fsl_guts.h, and add 85xx support
Date: Fri, 23 Jul 2010 19:10:28 +0100
Message-ID: <1279908628.3076.1.camel@odin>
References: <1279816410-19079-1-git-send-email-timur@freescale.com>
	<20100722164927.GC16119@rakim.wolfsonmicro.main>
	<84CE2602-9E81-473B-8E5F-4F4AD0E07484@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 67C4F1039D4
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jul 2010 20:10:36 +0200 (CEST)
Received: by mail-ww0-f51.google.com with SMTP id 22so3204006wwb.20
	for <alsa-devel@alsa-project.org>; Fri, 23 Jul 2010 11:10:36 -0700 (PDT)
In-Reply-To: <84CE2602-9E81-473B-8E5F-4F4AD0E07484@freescale.com>
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
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-07-22 at 13:43 -0500, Kumar Gala wrote:
> On Jul 22, 2010, at 11:49 AM, Mark Brown wrote:
> 
> > On Thu, Jul 22, 2010 at 11:33:30AM -0500, Timur Tabi wrote:
> >> The immap_86xx.h header file only defines one data structure: the "global
> >> utilities" register set found on Freescale PowerPC SOCs.  Rename this file
> >> to fsl_guts.h to reflect its true purpose, and extend it to cover the "GUTS"
> >> register set on 85xx chips.
> >> 
> >> Signed-off-by: Timur Tabi <timur@freescale.com>
> > 
> > Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> Acked-by: Kumar Gala <galak@kernel.crashing.org>
> 
> - k

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
