From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v3 5/6] core: add support for
	compress_offload
Date: Tue, 13 Dec 2011 11:59:04 +0530
Message-ID: <1323757744.1641.36.camel@vkoul-udesk3>
References: <1321951920-4363-1-git-send-email-vinod.koul@linux.intel.com>
	<1323070791-12620-6-git-send-email-vinod.koul@linux.intel.com>
	<20111213060938.GD4565@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id D8726103ABA
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 07:30:01 +0100 (CET)
In-Reply-To: <20111213060938.GD4565@opensource.wolfsonmicro.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-12-13 at 14:09 +0800, Mark Brown wrote:
> On Mon, Dec 05, 2011 at 01:09:50PM +0530, Vinod Koul wrote:
> 
> > +#include <linux/file.h>
> > +#include <linux/fs.h>
> > +#include <linux/list.h>
> > +#include <linux/mm.h>
> > +#include <linux/mutex.h>
> > +#include <linux/poll.h>
> > +#include <linux/slab.h>
> > +#include <linux/sched.h>
> > +#include <linux/uio.h>
> > +#include <linux/uaccess.h>
> 
> You need module.h in here for
> 
> > +MODULE_DESCRIPTION("ALSA Compressed offload framework");
> > +MODULE_AUTHOR("Vinod Koul <vinod.koul@linux.intel.com>");
> > +MODULE_LICENSE("GPL v2");
> 
> this stuff.
Yes, the 3.2!
Lazy me, didn't rebase this tree to 3.2 :(
Fixed now....

-- 
~Vinod
