From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [PATCH V2] Add i.MX sound support
Date: Fri, 27 Nov 2009 10:01:37 +0100
Message-ID: <eedb5540911270101o4bf06b2ct6ff22e29b7c1fe15@mail.gmail.com>
References: <1259163666-30344-1-git-send-email-s.hauer@pengutronix.de>
	<eedb5540911260753u369d6cffp97c05089cdd30868@mail.gmail.com>
	<20091127075834.GG27548@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f210.google.com (mail-ew0-f210.google.com
	[209.85.219.210])
	by alsa0.perex.cz (Postfix) with ESMTP id 6184824587
	for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2009 10:01:40 +0100 (CET)
Received: by ewy2 with SMTP id 2so4415765ewy.32
	for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2009 01:01:39 -0800 (PST)
In-Reply-To: <20091127075834.GG27548@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

2009/11/27 Sascha Hauer <s.hauer@pengutronix.de>

> Hi Javier,
>
> On Thu, Nov 26, 2009 at 04:53:21PM +0100, javier Martin wrote:
> > Dear Sascha,
> > what repository - branch are these patches tested against? They don't
> seem
> > to apply in git://git.pengutronix.de/git/imx/linux-2.6.git mxc-master
> > branch.
>
> Try this branch instead to get a full series also containing the mc13783
> support and full board support for the Phytec boards:
>
> git://git.pengutronix.de/git/imx/linux-2.6.git asoc
>
> I posted only the patches relevant to the alsa list. By now mxc-master
> should contain the missing bits.
>

Sascha,
it seems that git://git.pengutronix.de/git/imx/linux-2.6.git asoc is in an
intermediate state since some files are already created (imx-ssi.*) and
others aren't (imx-pcm-dma-mx2.c), this result in nasty errors when applying
your last patches (v2).

There are also errors when applying on  git://
git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33 .


-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
