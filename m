From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: While recording from mono codec twice as much	data
	is received
Date: Thu, 16 Jul 2009 19:26:51 +0100
Message-ID: <20090716182651.GA11099@opensource.wolfsonmicro.com>
References: <COL102-W427E3B6FA3A27688387EAED0260@phx.gbl>
	<20090710092924.GH7988@sirena.org.uk>
	<COL102-W38BFFD26634F8E68389469D0270@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0BA2724731
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jul 2009 20:26:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <COL102-W38BFFD26634F8E68389469D0270@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Louis Lee <lwhlee@hotmail.com>
Cc: ALSA Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 10, 2009 at 02:53:52PM -0600, Louis Lee wrote:

> Mark, thanks again for your insights.  I believe the sample rate is
> correct.I can see it on the scope and FRAME frequency is equivalent to
> thesample rate.  I ran into a bit of a problem though.  If you are right

Yup, sounds correct.

> aboutthat each bit in the clock cycle is being recorded I think I have
> just enoughbits in my clock for stereo data.  If I reduce it though I
> run into theproblem where I don't have enough bits to clock through all
> my data. :(

I'm not sure what you mean here - do you have more bits than you have
data or is there data that you don't want to record?

> This probably seems like a complete noob question.  How exactly do I
> modify the CPU DAI to not account for each bit in the clock cycle?

The best API for this if the CPU driver supports it is set_tdm_slot()
but it does depend on what the hardware can do and what the driver
supports.  I'm afraid I'm not too familiar with i.MX2x specifics here
(or the particular BSP that you've got).
