From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 05/11] ASoC: Add helper functions to cast
 from DAPM context to CODEC/platform
Date: Fri, 6 Jun 2014 11:17:26 +0530
Message-ID: <20140606054725.GZ21128@intel.com>
References: <1400415858-11025-1-git-send-email-lars@metafoo.de>
 <1400415858-11025-6-git-send-email-lars@metafoo.de>
 <538397D6.4080105@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 25B6026171D
 for <alsa-devel@alsa-project.org>; Fri,  6 Jun 2014 08:05:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <538397D6.4080105@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, May 26, 2014 at 09:36:54PM +0200, Lars-Peter Clausen wrote:
> On 05/18/2014 02:24 PM, Lars-Peter Clausen wrote:
> >This is useful if we have a pointer to a DAPM context and know that it is a
> >CODEC or platform DAPM context and want to get a pointer to the CODEC or
> >platform.
> >
> >Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> >---
> 
> It would be nice if this one could make it into 3.16. It doesn't
> depend on any of the patches earlier in this series and I think it
> is pretty trivial. Having it in 3.16 makes it possible to use it
> after the merge window in some driver cleanup patches without having
> to do cross topic branch merges.

I think that would be a good idea. At least my driver updates are dependent on
this series and this series looks good to me. But merge window opened earlier
this week, so chances are bit slim :(

Anyway its Mark's call...

-- 
~Vinod
