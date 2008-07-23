From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] Allow a custom ASOC machine driver
	with soc-of-simple
Date: Wed, 23 Jul 2008 11:53:37 +0100
Message-ID: <20080723105334.GC8377@sirena.org.uk>
References: <20080722235349.11648.90112.stgit@terra>
	<20080722235351.11648.56387.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 17F02244A4
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jul 2008 12:53:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080722235351.11648.56387.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 22, 2008 at 07:53:51PM -0400, Jon Smirl wrote:

> Allow a custom ASOC machine driver with soc-of-simple

As with the clocking configuration: this looks fine from an ASoC point
of view but please fix the checkpatch warnings.  However...

>  	/* Only register the device if both the codec and platform have
>  	 * been registered */
> -	if ((!of_soc->device.codec_data) || (!of_soc->platform_node))
> +	if ((!of_soc->device.codec_data) || (!of_soc->platform_node) || !machine_name)
>  		return;

...this doesn't just allow a custom machine driver, it requires that
something configures at least the machine name.  That's not a problem
from the ASoC point of view but possibly from the PowerPC side?
