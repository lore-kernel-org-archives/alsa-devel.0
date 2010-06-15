From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Update on TLV320AIC3204 Driver
Date: Tue, 15 Jun 2010 10:00:47 +0100
Message-ID: <20100615090044.GA4701@sirena.org.uk>
References: <20100611055512.GG23431@www.longlandclan.yi.org>
	<20100611101803.GB12436@sirena.org.uk>
	<20100615002734.GB7759@www.longlandclan.yi.org>
	<20100615051110.GG7759@www.longlandclan.yi.org>
	<20100615052351.GH7759@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 99B0A10388D
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jun 2010 11:00:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100615052351.GH7759@www.longlandclan.yi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stuart Longland <redhatter@gentoo.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Eric B??nard <eric@eukrea.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 15, 2010 at 03:23:51PM +1000, Stuart Longland wrote:
> On Tue, Jun 15, 2010 at 03:11:10PM +1000, Stuart Longland wrote:

> > Okay, I've had a close inspection of how the SOC_DOUBLE_R_SX_TLV widgets
> > are implemented.  I couldn't find where in the git trees the control had
> > been added, I wound up applying this patch myself in my tree... it
> > apparently got applied in the official trees, but I cannot find it.

> Okay... further digging, found it at
> <http://git.kernel.org/?p=linux/kernel/git/lrg/asoc-2.6.git;a=patch;h=b6f4bb383d69cac46f17e2305720f9a3d426c5ed>

> Looks like what I got is pretty much identical.

As documented in MAINTAINERS ASoC git for ASoC is:

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git

which gets fed into ALSA git:

   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
