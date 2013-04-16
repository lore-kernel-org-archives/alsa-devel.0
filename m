From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/7] ALSA: compress_core: Update	calc_avail
	to use cumulative values
Date: Tue, 16 Apr 2013 14:40:56 +0100
Message-ID: <20130416134045.GA32244@opensource.wolfsonmicro.com>
References: <1365703245-20738-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1365703245-20738-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130415161354.GD12436@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 668CF2625D7
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 15:41:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130415161354.GD12436@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>As I said last time these doesn't seem to generated against either Takashi's or
>Mark's public tree.
>
>As a result I am unable to apply & test this on any of the trees I work with :(
>Pls clone either of these and regenerate..

I've just git-am'd the patch no problem onto Takashi's for-next tree.
What repo & branch are you trying to apply to?
