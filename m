From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [asoc-dev][RFC/PATCH 0/2] Generic DAPM
	register	modifier widget
Date: Wed, 25 Jun 2008 13:01:20 +0100
Message-ID: <1214395280.3877.61.camel@localhost.localdomain>
References: <1214394128-7062-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 297052438D
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 14:01:37 +0200 (CEST)
In-Reply-To: <1214394128-7062-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2008-06-25 at 14:42 +0300, Jarkko Nikula wrote:
> Hi
> 
> At least tlv320aic3x codec has several use cases where multiple register
> bits are needed to change when widget power state changes and where
> these are not worth/safe to expose into user space. Like mic bias
> voltage.
> 
> Currently there is one use case for this multiple bit change in tlv320aic3x:
> 
> 	SND_SOC_DAPM_MICBIAS("Mic Bias AVDD", MICBIAS_CTRL, 6, 0),
> 	SND_SOC_DAPM_MICBIAS("Mic Bias AVDD", MICBIAS_CTRL, 7, 0),
> 
> There are two problems with that:
> 
> 1. Two widgets having the same name and thus snd_soc_dapm_add_route will
>    add only first one them into audio path
> 2. Even then bits aren't modified at once and thus some fault bit
>    configuration might be present while power state is changing.
> 
> So I came with this idea of generic register modifiers widget and event
> handler for it.
> 

Any chance you could also add a little text to
Docs/sound/alsa/soc/dapm.txt for this.

Thanks

Liam
