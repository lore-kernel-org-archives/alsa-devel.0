From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASoC sst: Add mid machine driver
Date: Sun, 2 Jan 2011 13:47:16 +0000
Message-ID: <20110102134715.GE4935@opensource.wolfsonmicro.com>
References: <1293707593-8372-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1B31F245F4
	for <alsa-devel@alsa-project.org>; Sun,  2 Jan 2011 14:46:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1293707593-8372-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, alan@linux.intel.com, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 30, 2010 at 04:43:13PM +0530, Vinod Koul wrote:
> This patch adds the mic machine driver
> The mid machine driver glues the msic and mid_platfrom driver to form the asoc sound driver

So, this isn't actually doing any sort of interface with your BIOS or
otherwise doing anything system-specific.  If this is intended to be
a generic driver that manages the interaction with your BIOS then I'd
expect to see something like that.  If it's a driver for a specific
system then I'd expect the driver to say what it's a driver for.

Also, looking at your CODEC driver I'm not seeing anything that looks
like the handling for the three "nameless" CODEC vendors you've got -
given that you've got vendor workarounds in the code there this is
really surprising.
