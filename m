From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 2/5] ASoC: madera: Add common support for
 Cirrus Logic Madera codecs
Date: Mon, 27 May 2019 09:32:38 +0100
Message-ID: <20190527083238.GD28362@ediswmail.ad.cirrus.com>
References: <20190524104158.30731-1-ckeepax@opensource.cirrus.com>
 <20190524104158.30731-2-ckeepax@opensource.cirrus.com>
 <20190524145603.GE2456@sirena.org.uk>
 <2f4ab4ff-5b1e-8ef5-3ef7-8dfe413b4b95@opensource.cirrus.com>
 <ae5eee88-0b79-1e58-5812-9e46e5bf3b75@opensource.cirrus.com>
 <20190526121846.GG2456@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5FF35F8072E
 for <alsa-devel@alsa-project.org>; Mon, 27 May 2019 10:32:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190526121846.GG2456@sirena.org.uk>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, lgirdwood@gmail.com, Richard Fitzgerald <rf@opensource.cirrus.com>, robh+dt@kernel.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

On Sun, May 26, 2019 at 01:18:46PM +0100, Mark Brown wrote:
> On Fri, May 24, 2019 at 04:24:10PM +0100, Richard Fitzgerald wrote:
> > On 24/05/19 16:21, Richard Fitzgerald wrote:
> > > On 24/05/19 15:56, Mark Brown wrote:
> > > > This will delay both before and after every power up and power down.
> > > > Are you sure that makes sense?
> 
> > > I think that's correct but we can re-check with hardware people.
> > > It's not just a delay, it needs to ensure there are always a
> > > certain number of SYSCLK cycles in the hardware to avoid leaving
> > > certain state machines in limbo.
> 
> That sounds like you might want both _POST_PMU and _POST_PMD but do you
> really need the _PREs as well?

Yeah the requirement from the hardware guys was that we needed a
guard band between changing the SYSCLK state and other things
happening. So it has to happen both before and after the state of
SYSCLK changes. It is certainly far from ideal but it is what it
is.

Thanks,
Charles
