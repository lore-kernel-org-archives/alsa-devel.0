From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/3] ASoC: compress: Only call free for
 components which have been opened
Date: Wed, 25 Apr 2018 14:22:19 +0530
Message-ID: <20180425085219.GI6014@localhost>
References: <20180424153903.7693-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F103266CA1
 for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2018 10:47:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180424153903.7693-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 24, 2018 at 04:39:01PM +0100, Charles Keepax wrote:
> The core should only call free on a component if said component has
> already had open called on it. This is not presently the case and most
> compressed drivers in the kernel assume it will be. This causes null
> pointer dereferences in the drivers as they attempt clean up for stuff
> that was never put in place.
> 
> This is fixed by aborting calling open callbacks once a failure is
> encountered and then during clean up only iterating through the
> component list to that point.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
