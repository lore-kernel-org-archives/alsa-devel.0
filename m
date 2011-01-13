From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/3] ASoC: soc-cache: Add support
	for	default readable()/volatile() functions
Date: Thu, 13 Jan 2011 14:08:55 +0000
Message-ID: <20110113140855.GB20480@sirena.org.uk>
References: <1294921238-11859-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 85DF9103AF8
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 15:08:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294921238-11859-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: Peter Hsiang <Peter.Hsiang@maxim-ic.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 13, 2011 at 12:20:36PM +0000, Dimitris Papastamos wrote:
> For common scenarios, device drivers can provide a table of all the
> registers that are at least either readable/writable/volatile.  The idea
> is that if a register lookup fails, all of its read/write/vol members
> will be zero and will be treated as default.  This also reduces the
> size of the register access array.

Applied all three, thanks.

Liam was just mentioning on IM that it might be worth looking at pulling
the cache and I/O code out of ASoC for use by other I2C/SPI based
subsystems.  I'll take a look at that.
