From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4] ASoC: Add new Realtek ALC5632 CODEC
	driver.
Date: Thu, 10 Nov 2011 13:03:23 +0000
Message-ID: <20111110130323.GE3832@opensource.wolfsonmicro.com>
References: <4eb51219.8238df0a.64ec.ffffdb00@mx.google.com>
	<20111110121108.GC3832@opensource.wolfsonmicro.com>
	<CALq1K=KJ8EytOmfwOaw_pU2B5Cpv7Ar=iE1kL=QTj=mttGxK9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 323C0103AC4
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 14:03:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CALq1K=KJ8EytOmfwOaw_pU2B5Cpv7Ar=iE1kL=QTj=mttGxK9g@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Andrey Danin <danindrey@mail.ru>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 10, 2011 at 02:35:42PM +0200, Leon Romanovsky wrote:
> On Thu, Nov 10, 2011 at 14:11, Mark Brown

> > Ideally you should convert the driver over to work with the regmap API
> > and make use of the cache code it provides. =A0This is going to be
> > required at some point in the future and would mean that you could use
> > the same register I/O functionality here where you're identifying the
> > device (which is definitely good practice).

> If it possible, I would prefer to wait with this. I'll not be able to
> test the regmap interface properly because it was implemented for the
> 3.0 tree, and my development machine doesn't support it yet.

As it's an entirely new subsystem it should be really easy to backport
if you just copy the code into the older kernel.
