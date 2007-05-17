From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: Newbie questions regarding ALSA drivers
Date: Thu, 17 May 2007 16:07:25 +0100
Message-ID: <1179414445.29525.65.camel@a10072.wolfsonmicro.main>
References: <61445c750705170721l4180dce2tbaea1081c9e7d47f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id D40F824482
	for <alsa-devel@alsa-project.org>;
	Thu, 17 May 2007 17:07:27 +0200 (CEST)
In-Reply-To: <61445c750705170721l4180dce2tbaea1081c9e7d47f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2007-05-17 at 19:51 +0530, Pharaoh . wrote:
> Hi,
> I am very new to ALSA and just trying to get familier with the things, I
> have
> got few questions.
> 
> 1. Is it true that all the OSS drivers are included only in directory
> linux/sound/oss  and no where else?

Afaik, mostly yes. I've seen some in other places, although they were
never official.

> 2. There are arch specific folders like ARM, MIPS etc, so all the drivers in
> these folders are ALSA or OSS?

ALSA

> 3. If I write a new driver for an OMAP based board, it should go in to
> linux/sound/arm/omap/ right? Or only ALSA drivers for this board should go
> there?

It could either go in linux/sound/arm or you could write a more generic
omap driver (i.e. not tightly coupled to either your board or codec) and
place it in sound/soc/omap/, this would allow your work to be used on
other boards/platforms.


> 4. I have some old OSS drivers
> which were written for my board, do I need to make them ALSA drivers
> to be in line with the latest trend i.e. phasing out OSS drivers?

Yes, I would recommend this.

Liam
