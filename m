From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 0/6] Convert JZ4740 to dmaengine
Date: Wed, 29 May 2013 11:31:03 +0200
Message-ID: <20130529093103.GA6426@linux-mips.org>
References: <1369341387-19147-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from git.linux-mips.org (marvin.linux-mips.org [78.24.191.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 974262619D8
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 11:31:31 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57476 "EHLO linux-mips.org"
 rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
 id S6823086Ab3E2JbbJZfhZ (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Wed, 29 May 2013 11:31:31 +0200
Content-Disposition: inline
In-Reply-To: <1369341387-19147-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Maarten ter Huurne <maarten@treewalker.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 23, 2013 at 10:36:21PM +0200, Lars-Peter Clausen wrote:

> done in 3 steps:
> 	1) Add a dmaengine driver which wraps the custom JZ4740 DMA API
> 	2) Update all users of the JZ4740 DMA API to use dmaengine instead
> 	3) Remove the custom API and move all direct hardware access to the
> 	   dmaengine driver.
> 
> The first two patches in the series also make sure that the clock of the DMA
> core is enabled.
> 
> Since the patches in this series depend on each other I'd prefer if they could
> all go through the DMA tree.

No problem - though my experience is that code for MIPS systems, including
drivers receives most testing if it lives in the MIPS git tree, less in
linux-next and barely any in in other subsystem-specific trees.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
