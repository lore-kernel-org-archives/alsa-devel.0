From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/5] ASoC
	codec:	SSM2602: assign last substream to the master when
	shutting down
Date: Sat, 13 Jun 2009 11:59:11 +0100
Message-ID: <20090613105911.GB4795@sirena.org.uk>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
	<1243916337-29953-2-git-send-email-vapier@gentoo.org>
	<20090603105223.GE11507@sirena.org.uk>
	<8bd0f97a0906030537y1e65aa7atec4b0c5cdf4ae2f@mail.gmail.com>
	<20090603145316.GA7315@rakim.wolfsonmicro.main>
	<8bd0f97a0906031826j647efa0bs1ffb6492cfd0ccd8@mail.gmail.com>
	<20090604085921.GD6983@rakim.wolfsonmicro.main>
	<ea2442770906130237s72ff15b3n1168eb3392231149@mail.gmail.com>
	<20090613104435.GA4795@sirena.org.uk>
	<8bd0f97a0906130347x74973be2nf5c26641a09c5e24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C4C02443B
	for <alsa-devel@alsa-project.org>;
	Sat, 13 Jun 2009 12:59:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8bd0f97a0906130347x74973be2nf5c26641a09c5e24@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Karl Beldan <karl.beldan@gmail.com>, uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 13, 2009 at 06:47:17AM -0400, Mike Frysinger wrote:

> i think Cliff verified that the other part of the change was no longer
> needed in his testing, so reverting the whole patch is fine.  we've
> done that in the Blackfin tree.

So, the first part of the patch was applying constraints.  You definitely
want to do that with your current implementation - the hw_params()
function will completely ignore the parameters set for the second
substream so unless you use constraints the second application will get
a configuration it didn't ask for which isn't going to work so well.
