From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: Reforming S3C I2S towards supporting I2Sv4
Date: Wed, 10 Mar 2010 09:04:07 +0000
Message-ID: <1268211847.3760.23.camel@odin>
References: <1268207335-9947-1-git-send-email-jassi.brar@samsung.com>
	<1268209468.3760.8.camel@odin>
	<1b68c6791003100031m7be14ecr218e4f988bd30cab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f220.google.com (mail-fx0-f220.google.com
	[209.85.220.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C997103821
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 10:04:12 +0100 (CET)
Received: by fxm20 with SMTP id 20so13551681fxm.32
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 01:04:12 -0800 (PST)
In-Reply-To: <1b68c6791003100031m7be14ecr218e4f988bd30cab@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-03-10 at 17:31 +0900, jassi brar wrote:
> On Wed, Mar 10, 2010 at 5:24 PM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> > On Wed, 2010-03-10 at 16:48 +0900, Jassi Brar wrote:
> >>  The header with I2S register map and bit definitions has been copied
> >> to where the drivers are(sound/soc/s3c24xx/) since the header has nothing
> >> usable for platform code. Also, it will help avoid need for co-ordination
> >> between ASoC and S3C ARCH trees. For now, the header regs-s3c2412-iis.h
> >> is left intact but rendered useless by making ASoC drivers include the
> >> newly copied version of it (sound/soc/s3c24xx/regs-i2s-v2.h) Later the
> >> header could be dropped by patches to S3C PLAT tree.
> >>
> >
> > I'm not too keen on moving CPU register and bit definitions out of ARCH.
> The header doesn't contain absolute register addresses, but only
> offsets. 

Isn't this really the same thing ?

> The base address of I2S controllers are defined in PLAT
> specific header. So, I think we can move the header.

I don't think your reason of "co-ordination between ASoC and S3C ARCH
trees" can justify breaking kernel policy.

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
