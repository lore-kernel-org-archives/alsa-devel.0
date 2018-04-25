From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/3] ASoC: compress: Add helper functions
 for component open/free
Date: Wed, 25 Apr 2018 14:37:22 +0530
Message-ID: <20180425090722.GK6014@localhost>
References: <20180424153903.7693-1-ckeepax@opensource.cirrus.com>
 <20180424153903.7693-3-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EF3326722C
 for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2018 11:02:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180424153903.7693-3-ckeepax@opensource.cirrus.com>
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

On Tue, Apr 24, 2018 at 04:39:03PM +0100, Charles Keepax wrote:
> There are 2 loops calling open and 4 loops calling free for all the
> components on a DAI link. Factor out these loops into helper functions
> to make the code a little clearer.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
