From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [v2] ASoC: cs4270: use the built-in
 register cache support
Date: Mon, 10 Jan 2011 19:13:59 +0000
Message-ID: <20110110191359.GB11265@opensource.wolfsonmicro.com>
References: <1294676990.11031.10.camel@dplaptop.localdomain>
	<4D2B34C1.7050209@freescale.com>
	<1294677365.11031.13.camel@dplaptop.localdomain>
	<4D2B4376.101@freescale.com>
	<20110110182302.GB26137@opensource.wolfsonmicro.com>
	<4D2B50FA.9060102@freescale.com>
	<20110110183615.GC26137@opensource.wolfsonmicro.com>
	<4D2B52DA.1090102@freescale.com>
	<20110110185406.GD26137@opensource.wolfsonmicro.com>
	<4D2B57FE.4090401@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C0064245BF
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 20:15:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D2B57FE.4090401@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 10, 2011 at 01:03:26PM -0600, Timur Tabi wrote:

> Well, I'm not sure I agree.  For one thing, the current code doesn't just fail
> to report I/O errors to the callers, it re-interprets an error code as valid
> date and plows right on ahead.

> In addition, there are places where getting a return code would be useful.  I
> call snd_soc_update_bits() in my probe function, so that's a great opportunity
> to tell ASoC that this device is broken and it shouldn't instantiate a sound card.

If you've got the time and enthusiasm to refactor the code to handle
this better feel free to do so; practically speaking it's not a big deal
- I/O rarely fails in production, and when it does fail there's
generally something terribly wrong with the hardware anyway.
