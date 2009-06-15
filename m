From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: About amp driver
Date: Mon, 15 Jun 2009 10:07:57 +0100
Message-ID: <20090615090756.GA6106@sirena.org.uk>
References: <4A35FE49.4090805@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C045103801
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 11:07:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A35FE49.4090805@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 15, 2009 at 04:54:49PM +0900, Joonyoung Shim wrote:

> I have one question. Currently, the amp driver of ASoC is included in machine
> driver. (ex. neo1973_wm8753 machine driver)
> I want to use the same amp driver in more than one machine driver, but then the
> same amp driver code exists double in each machine driver.

> So, how about spliting between the amp driver and the machine driver? and Is it
> possible?

Put the generic bits of the amp driver in sound/soc/codecs (there won't
be much).  At the minute you'll need to glue it in in via the machine
driver in the same way that OpenMoko does, there's not really any
support for multiple devices in the analouge part of the audio
subsystem.  This is on my radar to deal with, I have some systems where
it is relevant, but it's not there yet.
