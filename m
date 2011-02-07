From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: mid-x86: Fix dependency on intel_sst
	driver
Date: Mon, 7 Feb 2011 11:26:41 +0000
Message-ID: <20110207112640.GA10564@opensource.wolfsonmicro.com>
References: <1296986748-22614-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C3A611037F3
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 12:26:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296986748-22614-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>, akpm@linux-foundation.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 06, 2011 at 03:35:48PM +0530, Koul, Vinod wrote:
> From: Vinod Koul <vinod.koul@intel.com>
> 
> Enabling medfield asoc driver causes compliation error when intel_sst
> is not selected
> ERROR: "register_sst_card" [sound/soc/mid-x86/snd-soc-sst-platform.ko]
> undefined!

Applied, thanks.
