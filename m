From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 6/8] ASoC: dapm: Implement and instantiate
 DAI widgets
Date: Wed, 22 Feb 2012 18:31:13 +0530
Message-ID: <1329915673.24656.107.camel@vkoul-udesk3>
References: <1329458170-22119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1329458170-22119-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1329468009.24656.15.camel@vkoul-udesk3>
	<1329914154.24656.95.camel@vkoul-udesk3>
	<20120222124301.GA7340@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 42C21103EE1
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 13:59:49 +0100 (CET)
In-Reply-To: <20120222124301.GA7340@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-02-22 at 12:43 +0000, Mark Brown wrote:
> Wrong, these widgets are automatically generated.
Okay, looks like I got it completely wrong.

>From the patche set I can see that now DAIs will have playback widget
and capture widget which will be turned ON, And your changes show me
that the AIF widgets you register in wm codec will now be treated as dai
widgets.
So from a codec driver, how does these two get linked, who fills the
playback_widget pointer in dais?

For a codec which has two DAIs and I register two AIFs how will you fill
the respective dia widgets in the DAIs...

-- 
~Vinod
