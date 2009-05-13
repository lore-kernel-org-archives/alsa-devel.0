From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WM9712 - Big and little endian format conversion.
Date: Wed, 13 May 2009 22:44:39 +0100
Message-ID: <20090513214439.GA24973@sirena.org.uk>
References: <9e4733910905131055v4eb487dhf5d410ae5d6b1a52@mail.gmail.com>
	<20090513175959.GB27909@sirena.org.uk>
	<9e4733910905131108n4e109dc5xd4c11056b95b33a4@mail.gmail.com>
	<20090513181448.GA23738@rakim.wolfsonmicro.main>
	<9e4733910905131118o6d96c02au3907b3f6cd5203b2@mail.gmail.com>
	<9e4733910905131120v663486b2j9b80340dfd65616f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 285272482A
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 23:44:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910905131120v663486b2j9b80340dfd65616f@mail.gmail.com>
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

On Wed, May 13, 2009 at 02:20:46PM -0400, Jon Smirl wrote:
> On Wed, May 13, 2009 at 2:18 PM, Jon Smirl <jonsmirl@gmail.com> wrote:

> > Adding S32_BE works for me:

> > #define SND_SOC_STD_AC97_FMTS (SNDRV_PCM_FMTBIT_S16_LE |\
> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? SNDRV_PCM_FMTBIT_S32_LE |\
> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? SNDRV_PCM_FMTBIT_S32_BE)

> Would it work to just put every format here and let the format be
> controlled by the platform and CPU DAI?

Not quite - there's a bunch of things like the S/PDIF stuff which will
almost certainly not do anything constructive in one of the generic AC97
slots without the CODEC and/or CPU doing magic to them.  Also note that
the core now fixes up CODEC formats on registration so both _BE and _LE
variants always get set if one is set.  That means that for preference
I'd use the _LE variants here since it's what all the existing CODEC
drivers are doing.

We should probably also squash all the 20 and 24 bit variants together,
I need to go and check that there's nothing that'll get confused by
that.
