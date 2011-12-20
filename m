From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH v3] ASoC: Tegra machine ASoC driver for
 boards using ALC5332 codec
Date: Tue, 20 Dec 2011 08:35:31 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF176BE92D05@HQMAIL01.nvidia.com>
References: <1324324312-11478-1-git-send-email-leon@leon.nu>
	<74CDBE0F657A3D45AFBB94109FB122FF176BE92B19@HQMAIL01.nvidia.com>
	<CALq1K=K6j-ZXd5E7_CL9D_YZRgb9StvZtaGTPrKi9fsSvUcDpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C1D4243B2
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 17:35:43 +0100 (CET)
In-Reply-To: <CALq1K=K6j-ZXd5E7_CL9D_YZRgb9StvZtaGTPrKi9fsSvUcDpw@mail.gmail.com>
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
To: Leon Romanovsky <leon@leon.nu>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>, Andrey Danin <danindrey@mail.ru>
List-Id: alsa-devel@alsa-project.org

Leon Romanovsky wrote at Monday, December 19, 2011 11:46 PM:
> On Mon, Dec 19, 2011 at 23:00, Stephen Warren <swarren@nvidia.com> wrote:
> > Leon Romanovsky wrote at Monday, December 19, 2011 12:52 PM:
> >> At this stage only Toshiba AC100/Dynabook supported.
> >>
> >> Signed-off-by: Leon Romanovsky <leon@leon.nu>
> >> Signed-off-by: Andrey Danin <danindrey@mail.ru>
> >
> > Acked-by: Stephen Warren <swarren@nvidia.com>
> >
> > I also attempted to test this, but couldn't persuade any audio to come
> > out. What more do I need to test this, beyond the obvious addition of
> > platform device registration and clocks to board-paz00.c? Thanks.
>
> I believe the NVEC you used (from staging tree) is not the latest
> version I have. If I forget something, the working sound is available
> at https://gitorious.org/~leonro/ac100/leonro-marvin24s-kernel

Ah right, I didn't have the NVEC driver enabled, so I'll try again...

-- 
nvpublic
