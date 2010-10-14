From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] [v2] powerpc/85xx: add DIU support to
 the Freecale P1022DS reference board
Date: Thu, 14 Oct 2010 21:49:49 +0100
Message-ID: <20101014204949.GA14479@opensource.wolfsonmicro.com>
References: <1286480203-28227-1-git-send-email-timur@freescale.com>
	<1286480203-28227-2-git-send-email-timur@freescale.com>
	<AANLkTimWgbJ0oDsQkXxzjQ_pDxm_Vd+PJRhQJzN0BLTc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4D25C1037F7
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 22:49:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimWgbJ0oDsQkXxzjQ_pDxm_Vd+PJRhQJzN0BLTc@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur.tabi@gmail.com>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 14, 2010 at 01:21:33PM -0500, Timur Tabi wrote:
> Mark, can you pick up this patch for us?  Because it depends on
> "powerpc: rename immap_86xx.h to fsl_guts.h, and add 85xx support", it
> will break the build if we apply to powerpc-next.
> 
> You can grab the patch from http://patchwork.ozlabs.org/patch/67095/

Done, but I had to fix up what looked like an add/add conflict with
headers in the file.  Since I was editing that area of the file anyway I
also dropped the #define DEBUG as it looked like a mistake.  Please send
followup patch(es) correcting things if I messed up any of that.
