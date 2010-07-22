From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH][v2] powerpc: rename immap_86xx.h to
 fsl_guts.h, and add 85xx support
Date: Thu, 22 Jul 2010 17:49:28 +0100
Message-ID: <20100722164927.GC16119@rakim.wolfsonmicro.main>
References: <1279816410-19079-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8A9CF1039B7
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 18:49:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1279816410-19079-1-git-send-email-timur@freescale.com>
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
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, kumar.gala@freescale.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 22, 2010 at 11:33:30AM -0500, Timur Tabi wrote:
> The immap_86xx.h header file only defines one data structure: the "global
> utilities" register set found on Freescale PowerPC SOCs.  Rename this file
> to fsl_guts.h to reflect its true purpose, and extend it to cover the "GUTS"
> register set on 85xx chips.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
