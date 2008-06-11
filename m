From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH asoc-dev 1/2] ASoC: Use correct include
 file for gpiolib in N810 machine driver
Date: Wed, 11 Jun 2008 15:29:53 +0300
Message-ID: <20080611152953.0ec3b2e0.jarkko.nikula@nokia.com>
References: <1213174370-29568-1-git-send-email-jarkko.nikula@nokia.com>
	<20080611121149.GA14483@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 15E49247EB
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jun 2008 14:31:51 +0200 (CEST)
In-Reply-To: <20080611121149.GA14483@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 11 Jun 2008 13:11:50 +0100
"ext Mark Brown" <broonie@opensource.wolfsonmicro.com> wrote:

> On Wed, Jun 11, 2008 at 11:52:49AM +0300, Jarkko Nikula wrote:
> 
> >  #include <asm/arch/hardware.h>
> > -#include <asm/gpio.h>
> > +#include <linux/gpio.h>
> 
> This appears to already be done that way in ALSA git?
>
Ah, it seems that my first version of gpiolib conversion patch went into
asoc-dev and Takashi took the second correct one.

http://mailman.alsa-project.org/pipermail/alsa-devel/2008-May/007829.html
http://mailman.alsa-project.org/pipermail/alsa-devel/2008-May/007842.html

Probably this is worth to apply into asoc-dev in order to avoid merge
conflict but not queue this back?


Jarkko
