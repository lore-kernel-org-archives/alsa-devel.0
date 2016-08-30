From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Atom: Fix message handling
 during drop stream
Date: Tue, 30 Aug 2016 21:23:13 +0530
Message-ID: <20160830155313.GH9355@localhost>
References: <1472213717-19040-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id CCF64267C31
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 17:45:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1472213717-19040-1-git-send-email-harshapriya.n@intel.com>
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
Cc: Naveen M <naveen.m@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 26, 2016 at 05:15:17AM -0700, Harsha Priya wrote:
> If a stream is being dropped, the period_elapsed received then after
> need not be processed. Processing of the period_elapsed message causes
> a time out in drop stream response processing. This patch adds a condition
> to skip period_elapsed message processing if the stream is in INIT state.

Acked-by: Vinod Koul <vinod.koul@intel.com>

Harsha,

Pls CC mainatiners, in this case CC Mark & Liam. They may not see this, so I
suggest reporting.

-- 
~Vinod
