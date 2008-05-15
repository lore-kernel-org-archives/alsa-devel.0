From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH asoc-dev] ASoC: Convert N810 machine driver
 to use gpiolib
Date: Thu, 15 May 2008 09:04:10 +0300
Message-ID: <20080515090410.b28a2951.jarkko.nikula@nokia.com>
References: <1210764378-21276-1-git-send-email-jarkko.nikula@nokia.com>
	<s5hej84c34g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 93A65246E3
	for <alsa-devel@alsa-project.org>;
	Thu, 15 May 2008 08:04:05 +0200 (CEST)
In-Reply-To: <s5hej84c34g.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 14 May 2008 17:33:03 +0200
"ext Takashi Iwai" <tiwai@suse.de> wrote:

> >  #include <asm/mach-types.h>
> >  #include <asm/arch/hardware.h>
> > -#include <asm/arch/gpio.h>
> > +#include <asm/gpio.h>
> 
> Checkpatch suggests to use linux/gpio.h instead.
> Please fix and repost.
> 
Oops, that's correct, thanks for noticing. Will repost in a minute.

Jarkko
