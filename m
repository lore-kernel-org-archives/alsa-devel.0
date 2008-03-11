From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA Version change
Date: Tue, 11 Mar 2008 19:22:46 +0000
Message-ID: <20080311192244.GA19355@sirena.org.uk>
References: <370c08350803111130i2d4147f2q9a7345d11ccbc6c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 67A0A24396
	for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2008 20:22:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <370c08350803111130i2d4147f2q9a7345d11ccbc6c7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chris Healy <cphealy@gmail.com>
Cc: alsa-devel@alsa-project.org, cphealy@rockwellcollins.com
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 11, 2008 at 11:30:11AM -0700, Chris Healy wrote:

> Currently, I am using a 2.6.19.2 kernel with ALSA version 1.0.13.  This is
> on an i.MX31 ARM11 platform.  (This is what it came with.)  We want to use a
> codec that currently has and ASoC supported driver so it seems best that we
> move forward to a newer version of ALSA.  (1.0.14 or later has ASoC.)

If you're using i.MX31 you might want to take a look at the work going
on in the imx31 branch of:

	git://opensource.wolfsonmicro.com/linux-2.6-audioplus

This contains ASoC-v2 based support for i.MX31 systems (using the
Freescale kernel), though if you're only interested in the codec drivers
it may better to stick with mainline.
