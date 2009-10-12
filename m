From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: dev_* output functions and ASoC codecs
Date: Mon, 12 Oct 2009 15:20:18 +0100
Message-ID: <20091012142018.GA18283@rakim.wolfsonmicro.main>
References: <8bd0f97a0910051718w5d97df8dr443917def9da9ac@mail.gmail.com>
	<20091006102033.GC27168@sirena.org.uk>
	<3c17e3570910111926u186586cdq2646d5aaade3121a@mail.gmail.com>
	<20091012093601.GA22233@sirena.org.uk>
	<3c17e3570910120334u6646b031vb5300645da8b6ce4@mail.gmail.com>
	<20091012104849.GA7994@rakim.wolfsonmicro.main>
	<3c17e3570910120620g7e65f87ekeb854c373375b7a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EB5DA2434D
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Oct 2009 16:20:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3c17e3570910120620g7e65f87ekeb854c373375b7a3@mail.gmail.com>
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

On Mon, Oct 12, 2009 at 09:20:18PM +0800, Barry Song wrote:

> Thanks a lot. Fortunately, You parsed my meaning well. I just want to
> say it seems not too economic to have arrays with almost same members
> while CPU interfaces and codecs are same for all dai_links. dai[0] and
> dai[1] in array are just same.  It seems that will make more sense if

The current plan is to allow a dev_name plus DAI index instead of the
pointer to be used to establish the link, though I can't guarantee that
particular approach until it's implemented.
