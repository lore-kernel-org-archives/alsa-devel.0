From: shariff <shariffsinbox@gmail.com>
Subject: Re: Reg: Implementation of GSM digital audio path
Date: Thu, 25 Jun 2009 16:58:18 +0530
Message-ID: <1cbe56070906250428k3303864dg425d86a6a5b1f94b@mail.gmail.com>
References: <1cbe56070906250247j30e63925k3acbff5a5a3e3df8@mail.gmail.com>
	<20090625104145.GD17812@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f200.google.com (mail-px0-f200.google.com
	[209.85.216.200])
	by alsa0.perex.cz (Postfix) with ESMTP id B4BED103856
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 13:28:19 +0200 (CEST)
Received: by pxi38 with SMTP id 38so1122079pxi.16
	for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2009 04:28:18 -0700 (PDT)
In-Reply-To: <20090625104145.GD17812@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

      Thanks for response.

      On my hardware, GSM is connected to McBSP3 not to the TWL4030 CODEC
directly. What  I have to do is Copy from McBSP3 and redirect this to

      McBSP2.


                        USB GSM chip -> McBSP3

                                                    McBSP2 -> TWL4030

        I have understood some thing from ur mail. I will study Openmoko
ASoC and I will get back to you.

        Suggest me wat else I can do?

Regards,
Shariff

On Thu, Jun 25, 2009 at 4:11 PM, Mark Brown <
broonie@opensource.wolfsonmicro.com> wrote:

> On Thu, Jun 25, 2009 at 03:17:54PM +0530, shariff wrote:
>
> >         Iam working on OMAP3 based custom board. On our board, GSM
> digital
> > audio path is connected to McBSP3 and
> > TWL4030 digital audio path is connected to McBSP2.
>
> In this scenario your GSM modem is essentially functioning as a CODEC
> within ASoC.  The simplest thing to do is set up a dummy DAI in your
> machine driver for the GSM modem, register that at startup and then set
> up a dai_link for that as normal.  You can then address the two streams
> individually as devices on the card.
>
> The OpenMoko is doing something similar with its bluetooth chipset,
> though that is connected to a second DAI on the CODEC rather than the
> CPU.
>
