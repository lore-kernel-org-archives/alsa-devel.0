From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v2 1/3] ASoC: soc-cache: Add support for
 default readable()/volatile() functions
Date: Thu, 13 Jan 2011 13:31:12 +0000
Message-ID: <1294925472.3453.3.camel@odin>
References: <1294921238-11859-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B0033103852
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 14:31:15 +0100 (CET)
Received: by wyi11 with SMTP id 11so1688592wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 05:31:15 -0800 (PST)
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
Cc: Peter Hsiang <Peter.Hsiang@maxim-ic.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-01-13 at 12:20 +0000, Dimitris Papastamos wrote:
> For common scenarios, device drivers can provide a table of all the
> registers that are at least either readable/writable/volatile.  The idea
> is that if a register lookup fails, all of its read/write/vol members
> will be zero and will be treated as default.  This also reduces the
> size of the register access array.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

I think we may be getting to the point where we should probably look
into making this register cache functionality available to other non
ASoC I2C and SPI based drivers.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
