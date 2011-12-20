From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH v3] ASoC: Tegra machine ASoCdriverforboards
 using ALC5332 codec
Date: Tue, 20 Dec 2011 08:43:31 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF176BE92D0B@HQMAIL01.nvidia.com>
References: <1324324312-11478-1-git-send-email-leon@leon.nu>
	<2016872.YU7POP88LB@fb07-iapwap2>
	<CALq1K=JR=7mKbav+TUyw9DN0MNrFUdLicfu2Nho5Cf7VyQ7uog@mail.gmail.com>
	<4517749.QSoZznPh9U@fb07-iapwap2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 67764243C0
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 17:43:41 +0100 (CET)
In-Reply-To: <4517749.QSoZznPh9U@fb07-iapwap2>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marc Dietrich <marvin24@gmx.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Danin <danindrey@mail.ru>, Andrey@alsa-project.org, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Leon Romanovsky <leon@leon.nu>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Marc Dietrich wrote at Tuesday, December 20, 2011 5:39 AM:
> Am Dienstag, 20. Dezember 2011, 14:11:01 schrieb Leon Romanovsky:
> > On Tue, Dec 20, 2011 at 13:58, Marc Dietrich <marvin24@gmx.de> wrote:
> > > Am Dienstag, 20. Dezember 2011, 13:05:50 schrieb Leon Romanovsky:
> > >> On Tue, Dec 20, 2011 at 10:47, Marc Dietrich <marvin24@gmx.de> wrote:
> > >> > Am Dienstag, 20. Dezember 2011, 08:45:39 schrieb Leon Romanovsky:
> > >> >> On Mon, Dec 19, 2011 at 23:00, Stephen Warren <swarren@nvidia.com> wrote:
> > >> >> > Leon Romanovsky wrote at Monday, December 19, 2011 12:52 PM:
> > >> >> Before, I'm going to start pushing other parts of the audio, how do I
> > >> >> need to handle cross-tree patches ? For example I'll need to update
> > >> >> NVEC (staging tree) and platform_device (tegra and ASoC)
> > >> >> On which tree do I base my patches?
> > >> >
> > >> > If you have updates to other files beside the audio stuff (nvec or board
> > >> > stuff), you need to CC the relevant maintainers (see
> > >> > scripts/get_maintainer.pl).
> > >>
> > >> Different trees have different file versions, this is why i'm asking
> > >> "on which tree do I base my patches?"
> > >
> > > ok, I think patches for upstream should be based on the relevant subsystem
> > > trees
> > > (e.g. sound (git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git),
> > > board (arm-soc
> > >  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git) and nvec (
> > > git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git). One may
> > > correct me where I'm wrong.
> >
> > And how will you ensure that the proposed patches will compile well?
> > For example, Mark applied the tegra_alc5632.c patch into ASoC tree,
> > but in tegra tree this file still doesn't exist, so any my attempt to
> > link board-paz00.c (tegra tree) with tegra_alc5632. will lead to
> > compile failures.
> 
> test with e.g. linux-next, *submit early* to the subsystems and fix breakage later
> on.

Well, we should strive to avoid creating any breakage in the first place;
if you break anything, that means "git bisect" will stop working, which
might make tracking down other problems a pain.

In this case, I think the patches you need to the Tegra tree don't have
any dependencies on the ALSA/ASoC tree; you're basically only registering
some platform devices, and you can register those irrespective of whether
drivers exist for those devices or not yet.

Put another way, registering the devices in the Tegra tree without the
ASoC changes being present will be pretty much a harmless no-op. Having
the drivers present in the ASoC tree without any platform devices being
registered to instantiate them will also be a harmless no-op. Once both
sets of changes meet (in linux-next, or a Linus tree), they'll interact
and cause audio to start working.

The only dependency you'll have is the addition of the platform data
header file, which needs to be in both trees to compile the board file
and the driver, but you haven't created this file yet, so there's no
problem to date. In the past, Mark and I have handled this by:

* Create a patch that does nothing but add the pdata header file.
* Put that patch in a branch of its own.
* Merge that branch into both the Tegra tree and the ASoC tree before
  any changes that use the header file.

But there are other ways to handle this too. Given all the work in the
Tegra tree right now though, that way is probably the simplest for
everyone to deal with.

-- 
nvpublic
