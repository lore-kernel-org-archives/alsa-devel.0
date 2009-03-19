From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 6/9] ARM: DaVinci: ASoC: Adds McASP clock
	support for TI DM646X processor
Date: Thu, 19 Mar 2009 14:28:37 -0700
Message-ID: <200903191428.38014.david-b@pacbell.net>
References: <FF55437E1F14DA4BAEB721A458B67017069809B098@dbde02.ent.ti.com>
	<20090319190942.GA8966@sirena.org.uk>
	<87prgdnrkx.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com (smtp128.sbc.mail.sp1.yahoo.com
	[69.147.65.187]) by alsa0.perex.cz (Postfix) with SMTP id BBD6224367
	for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2009 22:28:40 +0100 (CET)
In-Reply-To: <87prgdnrkx.fsf@deeprootsystems.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>, "Medisetty, Naresh" <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 19 March 2009, Kevin Hilman wrote:
> Sure, but what I don't want in that DAI driver is conditional code
> because of different clock names on different chips. =A0For example,
> some devices may only have one clk, so the hardware name is actualy
> "mcasp" instead of "mcasp0" etc.

Agreed that the clock setup should be in the arch/arm/mach-davinci
part of the tree ... but, for the record, I wouldn't find it at all
strange to see all such clocks named "mcasp0" instead of having some
boards use "mcasp" if there's only one.  :)
