From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] CHROMIUM: ASoC: Tegra: Move utilities
 to separate module
Date: Fri, 25 Feb 2011 11:52:41 +0000
Message-ID: <20110225115241.GC28980@opensource.wolfsonmicro.com>
References: <1298420637-9230-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8F0ED103830
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 12:52:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1298420637-9230-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 22, 2011 at 05:23:56PM -0700, Stephen Warren wrote:
> The utilities will be required by every machine driver. Including the
> utility object directly into every machine driver causes a build failure
> if the modules are actually built into the kernel, since each will define
> the symbols exported by the utility file. Solve this by moving the
> utility object into a separate module.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Applied, thanks.
