From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: patch 1/1: ASoC,
	DMA crash with application- resolved
Date: Mon, 22 Dec 2008 09:17:57 +0200
Message-ID: <bd7b27490812212317t124b3c3fpf8b52216b7bbc759@mail.gmail.com>
References: <ef0d8a250812202322i3fe62ed2n2d1e09ab830e27dd@mail.gmail.com>
	<bd7b27490812210136m710dc896j43c060e14bc5fb4a@mail.gmail.com>
	<ef0d8a250812210138q3cad7dbay21611e2088a1525b@mail.gmail.com>
	<bd7b27490812210142q708842aai94a02f28d99cdf97@mail.gmail.com>
	<ef0d8a250812210807h5fe861a0s5f62c4b728578022@mail.gmail.com>
	<20081221210906.GA14903@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f20.google.com (mail-bw0-f20.google.com
	[209.85.218.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EAED1037E3
	for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2008 08:17:57 +0100 (CET)
Received: by bwz13 with SMTP id 13so5361981bwz.8
	for <alsa-devel@alsa-project.org>; Sun, 21 Dec 2008 23:17:57 -0800 (PST)
In-Reply-To: <20081221210906.GA14903@sirena.org.uk>
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
To: Mark Brown <broonie@sirena.org.uk>
Cc: tony@atomide.com, "naveenkrishna.ch" <naveenkrishna.ch@gmail.com>, alsa-devel@alsa-project.org, jarkko.nikula@nokia.com
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 21, 2008 at 11:09 PM, Mark Brown <broonie@sirena.org.uk> wrote:

> On Sun, Dec 21, 2008 at 09:37:21PM +0530, naveenkrishna.ch wrote:
>
> >  To solve the DMA crashes i have sent a patch, it worked i dint found any
> > patches related to this issue,
> > I tried it on alsa kernel git...
>
> Please check with Jarkko's patch applied below - it's not in ALSA git so
> you'll need to cherry pick it over into Takashi's tree by hand:
>
>
Here's link to the patch and it applies into Takashi's tree:

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commitdiff_plain;h=55502f74b56f609a84d8919b9b29390b2e0147ff;hp=f519e67d3376cb177e4ae5f005df13646f6379c1

And recent Oops fix (which is in Takashi's tree):

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=commitdiff_plain;h=19b3f31609dc8be3a56c78dcb7da723f10f7009c;hp=13d428afc007fcfcd6deeb215618f54cf9c0cae6

If these two don't help, then I think there must be either race somewhere or
bug in stopping of OMAP DMA. Anyway, it's a bug if DMA is still running when
executing omap_pcm_hw_free.

If possible, can you post a crash dump and/or use-case how to reproduce the
problem? I have TI Beagle board with OMAP3 and TWL4030 so I may be able to
reproduce it as well.


Jarkko
