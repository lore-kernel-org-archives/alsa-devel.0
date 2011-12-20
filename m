From: Marc Dietrich <marvin24@gmx.de>
Subject: Re: [PATCH v3] ASoC: Tegra machine ASoC
	driverforboards using ALC5332 codec
Date: Tue, 20 Dec 2011 12:58:48 +0100
Message-ID: <2016872.YU7POP88LB@fb07-iapwap2>
References: <1324324312-11478-1-git-send-email-leon@leon.nu>
	<1681052.3aIfuFPFms@fb07-iapwap2>
	<CALq1K=Lf60Jsk08oA2WjkvhsBp013qtrEYvUsqBtf2ys9yYD7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id CC0A42414C
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 12:58:58 +0100 (CET)
In-Reply-To: <CALq1K=Lf60Jsk08oA2WjkvhsBp013qtrEYvUsqBtf2ys9yYD7g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: alsa-devel@alsa-project.org, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@nvidia.com>, "lrg@ti.com" <lrg@ti.com>, Andrey Danin <danindrey@mail.ru>
List-Id: alsa-devel@alsa-project.org

Am Dienstag, 20. Dezember 2011, 13:05:50 schrieb Leon Romanovsky:
> On Tue, Dec 20, 2011 at 10:47, Marc Dietrich <marvin24@gmx.de> wrote:
> > Am Dienstag, 20. Dezember 2011, 08:45:39 schrieb Leon Romanovsky:
> >> On Mon, Dec 19, 2011 at 23:00, Stephen Warren <swarren@nvidia.com> wrote:
> >> > Leon Romanovsky wrote at Monday, December 19, 2011 12:52 PM:
> >> Before, I'm going to start pushing other parts of the audio, how do I
> >> need to handle cross-tree patches ? For example I'll need to update
> >> NVEC (staging tree) and platform_device (tegra and ASoC)
> >> On which tree do I base my patches?
> > 
> > If you have updates to other files beside the audio stuff (nvec or board
> > stuff), you need to CC the relevant maintainers (see
> > scripts/get_maintainer.pl).
> 
> Different trees have different file versions, this is why i'm asking
> "on which tree do I base my patches?"

ok, I think patches for upstream should be based on the relevant subsystem trees 
(e.g. sound (git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git), board 
(arm-soc 
 git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git) and nvec ( 
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git). One may correct me 
where I'm wrong.

I know it is hard to test changes this way, but that's a common problem. I often use 
linux-next to create and test the patches and rebase them to the relevant subsystem 
trees before submitting. Maybe there is a better solution for it...

Marc
