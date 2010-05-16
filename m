From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 1/6] orion/kirkwood: add audio functions.
Date: Sun, 16 May 2010 18:35:23 +0100
Message-ID: <20100516173519.GE9830@opensource.wolfsonmicro.com>
References: <20100515152958.899927802@mandriva.com>
	<20100515153129.715456900@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 124EB24499
	for <alsa-devel@alsa-project.org>;
	Mon, 17 May 2010 04:44:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100515153129.715456900@mandriva.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: apatard@mandriva.com
Cc: alsa-devel@alsa-project.org, nico@fluxnic.net, saeed@marvell.com, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org, lrg@Slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sat, May 15, 2010 at 05:29:59PM +0200, apatard@mandriva.com wrote:
> This patch add audio related definitions and functions

> Signed-off-by: Arnaud Patard <apatard@mandriva.com>

This patch looks OK but obviously I'm not really reviewing the arch
side.  The CPU side ASoC drivers need do depend on this, though, so
the patches for that will need to go in through the same tree or do a
merge of some kind.  I don't know what the Orion maintainer's thoughts
are there?
