From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] crec: Always read whole number of
 fragments when length limit specified
Date: Mon, 7 Dec 2015 10:26:21 +0530
Message-ID: <20151207045621.GJ1854@localhost>
References: <1449141935-23350-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D6EC1265019
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 05:53:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1449141935-23350-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 03, 2015 at 11:25:35AM +0000, Richard Fitzgerald wrote:
> This patch removes the lines that adjusted the read size to exactly
> read to the end of the calculated length in bytes. Doing this could
> lead to invalid fragment sizes being requested which may then cause
> a read error on some codecs.
> 
> Instead we keep reading whole fragments until we have >= length bytes
> of data captured.

Applied, thanks

-- 
~Vinod
