From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Atom: Fix message handling
 during drop stream
Date: Wed, 31 Aug 2016 15:49:05 +0530
Message-ID: <20160831101905.GX9355@localhost>
References: <1472623985-31234-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FE57266628
 for <alsa-devel@alsa-project.org>; Wed, 31 Aug 2016 12:11:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1472623985-31234-1-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Harsha Priya <harshapriya.n@intel.com>
Cc: Naveen M <naveen.m@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 30, 2016 at 11:13:05PM -0700, Harsha Priya wrote:
> If a stream is being dropped, the period_elapsed received then after
> need not be processed. Processing of the period_elapsed message causes
> a time out in drop stream response processing. This patch adds a condition
> to skip period_elapsed message processing if the stream is in INIT state.

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
