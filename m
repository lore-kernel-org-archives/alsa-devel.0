From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V1 09/13] Main rewite of the mpc5200
	audio	DMA code
Date: Thu, 14 May 2009 20:14:24 +0100
Message-ID: <20090514191424.GB14067@rakim.wolfsonmicro.main>
References: <20090514015729.28145.30483.stgit@terra>
	<20090514015918.28145.19103.stgit@terra>
	<20090514105131.GG28291@sirena.org.uk>
	<9e4733910905140750g210616f6re53b731b51bf51e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4A7CF1039CD
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 21:14:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910905140750g210616f6re53b731b51bf51e8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: grant.likely@secretlab.ca, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 14, 2009 at 10:50:42AM -0400, Jon Smirl wrote:
> On Thu, May 14, 2009 at 6:51 AM, Mark Brown

> > This seems like a major and very surprising reduction in functionality.
> > Why is this required?

> I think I did this backwards. The AC97 DAI should be
> SNDRV_PCM_FMTBIT_S32_BE only and the DMA engine allow all four.

Yup, that'll work.
