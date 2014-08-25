From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3 v4 RESEND] mfd: arizona: Export
	function to control	subsystem DVFS
Date: Mon, 25 Aug 2014 11:15:23 +0100
Message-ID: <20140825101523.GA1245@opensource.wolfsonmicro.com>
References: <20140808133233.GA2665@opensource.wolfsonmicro.com>
 <20140821104051.GW4266@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 11F82264F09
 for <alsa-devel@alsa-project.org>; Mon, 25 Aug 2014 12:15:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140821104051.GW4266@lee--X1>
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
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, lgirdwood@gmail.com, tiwai@suse.de, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 21, 2014 at 11:40:51AM +0100, Lee Jones wrote:
> On Fri, 08 Aug 2014, Richard Fitzgerald wrote:
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
> If this is the same patch I reviewed before:
> 
>   Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> I guess we're just waiting for maintainer Acks before I can apply the
> set.
> 

Yes it is, and yes we are.
