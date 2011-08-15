From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 4/5] ASoC: add spi hw read function for
 16 addr 8 data mode
Date: Mon, 15 Aug 2011 22:37:42 +0900
Message-ID: <20110815133740.GK3927@opensource.wolfsonmicro.com>
References: <1313186654-22520-1-git-send-email-scott.jiang.linux@gmail.com>
	<1313186654-22520-4-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6E9FA2462E
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 15:37:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313186654-22520-4-git-send-email-scott.jiang.linux@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 12, 2011 at 06:04:13PM -0400, Scott Jiang wrote:
> some spi registers are 7bits global address + 1 bit r/w + 8 bits
> register address. soc cache layer can't support this kind well.
> so let codec driver read registers directly.

I have to agree with Barry, this changelog really doesn't explain what
you're doing here at all clearly.  You're adding 8, 16 read, that's it.
This could also be used for reading volatile registers like interrupt
status registers.

Stil, I've applied.
