From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] ALSA: ASoc: Add regulator support to
 CS4270 codec driver
Date: Sun, 29 Nov 2009 09:35:54 +0100
Message-ID: <20091129083554.GC14091@buzzloop.caiaq.de>
References: <20091126160351.GB10674@rakim.wolfsonmicro.main>
	<20091126174245.GJ14091@buzzloop.caiaq.de>
	<20091127112550.GA29821@rakim.wolfsonmicro.main>
	<20091127124139.GR14091@buzzloop.caiaq.de>
	<20091127133225.GB17711@rakim.wolfsonmicro.main>
	<4B1186B8.6070606@freescale.com>
	<C78B2A7F-3D02-406C-A87B-8C3231456726@opensource.wolfsonmicro.com>
	<4B11A19D.4070301@freescale.com>
	<20091129004433.GZ14091@buzzloop.caiaq.de>
	<ed82fe3e0911282034t6bb8fa87o5141e48f7b0e6a7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 083E92463E
	for <alsa-devel@alsa-project.org>; Sun, 29 Nov 2009 09:35:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ed82fe3e0911282034t6bb8fa87o5141e48f7b0e6a7f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 28, 2009 at 10:34:12PM -0600, Timur Tabi wrote:
> On Sat, Nov 28, 2009 at 6:44 PM, Daniel Mack <daniel@caiaq.de> wrote:
> 
> > It does compile and does boot,
> 
> Does it compile and boot on a Freescale MPC8610 HPCD?

No, I don't have such a board. But I see no reason why it shouldn't
compile as no part of the patch is platform depended.

And for configurations with CONFIG_REGULATOR=n, all the new calls are
NOPs. The only heads-up is that for CONFIG_REGULATOR=y, you now need to
provide the regulators the codec driver needs.

Anyway - I'll rebase the driver to 'for-2.6.33' so you can give it a
try.

Thanks,
Daniel
