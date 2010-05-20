From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: tpa6130a2: Define output pins with
	SND_SOC_DAPM_OUTPUT
Date: Thu, 20 May 2010 09:03:53 +0300
Message-ID: <201005200903.53926.peter.ujfalusi@nokia.com>
References: <1274266526-29439-1-git-send-email-jhnikula@gmail.com>
	<201005191500.14607.peter.ujfalusi@nokia.com>
	<1274281512.2698.1053.camel@finisterre.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id D5581103912
	for <alsa-devel@alsa-project.org>;
	Thu, 20 May 2010 08:04:32 +0200 (CEST)
In-Reply-To: <1274281512.2698.1053.camel@finisterre.wolfsonmicro.main>
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
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

this is now just educational discussion - for me ;)
Since Liam already taken the patch, Takashi pulled it, and it is on the tra=
in to =

2.6.35...
But still

On Wednesday 19 May 2010 18:05:12 ext Mark Brown wrote:
> On Wed, 2010-05-19 at 15:00 +0300, Peter Ujfalusi wrote:
> > On Wednesday 19 May 2010 13:55:26 ext Jarkko Nikula wrote:
> > > Codec output pin should be defined with SND_SOC_DAPM_OUTPUT as
> > > otherwise external widgets doesn't alter the output state.
> > > =

> > > Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> > > Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > > ---
> > > I noticed this with a widget and audio map below where state of
> > > "Headphone Jack" wasn't changing the codec output.
> > =

> > This is intentional.
> > TPA is _not_ a codec, it is amplifier.
> =

> It seems reasonable enough for a user to want to do this

There is no way to argue against this sentence ;)

> - the only difference with regard to the headphone amplifiers integrated =
onto
> CODECs is that it happens to be on a separate piece of silicon.

This driver had the _HP widgets since it has been introduced, and even the =

initial commit message explained, that the amp driver provides the _HP, and =

machines are only need to connect the amp to their codecs, and all is taken=
 care =

of DAPM.

I guess my reasoning was to avoid the following DAPM route, which for me se=
amed =

weird:
soc codec                        |      tap6130a2        |   machine driver
codec_DAC -> .. -> codec_OUTPUT -> tpa_PGA -> tpa_OUTPUT -> machine_HP

It seamed wrong to have codec_OUTPUT and tpa_OUTPUT in the same DAPM route.

> =

> > > SND_SOC_DAPM_HP("Headphone Jack", NULL),
> > > =

> > > {"Headphone Jack", NULL, "TPA6130A2 Headphone Left"},
> > > {"Headphone Jack", NULL, "TPA6130A2 Headphone Right"},
> > > {"TPA6130A2 Left", NULL, "LLOUT"},
> > > {"TPA6130A2 Right", NULL, "RLOUT"}
> > =

> > And this is how you should use it in a machine driver:
> > Connect the codec's outputs to TPA. The TPA code adds the HPs for you
> > already, so you don't need to care about it...
> =

> It's not unreasonable for a user to want to wire the device through to a
> board-defined jack.

Again, hard to argue with this ;)

> For example, they may find this helps with documenting which physical jac=
k is
> used

Not that fatal, a /* what is this for */ on above the TPA and codec DAPM ro=
ute =

connection might be enough.

> or they may have a jack that's got multiple output types on it such as a =
dock
> connector.

Can be done with the way it was (with the _HP in the tpa6130a2 driver)

> They may also wish to use the event that is available on the jack widget =
to
> perform some board specific action when the headphone is activated.

The event is _usually_ needed to toggle the power for the amp (enable/disab=
le).
The power for the tpa is managed within the driver, so no additional enable=
 is =

needed.

> There's no actual requirement to define headphone widgets if they don't
> have any other code associated with them - if the outputs are left
> unconnected the effect will be the same as if a noop and unused
> headphone widget were there.

That is true, but in that case why would anyone add the tpa amp to their DA=
PM =

route in the first place (when it is not connected)?

Anyways, I still think that the original driver was covering 99% of use cas=
es =

for a Headphone amplifier like the tpa6130a2/tpa6140a2.
But it is true, the there might be some really exotic (brain dead?) HW =

implementation, where this would not fit...

-- =

P=E9ter
