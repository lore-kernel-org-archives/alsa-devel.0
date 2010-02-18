From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Separate dma driver for cpu_dais
Date: Thu, 18 Feb 2010 09:52:49 +0000
Message-ID: <20100218095249.GE3315@rakim.wolfsonmicro.main>
References: <1b68c6791002161839q705df04cmeda046736948c614@mail.gmail.com>
	<4B7B9387.1070506@samsung.com>
	<20100217105202.GB31765@sirena.org.uk>
	<1b68c6791002170415q457d0893jb1a77b864031ee6c@mail.gmail.com>
	<20100217131421.GB11510@rakim.wolfsonmicro.main>
	<1b68c6791002171814k28fccf9emcbcf17c54c445a4f@mail.gmail.com>
	<20100218093459.GB3315@rakim.wolfsonmicro.main>
	<1b68c6791002180142l422a9203se2a71cae5795d6a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A788B1038D6
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 10:52:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791002180142l422a9203se2a71cae5795d6a9@mail.gmail.com>
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
Cc: kyungmin.park@samsung.com, alsa-devel@alsa-project.org, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 18, 2010 at 06:42:26PM +0900, jassi brar wrote:
> On Thu, Feb 18, 2010 at 6:35 PM, Mark Brown

> > Could you please be more specific about what the workaround you are
> > referring to is? =A0I'm genuinely not clear what you mean here.

> In order for a codec_dai to be used in more than one dai_link
> I check for its 'active' counter and call shutdown, startup, mute
> and schedule_delayed_work only if no other dai_link is
> actively using that codec_dai.

Where is the code you are talking about here?  This sounds like driver
code...
