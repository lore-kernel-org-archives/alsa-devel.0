From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: dev_* output functions and ASoC codecs
Date: Tue, 13 Oct 2009 11:14:45 +0100
Message-ID: <20091013101445.GA29177@rakim.wolfsonmicro.main>
References: <8bd0f97a0910051718w5d97df8dr443917def9da9ac@mail.gmail.com>
	<20091006102033.GC27168@sirena.org.uk>
	<3c17e3570910111926u186586cdq2646d5aaade3121a@mail.gmail.com>
	<20091012093601.GA22233@sirena.org.uk>
	<3c17e3570910120334u6646b031vb5300645da8b6ce4@mail.gmail.com>
	<20091012104849.GA7994@rakim.wolfsonmicro.main>
	<3c17e3570910120620g7e65f87ekeb854c373375b7a3@mail.gmail.com>
	<20091012142018.GA18283@rakim.wolfsonmicro.main>
	<3c17e3570910130309r3ffed293g9cc8f9bd0c845d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7EDD81038C1
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Oct 2009 12:14:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3c17e3570910130309r3ffed293g9cc8f9bd0c845d4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, "Cai,
	Cliff" <Cliff.Cai@analog.com>, alsa-devel@alsa-project.org, Mike Frysinger <vapier.adi@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 13, 2009 at 06:09:07PM +0800, Barry Song wrote:

> Another issue is that there is only one global soc_ac97_ops in the
> whole system. In case there are two different ac97 ports, how to
> handle?

> Even though the two ac97 ports are same, how could CPU DAI related
> private data can be given to snd_ac97 to let it use that data to
> execute different operations? It seems snd_ac97 is only attached to
> codec.

I've no current plan to work on multiple AC97 controllers support within
ASoC except in so far as it falls out of other work - I've never
encountered an embedded system with multiple AC97 controllers so it's a
somewhat academic issue.  Patches welcome, though I'd expect it'd be
sensible to wait until multi-card support is present.
