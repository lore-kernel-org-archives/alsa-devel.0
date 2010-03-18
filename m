From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 4/4] soc-cache: let reg be AND'ed by 0xff
 instead of data buffer for 8_8 mode
Date: Thu, 18 Mar 2010 09:00:29 +0000
Message-ID: <1268902829.3773.14.camel@odin>
References: <1268900221-6833-1-git-send-email-21cnbao@gmail.com>
	<1268900221-6833-2-git-send-email-21cnbao@gmail.com>
	<1268900221-6833-3-git-send-email-21cnbao@gmail.com>
	<1268900221-6833-4-git-send-email-21cnbao@gmail.com>
	<1268900221-6833-5-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f176.google.com (mail-iw0-f176.google.com
	[209.85.223.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FC56245F8
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 10:00:33 +0100 (CET)
Received: by iwn6 with SMTP id 6so236463iwn.4
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 02:00:32 -0700 (PDT)
In-Reply-To: <1268900221-6833-5-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-03-18 at 16:17 +0800, Barry Song wrote:
> The registers for AD193X are defined as 0x800-0x810 for spi which uses 16_8 mode,
> for i2c to support AD1937, we will use 8_8 mode, only the low byte of 0x800-0x810
> is valid.
> The patch will not destory other codecs, but make soc cache interface more useful.
> 
> Signed-off-by: Barry Song <barry.song@analog.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
