From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WM9712 - Big and little endian format conversion.
Date: Wed, 13 May 2009 19:14:48 +0100
Message-ID: <20090513181448.GA23738@rakim.wolfsonmicro.main>
References: <9e4733910905131055v4eb487dhf5d410ae5d6b1a52@mail.gmail.com>
	<20090513175959.GB27909@sirena.org.uk>
	<9e4733910905131108n4e109dc5xd4c11056b95b33a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 100001038D7
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 20:14:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910905131108n4e109dc5xd4c11056b95b33a4@mail.gmail.com>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2009 at 02:08:19PM -0400, Jon Smirl wrote:
> On Wed, May 13, 2009 at 1:59 PM, Mark Brown

> > In this specific case there's now a standard define for the AC97 codecs
> > to use for the formats in current ASoC, add all the formats supported by
> > your CPU to that and all the AC97 codecs will pick it up automatically.
> > It's called SND_SOC_STD_AC97_FMTS, defined in the DAI header file.

> Which tree is this in?

It's in -next now so it can be seen in Takashi's tree and mine as well
- it's commit 33f503c96c976fd585dedb76514ca6cb286e60d9.
