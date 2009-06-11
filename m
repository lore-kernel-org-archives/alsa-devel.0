From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: AC97 atmel
Date: Thu, 11 Jun 2009 14:23:30 +0100
Message-ID: <20090611132330.GA1555@rakim.wolfsonmicro.main>
References: <4A30C6C6.9090205@atmel.com> <20090611130117.GE26509@sirena.org.uk>
	<20090611151125.07557a92@hcegtvedt.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1A68D103802
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Jun 2009 15:23:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090611151125.07557a92@hcegtvedt.norway.atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 11, 2009 at 03:11:25PM +0200, Hans-Christian Egtvedt wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > What is "linux ketchup"?  I'm guessing it's an Ateml tree but the main
> > thing google is turning up is a script for automatically updating patch
> > sets.

> I was under the assumption that "linux ketchup" was Linus Torvalds
> tree? At least the dw_dmac stuff went into that tree for the 2.6.30
> release.

Hrm, looking at the Kconfig in 2.6.30 the dw_dmac code has a hard
dependency on AVR32 which is probably what's causing the trouble - I
guess a patch will also be needed for that to enable AT91 support.
