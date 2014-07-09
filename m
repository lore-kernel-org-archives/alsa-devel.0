From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3 v4] mfd: arizona: Export function to
	control	subsystem DVFS
Date: Wed, 9 Jul 2014 15:46:24 +0100
Message-ID: <20140709144624.GB21251@opensource.wolfsonmicro.com>
References: <1404313973-1030-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1404313973-1030-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20140709140801.GA2635@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 98A2E261A81
 for <alsa-devel@alsa-project.org>; Wed,  9 Jul 2014 16:46:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140709140801.GA2635@lee--X1>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 09, 2014 at 03:08:01PM +0100, Lee Jones wrote:
> On Wed, 02 Jul 2014, Charles Keepax wrote:
> 
> > From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> > 
> > Moving this control from being a side-effect of the LDO1
> > regulator driver to a specific exported function.
> > 
> > Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> > Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> > ---
> >  drivers/mfd/arizona-core.c       |   89 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/arizona/core.h |   12 +++++
> >  2 files changed, 101 insertions(+), 0 deletions(-)
> 
> Patch looks okay to me now.  Is it okay to apply it on its own?

The later two patches depend on it (build will break otherwise)
so it might be easiest if they all go through the same tree.

Thanks,
Charles
