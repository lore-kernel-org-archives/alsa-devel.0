From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH][tinycompress] crecord: Use whole buffer
	requested by user
Date: Thu, 19 Apr 2018 11:36:00 +0530
Message-ID: <20180419060557.GG6014@localhost>
References: <20180413115859.20310-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C8196267035
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 08:01:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180413115859.20310-1-ckeepax@opensource.cirrus.com>
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 13, 2018 at 12:58:59PM +0100, Charles Keepax wrote:
> Currently, crecord will only actually use 1 fragment worth of its
> internal buffer no matter what the user requests. Correct this so that
> the whole buffer requested by the user is used for copying data.

Applied, thanks

-- 
~Vinod
