From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: core: Add new ACCESS_TLV flag
	for	coefficient TLV controls
Date: Thu, 5 Oct 2017 09:42:20 +0100
Message-ID: <20171005084220.r2yapr6tg7hfifw2@localhost.localdomain>
References: <20171002160421.22696-1-ckeepax@opensource.cirrus.com>
 <s5hy3oqrs7q.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id EE93B2668F0
 for <alsa-devel@alsa-project.org>; Thu,  5 Oct 2017 10:42:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hy3oqrs7q.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.cirrus.com, lgirdwood@gmail.com, o-takashi@sakamocchi.jp, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 05, 2017 at 09:04:09AM +0200, Takashi Iwai wrote:
> On Mon, 02 Oct 2017 18:04:21 +0200,
> Charles Keepax wrote:
> Currently I'm open for this although ideally we may have TLV COEFF
> type for consistency as you noted.
> 

I have another patch that adds just arguing with myself over
some of the details of implementing it given the current
implementations don't use it. I will try to ping that out shortly
so we can have a look at that before the conference as well.

> Who should test the callback (whether in ASoC core or ALSA core) is
> another open question, but it's a cosmetic issue.
> 

Yeah will have a think about that thanks.

Thanks,
Charles
