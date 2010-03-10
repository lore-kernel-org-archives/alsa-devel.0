From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: Reforming S3C I2S towards supporting I2Sv4
Date: Wed, 10 Mar 2010 08:24:28 +0000
Message-ID: <1268209468.3760.8.camel@odin>
References: <1268207335-9947-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DB811038B0
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 09:24:33 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 4so425657qwk.56
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 00:24:32 -0800 (PST)
In-Reply-To: <1268207335-9947-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-03-10 at 16:48 +0900, Jassi Brar wrote:
> Hello,
> 
>  I have prepared some patches that debug and modify the behaviour of
> extant S3C I2S support towards managing I2Sv4 controllers as well.
> 
> Overall pic...
>  For now the 'new' I2Sv4 CPU driver(s3c64xx-i2s-v4.c) is almost a copy
> of s3c64xx-i2s.c The driver will evolve as support for more features is
> added.
>  Minor quirks in otherwise similar controllers are handled by defining
> a new field(feature) in 'struct s3c_i2sv2_info' that is meant to contain
> 1-bit flags for absence/presence of such quirks.

patches 1 - 9 Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

>  The header with I2S register map and bit definitions has been copied
> to where the drivers are(sound/soc/s3c24xx/) since the header has nothing
> usable for platform code. Also, it will help avoid need for co-ordination
> between ASoC and S3C ARCH trees. For now, the header regs-s3c2412-iis.h
> is left intact but rendered useless by making ASoC drivers include the
> newly copied version of it (sound/soc/s3c24xx/regs-i2s-v2.h) Later the
> header could be dropped by patches to S3C PLAT tree.
> 

I'm not too keen on moving CPU register and bit definitions out of ARCH.

Liam 

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
