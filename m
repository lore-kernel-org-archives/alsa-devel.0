From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Fix module refcount for
	auxiliary devices
Date: Thu, 27 Jan 2011 14:23:56 +0000
Message-ID: <20110127142355.GA5123@opensource.wolfsonmicro.com>
References: <1296138262-28113-1-git-send-email-jhnikula@gmail.com>
	<1296138262-28113-2-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1D421103B1C
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 15:23:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296138262-28113-2-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 27, 2011 at 04:24:21PM +0200, Jarkko Nikula wrote:
> Commit f6c2ed5 "ASoC: Fix the device references to codec and platform drivers"
> moved codec driver refcount increments from soc_bind_dai_link into
> soc_probe_codec.
> 
> However, the commit didn't remove try_module_get from soc_probe_aux_dev so
> the auxiliary device reference counts are incremented twice as the
> soc_probe_codec is called from soc_probe_aux_dev too.

This is already applied for 2.6.38.
