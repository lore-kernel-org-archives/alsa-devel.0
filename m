From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc/multi-component: fsl: add support for
 disabled SSI nodes
Date: Thu, 5 Aug 2010 12:42:15 +0100
Message-ID: <20100805114215.GC13146@rakim.wolfsonmicro.main>
References: <1280962268-31407-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B482D10388E
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 13:42:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1280962268-31407-1-git-send-email-timur@freescale.com>
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

On Wed, Aug 04, 2010 at 05:51:08PM -0500, Timur Tabi wrote:
> Add support for adding "status = disabled" to an SSI node to incidate that it
> is not wired on the board.  This replaces the not-so-intuitive previous method
> of omitting a codec-handle property.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
