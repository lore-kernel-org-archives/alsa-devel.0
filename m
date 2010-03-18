From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] soc-cache: let reg be AND'ed by 0xff
 instead of data buffer for 8_8 mode
Date: Thu, 18 Mar 2010 11:30:54 +0000
Message-ID: <20100318113054.GE3080@opensource.wolfsonmicro.com>
References: <1268900221-6833-1-git-send-email-21cnbao@gmail.com>
	<1268900221-6833-2-git-send-email-21cnbao@gmail.com>
	<1268900221-6833-3-git-send-email-21cnbao@gmail.com>
	<1268900221-6833-4-git-send-email-21cnbao@gmail.com>
	<1268900221-6833-5-git-send-email-21cnbao@gmail.com>
	<1268902829.3773.14.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6997C24407
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 12:30:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1268902829.3773.14.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 18, 2010 at 09:00:29AM +0000, Liam Girdwood wrote:
> On Thu, 2010-03-18 at 16:17 +0800, Barry Song wrote:
> > The registers for AD193X are defined as 0x800-0x810 for spi which uses 16_8 mode,
> > for i2c to support AD1937, we will use 8_8 mode, only the low byte of 0x800-0x810
> > is valid.
> > The patch will not destory other codecs, but make soc cache interface more useful.

> > Signed-off-by: Barry Song <barry.song@analog.com>

> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Applied, thanks.
