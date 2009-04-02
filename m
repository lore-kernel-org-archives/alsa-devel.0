From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: SoC pxa2xx-ac97 + wm9705 + touchscreen
	suspend/resume
Date: Thu, 02 Apr 2009 17:13:44 +0100
Message-ID: <49D4E438.2080500@mnementh.co.uk>
References: <20090330223720.GC31396@n2100.arm.linux.org.uk>	<20090331103048.GC11800@sirena.org.uk>	<20090331183755.GA27451@n2100.arm.linux.org.uk>	<20090401192710.GH21294@sirena.org.uk>	<20090402121348.GC9522@n2100.arm.linux.org.uk>	<20090402121803.GD4527@sirena.org.uk>	<20090402123844.GD9522@n2100.arm.linux.org.uk>
	<20090402133124.GE9522@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mnementh.co.uk (mail.mnementh.co.uk [173.45.232.4])
	by alsa0.perex.cz (Postfix) with ESMTP id DB2D1103897
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 18:13:39 +0200 (CEST)
In-Reply-To: <20090402133124.GE9522@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, eric miao <eric.y.miao@gmail.com>, Mark Brown <broonie@sirena.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Russell King - ARM Linux wrote:

> And here we have the problem... using Ian's wm9705 driver, it doesn't
> implement any suspend/resume ops.  I assume Ian's e-series platforms
> aren't suspend-able.

Correct - at present.

> I now find that the board crashes inexplicably on suspend... because...
> Argh, Ian, what pile of mess have you created in wm9705?

Um no. Its correct. The core handles the init.

Anyhow, I see that you and Mark have tracked this down, nice work.

Nice to know that my codec driver has come in useful beyond my own 
e-series platform.

-Ian
