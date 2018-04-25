From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/3] ASoC: Remove platform code now
 everything is componentised
Date: Wed, 25 Apr 2018 14:23:51 +0530
Message-ID: <20180425085351.GJ6014@localhost>
References: <20180424153903.7693-1-ckeepax@opensource.cirrus.com>
 <20180424153903.7693-2-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 21B88266CA1
 for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2018 10:49:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180424153903.7693-2-ckeepax@opensource.cirrus.com>
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

On Tue, Apr 24, 2018 at 04:39:02PM +0100, Charles Keepax wrote:
> As all drivers have been moved over to the new generic component
> code remove the now unused platform specific code.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  include/sound/soc.h      | 103 +--------------------
>  sound/soc/soc-compress.c | 227 ++---------------------------------------------

For compress:

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
