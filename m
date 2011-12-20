From: Marc Dietrich <marvin24@gmx.de>
Subject: Re: [PATCH v3] ASoC: Tegra machine ASoC driver
	forboards using ALC5332 codec
Date: Tue, 20 Dec 2011 09:47:01 +0100
Message-ID: <1681052.3aIfuFPFms@fb07-iapwap2>
References: <1324324312-11478-1-git-send-email-leon@leon.nu>
	<74CDBE0F657A3D45AFBB94109FB122FF176BE92B19@HQMAIL01.nvidia.com>
	<CALq1K=K6j-ZXd5E7_CL9D_YZRgb9StvZtaGTPrKi9fsSvUcDpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id 0A79C24338
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 09:47:13 +0100 (CET)
In-Reply-To: <CALq1K=K6j-ZXd5E7_CL9D_YZRgb9StvZtaGTPrKi9fsSvUcDpw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Andrey Danin <danindrey@mail.ru>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@nvidia.com>, Leon Romanovsky <leon@leon.nu>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Am Dienstag, 20. Dezember 2011, 08:45:39 schrieb Leon Romanovsky:
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

I'm also going to try it on linux-next in the evening. Maybe it is just some mixer 
setting which is wrong.

> I believe the NVEC you used (from staging tree) is not the latest
> version I have. If I forget something, the working sound is available
> at https://gitorious.org/~leonro/ac100/leonro-marvin24s-kernel

There are only minor differences which shouldn't affect sound, e.g. the amplifier is 
switched on in nvec.c (nvec_events.c in our tree) - but that shouldn't matter.

> Before, I'm going to start pushing other parts of the audio, how do I
> need to handle cross-tree patches ? For example I'll need to update
> NVEC (staging tree) and platform_device (tegra and ASoC)
> On which tree do I base my patches?

If you have updates to other files beside the audio stuff (nvec or board stuff), you 
need to CC the relevant maintainers (see scripts/get_maintainer.pl).

Marc
