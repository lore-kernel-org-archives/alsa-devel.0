From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add TXx9 AC link controller driver
Date: Sat, 16 May 2009 15:25:12 +0100
Message-ID: <20090516142511.GB5254@sirena.org.uk>
References: <20090514185945.GO28291@sirena.org.uk>
	<20090516.001202.173372394.anemo@mba.ocn.ne.jp>
	<20090515190558.GA13050@sirena.org.uk>
	<20090516.224541.39155366.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BDAC524574
	for <alsa-devel@alsa-project.org>;
	Sat, 16 May 2009 16:25:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090516.224541.39155366.anemo@mba.ocn.ne.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, ralf@linux-mips.org
List-Id: alsa-devel@alsa-project.org

On Sat, May 16, 2009 at 10:45:41PM +0900, Atsushi Nemoto wrote:

> Is this acceptable?  I'm not sure whether you are saying Ack or Nack
> for this approach.

Yes, this approach is fine.  All I'm saying is that you should be
setting up devices for the DAIs and the platform device and putting the
resources that are common to the SoC in there and not in the device that
is being used to use the board-specific sound driver.
