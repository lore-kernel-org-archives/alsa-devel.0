From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: [PATCH 1/3] ASoC: TWL4030: Enable voice
	filters	for voice sidetone
Date: Tue, 23 Jun 2009 14:45:02 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E3555FEAD@dlee04.ent.ti.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E3543F31C@dlee04.ent.ti.com>
	<200906230838.20351.peter.ujfalusi@nokia.com>
	<20090623101615.GG5422@sirena.org.uk>
	<200906231618.35877.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 5404F24406
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 21:45:13 +0200 (CEST)
In-Reply-To: <200906231618.35877.peter.ujfalusi@nokia.com>
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
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> On Tuesday 23 June 2009 13:16:16 ext Mark Brown wrote:
> > On Tue, Jun 23, 2009 at 08:38:20AM +0300, Peter Ujfalusi wrote:
> > > Now if you start an audio playback (which will enable the =

> > > ARXL1, even if we are in Option2), than you stop it: the
> > > ARXL1 (which is VRX in Option2) bit will be turned off...
> > > Now I'm not sure how this will be handled by
> > > the ASoC core.
> > > What I mean is: One path enabled this bit, than another =

> > > path also enables the same bit, than it disables it. Will
> > > the first path notice it? Or will it think that the bit
> > > is still enabled?

> > Sounds like a possible case for a supply widget, though the =

> > fact that you've got both option 1 and option 2 is fun.

> Well I use the fun word for a bit different things...
> I have to check what actually the supply widget supposed to =

> be doing and what is it for.

> > If the driver were a proper platform driver you could select
> > between option 1 and option 2 in platform data (assuming
> > that's sensible) and register different widgets
> > depending on which was in use.

If we register widgets based on an option passed through platform
data, then we won't be able to switch between options, right?
I think switching between option1/2 during runtime is needed,
otherwise 4-channels and voice support will be mutually exclusive.

> I have been looking at this. It does not seamed that =

> complicated. I had written some of the code, but than it
> turned out a bit more complicated:
> In twl4030 series the Vibra interface also reside inside of =

> the CODEC part.
> in short: twl4030 is a MFD, than the TWL4030 codec itself =

> also and MFD..
> So in order to get this in a proper way, this should be =

> handled somehow (another 'fake' MFD for the twl4030 codec/vibra
> perhaps).

> This is still in my list, but certainly need more time to get =

> a reasonable good implementation. =


> -- =

> P=E9ter
