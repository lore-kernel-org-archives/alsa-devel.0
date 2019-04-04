From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Avoid calling
 snd_compr_stop_error from WDT expiry
Date: Thu, 4 Apr 2019 15:38:13 +0100
Message-ID: <20190404143813.GC81578@ediswmail.ad.cirrus.com>
References: <20190404125601.11684-1-ckeepax@opensource.cirrus.com>
 <20190404133920.GA2803@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00BA5F80714
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2019 16:38:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190404133920.GA2803@sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 04, 2019 at 08:39:20PM +0700, Mark Brown wrote:
> On Thu, Apr 04, 2019 at 01:56:01PM +0100, Charles Keepax wrote:
> 
> > Fixes: 56bc22bd1dac ("ASoC: wm_adsp: Shutdown any compressed streams on DSP watchdog timeout")
> 
> This commit doesn't exist upstream...

Argh... sorry about that thanks for fixing it up. Took the hash
from the wrong branch.

Thanks,
Charles
