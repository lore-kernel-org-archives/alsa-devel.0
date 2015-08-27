From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: wm5110: Add DAPM/routing hookup
 for the ANC block
Date: Thu, 27 Aug 2015 17:04:45 +0100
Message-ID: <20150827160445.GC19411@ck-lbox>
References: <1440689466-7941-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1440689466-7941-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20150827161132.GE5313@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 78400260592
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2015 18:24:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150827161132.GE5313@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 27, 2015 at 05:11:32PM +0100, Mark Brown wrote:
> On Thu, Aug 27, 2015 at 04:31:06PM +0100, Charles Keepax wrote:
> 
> > +	switch (event) {
> > +	case SND_SOC_DAPM_POST_PMU:
> > +		val = 1 << w->shift;
> > +		break;
> > +	case SND_SOC_DAPM_PRE_PMD:
> > +		val = 1 << (w->shift + 1);
> > +	default:
> 
> It looks like there's a missing break here.

Ooops... sorry let me fix that up.

Thanks,
Charles
