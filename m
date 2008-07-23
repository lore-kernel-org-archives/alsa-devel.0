From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add a Kconfig option to force all ASOC
	codecs to build
Date: Wed, 23 Jul 2008 21:44:11 +0100
Message-ID: <20080723204411.GC16407@opensource.wolfsonmicro.com>
References: <20080723195723.24968.88510.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 25FBD24834
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jul 2008 22:44:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080723195723.24968.88510.stgit@terra>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 23, 2008 at 03:57:23PM -0400, Jon Smirl wrote:

> +config SND_SOC_ALL_CODECS
> +	bool "Force all codecs to build"
> +	default N
> +	---help---

I already have an equivalent patch queued for merge once Takashi gets
back from holiday (done differently).
