From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] asoc/multi-component: fsl: add support for
	variable SSI FIFO depth
Date: Thu, 5 Aug 2010 13:43:46 -0600
Message-ID: <AANLkTi=oYiW5_6mEwjgzwJxUHJV5fG3pwKntkTr0Cn3m@mail.gmail.com>
References: <1280952264-21813-1-git-send-email-timur@freescale.com>
	<20100805111010.GA13146@rakim.wolfsonmicro.main>
	<AANLkTinYjH-r3Myv=YavQBS0ULu-T0U4LPscsMOUtujR@mail.gmail.com>
	<20100805135153.GB14470@opensource.wolfsonmicro.com>
	<69A042BE-A5B7-4BD5-91FF-B3F635AF7839@freescale.com>
	<20100805145430.GB26801@opensource.wolfsonmicro.com>
	<5610599F537DD74A8D1F5CC946A750730347914E@az33exm25.fsl.freescale.net>
	<20100805160310.GA17454@opensource.wolfsonmicro.com>
	<5610599F537DD74A8D1F5CC946A750730347914F@az33exm25.fsl.freescale.net>
	<20100805181832.GA32359@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 23C031038FB
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 21:44:06 +0200 (CEST)
Received: by gxk26 with SMTP id 26so2877147gxk.38
	for <alsa-devel@alsa-project.org>; Thu, 05 Aug 2010 12:44:06 -0700 (PDT)
In-Reply-To: <20100805181832.GA32359@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Tabi Timur-B04825 <B04825@freescale.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 5, 2010 at 12:18 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> It also seems like busy work for users to have to add things like this
> to their device trees. =A0I think what I'd expect to see in a strongly
> device tree model is something like the tree for a board saying it's
> using a given SoC and then a standard device tree for the SoC which is
> shared between all the different users of that SoC getting merged in
> early in boot (probably from the kernel). =A0That way if we gain support
> for a new feature on the SoC or discover something that needs to be
> flagged up for workaround then every board using the SoC will pick it
> up. =A0This seems particularly useful for things like crypto engines that
> are physically internal to the SoC and so don't normally require
> per-board hookup. =A0In ASoC terms you do need board specific hookup so
> that's a bit less of an issue but it looses us some of the benefit of
> having standard chip drivers by pushing some of the chip generic
> knowledge into a per-machine location.

The lack of shared soc data in device trees is indeed a problem that
has been on my radar for a while now.  Fortunately I do have a
solution[1] which is partially implemented plus a contractual
obligation to deliver it to a client in the near future.  I fully
expect this will become a non-issue between now and about mid
November.

g.

[1] http://www.mail-archive.com/devicetree-discuss@lists.ozlabs.org/msg0068=
0.html
