From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 3/4] pxa-ssp: don't touch ssp
	registers	when stream is running
Date: Tue, 10 Mar 2009 16:41:00 +0100
Message-ID: <20090310154100.GB10574@buzzloop.caiaq.de>
References: <20090304201505.GE12183@buzzloop.caiaq.de>
	<1236197820-21022-1-git-send-email-daniel@caiaq.de>
	<1236197820-21022-2-git-send-email-daniel@caiaq.de>
	<1236197820-21022-3-git-send-email-daniel@caiaq.de>
	<20090304203350.GB10731@sirena.org.uk>
	<20090304203911.GA18917@buzzloop.caiaq.de>
	<20090304204222.GC10731@sirena.org.uk>
	<20090305102337.GB28448@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 183BB1037FC
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2009 16:41:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090305102337.GB28448@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@kernel.org>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Thu, Mar 05, 2009 at 11:23:37AM +0100, Daniel Mack wrote:
> On Wed, Mar 04, 2009 at 08:42:22PM +0000, Mark Brown wrote:
> > On Wed, Mar 04, 2009 at 09:39:11PM +0100, Daniel Mack wrote:
> > > On Wed, Mar 04, 2009 at 08:33:52PM +0000, Mark Brown wrote:
> > 
> > > > I'd expect an error to be reported here - if we needed to change the
> > > > settings and can't things could go wrong.  Ideally it'd check to see if
> > > > the DAI format was being changed and only error if it was.
> > 
> > > In my tests, pxa_ssp_set_dai_fmt() was simply called twice, once for the
> > > input, once for the ouput. Hence I believed a silent exit in such a case
> > 
> > That'll be because you weren't changing the DAI format - hence my
> > comment about only erroring if the format is changed.
> 
> Ok, that makes sense. We should probably do something silimar in
> set_hw_params() were we also currently exit silently in case of running
> streams.

Could you have a look on the patch below please - does that look better?

Thanks,
Daniel


>From b0399b4d42265313768044ab6bb5754162b70fd5 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@caiaq.de>
Date: Tue, 10 Mar 2009 16:36:58 +0100
Subject: [PATCH 2/2] pxa-ssp: don't touch registers if stream is running

In pxa_ssp_set_dai_fmt(), check whether there is anything to do at all.
If there would be but the SSP port is in use already, bail out.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Liam Girdwood <lrg@kernel.org>
---
 sound/soc/pxa/pxa-ssp.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 1b3a81c..569c0a6 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -525,6 +525,17 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	u32 sscr1;
 	u32 sspsp;
 
+	/* check if we need to change anything at all */
+	if (priv->dai_fmt == fmt)
+		return 0;
+
+	/* we can only change the settings if the port is not in use */
+	if (ssp_read_reg(ssp, SSCR0) & SSCR0_SSE) {
+		dev_err(&ssp->pdev->dev,
+			"can't change hardware dai format: stream is in use");
+		return -EINVAL;
+	}
+
 	/* reset port settings */
 	sscr0 = ssp_read_reg(ssp, SSCR0) &
 		(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
-- 
1.6.2
