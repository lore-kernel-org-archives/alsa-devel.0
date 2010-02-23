From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Separate dma driver for cpu_dais
Date: Tue, 23 Feb 2010 10:37:08 +0000
Message-ID: <20100223103708.GB14629@rakim.wolfsonmicro.main>
References: <20100217131421.GB11510@rakim.wolfsonmicro.main>
	<1b68c6791002171814k28fccf9emcbcf17c54c445a4f@mail.gmail.com>
	<20100218093459.GB3315@rakim.wolfsonmicro.main>
	<1b68c6791002180142l422a9203se2a71cae5795d6a9@mail.gmail.com>
	<20100218095249.GE3315@rakim.wolfsonmicro.main>
	<1b68c6791002180232p6cd86811sc78699ac87236015@mail.gmail.com>
	<20100218105750.GB3542@rakim.wolfsonmicro.main>
	<1b68c6791002180359k65381c09t143d37ec5eef1cf8@mail.gmail.com>
	<20100218131027.GF3542@rakim.wolfsonmicro.main>
	<1b68c6791002222145r543b0e45sfd842d8ddde4280f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5E6561038D4
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 11:37:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791002222145r543b0e45sfd842d8ddde4280f@mail.gmail.com>
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

On Tue, Feb 23, 2010 at 02:45:47PM +0900, jassi brar wrote:

> Okay. Here's another perspective ...
> If a dai can have further parallel sub-configurations, perhaps it should
> be further divided into more dais.
> So, I see a snd_soc_dai as the simplest h/w unit in the system and
> presumably  already fully exploited by the active dai_link i.e, none of
> its bits can be changed without disturbing the active stream. The
> number of shares should be transparent to a dai.
> If this assumption is valid please read on, otherwise correct me.

That doesn't map too well to hardware - it's relatively rare for devices
to require complete symmetry between the playback and capture portions
of the device, though often there are some constraints.  Usually there
is sufficient overlap in the hardware and documentation to describe them
as a single interface but not so much as to force the same configuration
for playback and record.

> The set of {rate, sample size & format, channels} defines one active
> dai. The second stream sharing this dai can not change any of these
> parameters without spoiling the active playback/capture - we can allow
> this configuration overriding as a feature or prevent as a bug. I
> prefer latter. Since there isn't anything new to do now, the ASoC core
> can
> simply avoid calling hooks in drivers rather than having 50 drivers
> implement a check.

If we were to go down this route it'd mean changing the existing drivers
to split their DAIs, which seems like a lot of work and doesn't save us
from having to implement the constraints that do exist.  This would be
pretty invasive and I can't clearly see if either approach gives much of
a win in itself.

It seems easier to approach this by providing ways for drivers to
communicate common constraints to the core with things like flags.
That'd at least mean less change for existing code.
