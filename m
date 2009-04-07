From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 3/6] ASoC: TWL4030: Enable all audio paths
Date: Tue, 7 Apr 2009 07:59:19 +0300
Message-ID: <200904070759.19600.peter.ujfalusi@nokia.com>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-4-git-send-email-peter.ujfalusi@nokia.com>
	<20090406124520.GA14169@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id C36D724422
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Apr 2009 06:59:30 +0200 (CEST)
In-Reply-To: <20090406124520.GA14169@sirena.org.uk>
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
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Monday 06 April 2009 15:45:21 ext Mark Brown wrote:
> On Mon, Apr 06, 2009 at 03:19:29PM +0300, Peter Ujfalusi wrote:
> > Enable all TX and RX paths on the TWL codec.
>
> What does this mean by "enable" - I'm guessing it's powering blocks
> within the CODEC rather than connecting any audio paths?

The TRM calls these as Audio/Voice digital filters.
In effect, they enable the shifting out bits from the Capture path to the b=
us =

and shifting in bits on the Playback side.

The original driver had these filters enabled - all the time - for the digi=
tal =

filters needed for the i2s mode (AudioRX2 L/r, AudioTX1 L/R), in TDM mode a=
ll =

4 filters on Capture and Playback need to be enabled.

>
> > This is not so nice, but doing it runtime brings quite a bit
> > of challenge, since for example the Digital loopback also needs
> > the RX and TX paths to be enabled.
>
> What are the problems other than loopback (which really needs digital
> routing to work properly, though I've never seen much demand for it
> outside of testing)?  Powering everything is probably fine, I'm just
> wondering if this is due to the hardware or the core.

The digital loopback needs the AudioTX1 L/R and AudioRX2 L/R enabled in ord=
er =

to function, and I have a requirement, that the codec should support it ;) =


I had two other implementation for these:
a) Enable the needed Digital filters in twl4030_startup based on the channe=
l =

number and stream type (Playback/Capture). Disable the Digital filters on =

twl4030_shutdown, based on the just closed stream's parameters.
b) Adding another widgets to the DAPM routing paths, so it tries to enable =

only the needed Digital filters.

There were couple of problems with these:
a) Digital loopback was not functioning
b) It did enabled other filters, than what it is needed (in stereo mode =

AudioRX1 L/R and AudioTX2 L/R should not be enabled). I guess this is becau=
se =

the DAPM knows only about streams, but here we can have 2 channel or 4 chan=
nel =

streams, which need to be handled a bit differently.

But as I said, this is not so nice thing to do, so it need to be revisited.

-- =

P=E9ter
