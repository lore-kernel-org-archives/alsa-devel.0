From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: soc-core: Add support for NULL
 default register caches
Date: Mon, 10 Jan 2011 16:10:52 -0600
Message-ID: <4D2B83EC.4000400@freescale.com>
References: <1294654256-1012-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 8098A244C7
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 23:11:01 +0100 (CET)
In-Reply-To: <1294654256-1012-1-git-send-email-dp@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Dimitris Papastamos wrote:
> The infrastructure for handling NULL default register maps is already
> included in the soc-cache code, just ensure that we don't try to dereference
> a NULL pointer while accessing a NULL register cache.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

Acked-by: Timur Tabi <timur@freescale.com>

This fixes the kernel panic I was seeing earlier with my CS4270 driver, but it's
not a replacement for my patch, "[v3] ASoC: cs4270: use the built-in register
cache support".

With Dimitris' patch alone, the CS4270 still has other bugs:

# cat ./devices/platform/soc-audio/playback/codec_reg
cs4270-codec.0-004f registers
 0: <no data: -5>
 1:   c3
 2:    0
 3:   30
 4:    0
 5:    0
 6:    0
 7:    0


So both patches need to be applied, however, I can't say whether Dimitris' patch
is sufficient for handling NULL default register maps, since I removed that from
my driver.

-- 
Timur Tabi
Linux kernel developer at Freescale
