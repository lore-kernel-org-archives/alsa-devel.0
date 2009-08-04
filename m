From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Patches for Freescale MXC SoCs (SSI,
 DMA and 	machine).
Date: Tue, 4 Aug 2009 21:26:58 +0100
Message-ID: <20090804202657.GH4342@sirena.org.uk>
References: <eedb5540908040817g15c981f8ye8aac6d4b253317f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 157DE243C0
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 22:27:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <eedb5540908040817g15c981f8ye8aac6d4b253317f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 04, 2009 at 05:17:47PM +0200, javier Martin wrote:

> Here comes a series of three patches which currently add audio support
> for MX1x and MX2x platforms.

As I indicated in reply to the individual patches these are all
basically OK.  Given the level of demand for thist stuff and the fact
that it's floating around in various forms out of tree for some
considerable time I'm inclined to try to push it for 2.6.32.

Unfortunately while I do have some more recent i.MX hardware I don't
have any i.MX2x hardware.  This means that if I do any work on this I'd
be coding blind for the i.MX2x stuff which could be a bit risky.

Thanks a lot for taking the time to do this work, I'm sure there's a
bunch of people out there who'd be very happy to see this code merged.
