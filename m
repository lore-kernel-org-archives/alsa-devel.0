From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/4] ASoC: compress: Only assign
	compr->ops->copy once
Date: Thu, 3 May 2018 21:58:44 +0530
Message-ID: <20180503162844.GY6014@localhost>
References: <20180426163007.5632-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 5ACC226722C
 for <alsa-devel@alsa-project.org>; Thu,  3 May 2018 18:23:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180426163007.5632-1-ckeepax@opensource.cirrus.com>
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
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, patches@opensource.cirrus.com, lgirdwood@gmail.com, vkoul@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 26, 2018 at 05:30:04PM +0100, Charles Keepax wrote:
> There are only one set of ops on the compressed stream so no need to
> reassign the copy callback repeatedly, stop after copy is seen to be
> necessary.

Except 2:

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
