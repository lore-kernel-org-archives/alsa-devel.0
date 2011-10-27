From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC:core:add flag ignore_pmdown_time in
	snd_soc_dai_link
Date: Thu, 27 Oct 2011 12:04:34 +0200
Message-ID: <20111027100433.GD22369@opensource.wolfsonmicro.com>
References: <1319697753-21718-1-git-send-email-ramesh.babu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 621A224671
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Oct 2011 12:04:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1319697753-21718-1-git-send-email-ramesh.babu@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ramesh.babu@linux.intel.com
Cc: peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@linux.intel.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 27, 2011 at 12:12:33PM +0530, ramesh.babu@linux.intel.com wrote:
> Resending the patch by CCing Peter
> 
> With this flag, each dai_link in machine driver can choose
> to ignore pmdown_time during DAPM shut down sequence.
> 
> If the ignore_pmdown_time is set, the DAPM for corresponding DAI
> will be executed immediately.

Applied, thanks.

Please:don't:use:this:style:when:writing:subject:lines as it's hard to
read and doesn't correspond to anything code-wise.
