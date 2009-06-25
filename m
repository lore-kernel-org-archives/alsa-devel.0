From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Reg: Implementation of GSM digital audio path
Date: Thu, 25 Jun 2009 11:41:45 +0100
Message-ID: <20090625104145.GD17812@sirena.org.uk>
References: <1cbe56070906250247j30e63925k3acbff5a5a3e3df8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D607B103856
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 12:41:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1cbe56070906250247j30e63925k3acbff5a5a3e3df8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: shariff <shariffsinbox@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 25, 2009 at 03:17:54PM +0530, shariff wrote:

>         Iam working on OMAP3 based custom board. On our board, GSM digital
> audio path is connected to McBSP3 and
> TWL4030 digital audio path is connected to McBSP2.

In this scenario your GSM modem is essentially functioning as a CODEC
within ASoC.  The simplest thing to do is set up a dummy DAI in your
machine driver for the GSM modem, register that at startup and then set
up a dai_link for that as normal.  You can then address the two streams
individually as devices on the card.

The OpenMoko is doing something similar with its bluetooth chipset,
though that is connected to a second DAI on the CODEC rather than the
CPU.
