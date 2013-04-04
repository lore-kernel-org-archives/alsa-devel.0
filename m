From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/3] ALSA: compress_core: Split copy into
 seperate read and write callbacks
Date: Thu, 04 Apr 2013 13:01:57 -0500
Message-ID: <515DC015.7040704@linux.intel.com>
References: <1364991209-24653-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1364991209-24653-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 328F3261646
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2013 20:02:26 +0200 (CEST)
In-Reply-To: <1364991209-24653-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

On 04/03/2013 07:13 AM, Charles Keepax wrote:
> The compress API for non-memory mapped DSPs shares a copy callback for
> both read and write, however the file operation of write passes a const
> buffer. Thus we can't maintain const correctness for the copy callback
> and support both read and write.
>
> This patch seperates the read and write callbacks in the compressed API.

Why not remove the const to make this consistent with the PCM interface?
-Pierre
