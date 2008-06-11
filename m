From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH asoc-dev 1/2] ASoC: Use correct include
	file for gpiolib in N810 machine driver
Date: Wed, 11 Jun 2008 13:11:50 +0100
Message-ID: <20080611121149.GA14483@sirena.org.uk>
References: <1213174370-29568-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 17FE4103A1A
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jun 2008 14:11:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1213174370-29568-1-git-send-email-jarkko.nikula@nokia.com>
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

On Wed, Jun 11, 2008 at 11:52:49AM +0300, Jarkko Nikula wrote:

>  #include <asm/arch/hardware.h>
> -#include <asm/gpio.h>
> +#include <linux/gpio.h>

This appears to already be done that way in ALSA git?
