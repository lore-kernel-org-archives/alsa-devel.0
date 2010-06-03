From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH 20/26] alsa: ASoC: Add JZ4740 codec
 driver
Date: Thu, 3 Jun 2010 13:03:51 +0100
Message-ID: <20100603120350.GC2762@rakim.wolfsonmicro.main>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de>
	<1275505950-17334-4-git-send-email-lars@metafoo.de>
	<4C074171.2080106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2B1D924413
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 14:03:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C074171.2080106@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 03, 2010 at 01:45:21PM +0800, Wan ZongShun wrote:

> Your all the patches have two kinds of 'WARNING:',as following:

> (1)'WARNING: line over 80 characters' and

> Please make a line less than 80 characters.

You need to apply a certain degree of taste when looking at checkpatch
warnings, particularly things like line length.  Sometimes fixing the
warning for the sake of fixing the warning makes the code uglier than it
would be with whatever the style issue that's been identified is.
