From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v6 1/4] ALSA: compress: Replace complex if
 statement with switch
Date: Wed, 4 May 2016 16:01:48 +0100
Message-ID: <20160504150148.GD1646@localhost.localdomain>
References: <1461338126-25998-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1461338126-25998-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 11879266811
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 17:19:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1461338126-25998-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 22, 2016 at 04:15:23PM +0100, Charles Keepax wrote:
> A switch statement looks a bit cleaner than an if statement
> spread over 3 lines, as such update this to a switch.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Acked-by: Vinod Koul <vinod.koul@intel.com>
> ---

As this patch only tenuously relates to the rest of this patch
chain I have included it in a new patch chain [1], best not merge the
one from here so they don't both end up merged through different
trees.

Thanks,
Charles

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2016-May/107636.html
