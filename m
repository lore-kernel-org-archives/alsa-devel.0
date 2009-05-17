From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] ASoC: Add TXx9 AC link controller driver
Date: Sun, 17 May 2009 23:46:49 +0900 (JST)
Message-ID: <20090517.234649.229275666.anemo@mba.ocn.ne.jp>
References: <20090515190558.GA13050@sirena.org.uk>
	<20090516.224541.39155366.anemo@mba.ocn.ne.jp>
	<20090516142511.GB5254@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.mba.ocn.ne.jp (mba.ocn.ne.jp [122.1.235.107])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E1392444B
	for <alsa-devel@alsa-project.org>;
	Sun, 17 May 2009 16:46:54 +0200 (CEST)
In-Reply-To: <20090516142511.GB5254@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, ralf@linux-mips.org
List-Id: alsa-devel@alsa-project.org

On Sat, 16 May 2009 15:25:12 +0100, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> > Is this acceptable?  I'm not sure whether you are saying Ack or Nack
> > for this approach.
> 
> Yes, this approach is fine.  All I'm saying is that you should be
> setting up devices for the DAIs and the platform device and putting the
> resources that are common to the SoC in there and not in the device that
> is being used to use the board-specific sound driver.

Then I will update "ASoC: Add TXx9 AC link controller driver" part and
send again in a few days.  Thanks.

---
Atsushi Nemoto
