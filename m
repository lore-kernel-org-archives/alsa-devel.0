From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 3/4] ASoC SST: add mid machine driver
Date: Tue, 28 Dec 2010 14:57:58 +0000
Message-ID: <20101228145757.GE31883@opensource.wolfsonmicro.com>
References: <1293538287-31918-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B8A721038E5
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 15:57:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1293538287-31918-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: " Koul, Vinod" <vinod.koul@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 28, 2010 at 05:41:27PM +0530,  Koul, Vinod wrote:
> From: Vinod Koul <vinod.koul@intel.com>
> 
> This patch adds the mic machine driver
> The mid machine driver glues the msic and mid_platfrom driver to form the asoc sound driver

A machine driver should be for a particular machine, describing how the
various components have been connected on that particular machine.  This
looks like you're trying to do a single machine driver for all systems.

Probably this should have some sort of name indicating that it's for use
with systems that are trying to do something using the BIOS scheme
you've got for these systems; I'd expect that if the systems get much
traction in the market you'll also end up with systems implementing
regular ASoC machine drivers too.

> +#define MONO 1
> +#define STEREO 2
> +#define MAX_CAP 5
> +#define DRIVER_NAME_MFLD "msic_audio"
> +#define DRIVER_NAME_MRST "pmic_audio"
> +#define CPU_CHIP_LINCROFT       1 /* System running lincroft */
> +#define CPU_CHIP_PENWELL        2 /* System running penwell */
> +#define MSIC_CODEC		3

Here and through most of the rest of the driver you need to namespace
stuff more.
