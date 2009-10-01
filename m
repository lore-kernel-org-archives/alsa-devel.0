From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: A few fix patches for ASoC
Date: Thu, 1 Oct 2009 16:24:43 +0100
Message-ID: <20091001152442.GD29526@sirena.org.uk>
References: <s5hfxa3k327.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 51CF0244B3
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 17:24:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hfxa3k327.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 01, 2009 at 09:04:32AM +0200, Takashi Iwai wrote:

> commit c877c25170e2655d519b29e91d6c91d5d1a72a6f
> Author: Takashi Iwai <tiwai@suse.de>
> Date:   Thu Oct 1 08:33:47 2009 +0200
> 
>     ASoC: Fix dependency of CONFIG_SND_PXA2XX_SOC_IMOTE2

Hrm.  This one applies to every board which doesn't use AC97 (some will
need SPI but it's the same deal for that).  It should probably also be a
dependency on the actual I2C controller driver rather than I2C in
general since the driver isn't going to do anything if the I2C device
isn't actually able to come up, though that'd prevent people doing
strange stuff like having the I2C bus driver modular and the audio built
in.

I'll have a look at doing this properly later, though probably not
targetted at 2.6.32 since it doesn't seem to be something people hit
often.  An easier way of approaching it would be to put ifdefs into the
all CODEC drivers for their bus access, even if they only support one
bus type.  That'd keep build testing happy which I think is the main
thing here.
