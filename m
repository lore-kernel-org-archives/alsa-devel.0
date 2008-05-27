From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: AT32AP7000 (AVR32) + WM8510
Date: Tue, 27 May 2008 19:45:28 +0100
Message-ID: <20080527184525.GA19124@sirena.org.uk>
References: <200805221120.08815.geoffrey@pager.net>
	<200805231756.00609.geoffrey@pager.net>
	<20080526094523.GA18721@sirena.org.uk>
	<200805271016.56687.geoffrey@pager.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 912E524487
	for <alsa-devel@alsa-project.org>;
	Tue, 27 May 2008 20:45:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200805271016.56687.geoffrey@pager.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Geoffrey Wossum <geoffrey@pager.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 27, 2008 at 10:16:56AM -0500, Geoffrey Wossum wrote:

> FRAME as well as BCLK.  I might give the WM8510 a try as the master again, 
> since I can get the sample rates closer with it.

Let me know how that goes, please.

> It seems like the other CODEC drivers will eventually need to use the 
> auto-endian constants, especially if big endian microcontrollers like the 
> AVR32 catch on.

If anything offering both big endian and little endian seems best - that
will allow the host controller to offer whatever memory formats it feels
like offering.

> I'm attaching my final patch to sound/soc/codecs/wm8510.c (again, this is 
> against a 2.6.24 kernel).  I noticed that there seems to be a misprint in the 

Thanks - as I said previously it's much better if you can include a
Signed-off-by line in patch submissions in order to allow them to be
submitted to the mainline kernel, though in the case of fairly obvious
register access fixes like these it's generally not an obstacle.

> WM8510 datasheet.  Register 0x32 (SPKMIX) seems to have a different default 

> value than what is in the datasheet.  Also, the driver never configured CLKSEL 
I'll take a look.

> to run the CODEC from PLL.  I changed wm8510_set_dai_pll() to automatically 
> set CLKSEL when the PLL is started, and to clear CLKSEL when the PLL is 
> turned off.  It doesn't seem like anyone would ever configure the PLL if they 
> didn't want to use the PLL.

Yup, and that's exactly what most of our codec drivers do.  I'll apply
this fix to the driver - thanks!
