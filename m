From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] asoc/multi-component: fsl: add support for
 disabled SSI nodes
Date: Thu, 05 Aug 2010 13:43:59 +0100
Message-ID: <1281012239.3076.112.camel@odin>
References: <1280962268-31407-1-git-send-email-timur@freescale.com>
	<20100805114215.GC13146@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 2ACCE1038CE
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 14:44:03 +0200 (CEST)
Received: by wwa36 with SMTP id 36so714568wwa.2
	for <alsa-devel@alsa-project.org>; Thu, 05 Aug 2010 05:44:02 -0700 (PDT)
In-Reply-To: <20100805114215.GC13146@rakim.wolfsonmicro.main>
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
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>, kumar.gala@freescale.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-08-05 at 12:42 +0100, Mark Brown wrote:
> On Wed, Aug 04, 2010 at 05:51:08PM -0500, Timur Tabi wrote:
> > Add support for adding "status = disabled" to an SSI node to incidate that it
> > is not wired on the board.  This replaces the not-so-intuitive previous method
> > of omitting a codec-handle property.
> > 
> > Signed-off-by: Timur Tabi <timur@freescale.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied.

Thanks

Liam
