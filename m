From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASoC: mid-x86: Add support for capture
 in machine driver
Date: Wed, 19 Jan 2011 14:24:23 +0000
Message-ID: <20110119142423.GA16328@opensource.wolfsonmicro.com>
References: <1295441221-32132-1-git-send-email-priya.harsha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3A6A5243E7
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 15:24:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1295441221-32132-1-git-send-email-priya.harsha@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harsha Priya <priya.harsha@intel.com>
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 19, 2011 at 06:17:01PM +0530, Harsha Priya wrote:

> +	/* we are using DMICs here so configure how the clock and out pin is set */
> +	snd_soc_write(codec, SN95031_DMICBUF0123, 0x85);
> +	snd_soc_write(codec, SN95031_DMICBUF45, 0x02);
> +	snd_soc_update_bits(codec, SN95031_DMICMUX, 0x7, 0x07);

This looks like something which would more normally be done with
platform data than with writes in the machine driver.
