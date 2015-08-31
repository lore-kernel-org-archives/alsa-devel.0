From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH] ASoC: ics43432: Fix build errors
Date: Mon, 31 Aug 2015 09:14:02 +0200
Message-ID: <alpine.DEB.2.02.1508310854020.16666@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1508281200060.16666@lnxricardw1.se.axis.com>
 <20150828162156.GP12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EA5326063A
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 09:14:18 +0200 (CEST)
In-Reply-To: <20150828162156.GP12027@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


On Fri, 28 Aug 2015, Mark Brown wrote:

> On Fri, Aug 28, 2015 at 12:11:48PM +0200, Ricard Wanderlof wrote:
> > =

> > Fix build errors
> =

> I'll apply this since it fixes a build issue but please as I said in repl=
y =

> to your earlier off list query send one patch per issue (as covered in =

> SubmittingPatches) and try to provide useful changelogs describing the =

> issue being fixed.

I purposely grouped both the mismatched variable name and license name =

into a single patch, because both cause build failures when I tested in an =

x86 build, the latter resulting in:

.
.
.
  Building modules, stage 2.
  MODPOST 2426 modules
FATAL: modpost: GPL-incompatible module snd-soc-ics43432.ko uses GPL-only =

symbol '__platform_driver_register'
make[1]: *** [__modpost] Error 1

I should have been more descriptive in the commit message though. I did =

feel though that given the diff it was fairly obvious what the problems =

were so I didn't think it needed further explanation and would only clog =

up the commit log.

> > Not sure how the incorrect name or the misspelled license string got =

> > through my local build, perhaps because I've been developing this for =

> > an ARM system? Have now set up a tree to build for x86 as well, where =

> > the errors manifest themselves, to avoid this type of stuff happening =

> > in the future.
> =

> You can't be using a modern ARM system there, modern ARM systems are DT =

> based :(

Well, I am and it is. :) I double checked that CONFIG_OF was set when =

compiling the file, and also that the relevant lines of codes were in fact =

compiled. I don't know if there's any other kernel configuration (either a =

CONFIG_ option or some build option) which can influence the behavior =

though.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
