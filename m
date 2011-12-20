From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: Tegra machine ASoC
 driverforboards using ALC5332 codec
Date: Tue, 20 Dec 2011 13:41:04 +0000
Message-ID: <20111220134103.GS2866@opensource.wolfsonmicro.com>
References: <1324324312-11478-1-git-send-email-leon@leon.nu>
	<1681052.3aIfuFPFms@fb07-iapwap2>
	<CALq1K=Lf60Jsk08oA2WjkvhsBp013qtrEYvUsqBtf2ys9yYD7g@mail.gmail.com>
	<2016872.YU7POP88LB@fb07-iapwap2>
	<CALq1K=JR=7mKbav+TUyw9DN0MNrFUdLicfu2Nho5Cf7VyQ7uog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7F7BD2439C
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 14:41:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CALq1K=JR=7mKbav+TUyw9DN0MNrFUdLicfu2Nho5Cf7VyQ7uog@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Andrey Danin <danindrey@mail.ru>, Stephen Warren <swarren@nvidia.com>, "lrg@ti.com" <lrg@ti.com>, Marc Dietrich <marvin24@gmx.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 20, 2011 at 02:11:01PM +0200, Leon Romanovsky wrote:

> And how will you ensure that the proposed patches will compile well?
> For example, Mark applied the tegra_alc5632.c patch into ASoC tree,
> but in tegra tree this file still doesn't exist, so any my attempt to
> link board-paz00.c (tegra tree) with tegra_alc5632. will lead to
> compile failures.

Again, without seeing what (if any) the dependencies are and what the
issues are it's hard to say exactly what should happen.  For simple
things often all the patches get merged via one tree.
