From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Use card as parameter to exported PM
	functions
Date: Fri, 28 Jan 2011 12:44:44 +0000
Message-ID: <20110128124444.GB10350@opensource.wolfsonmicro.com>
References: <1296154616-1209-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D300C24547
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 13:44:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296154616-1209-1-git-send-email-swarren@nvidia.com>
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

On Thu, Jan 27, 2011 at 11:56:56AM -0700, Stephen Warren wrote:

> This patch reworks the exported PM functions to take the card instead of the
> dev, thus allowing machine drivers to use a custom drvdata type. The
> disadvantage is that every machine driver that does this must then implement
> something similar to the soc_suspend/resume_dev functions in this patch.

This is exactly why I didn't implement them this way - almost all
drivers are just going to want to use the exact same boilerplate pm_ops
so we don't want them having to all implement the same mapping
functions.  There's also enough callbacks from the core into the machine
drivers to mean that I'm not sure we'd need to do anything else, and
keeping things in the ASoC model is much more in the flow of pushing PM
into the core.

> An alternative might be to add a drvdata field to struct snd_soc_card,
> accompanied by snd_soc_set/get_drvdata functions.

> Another alternative would be to wrap the snd_soc_card stored in the drvdata
> within another type, and use container_of whenever the machine driver needed
> the data in the wrapper type.

Either of these would work.  The former is going to be much more
friendly for users.
