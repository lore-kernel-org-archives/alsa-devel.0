From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tpa6130a2: Define output pins with
 SND_SOC_DAPM_OUTPUT
Date: Wed, 19 May 2010 08:05:12 -0700
Message-ID: <1274281512.2698.1053.camel@finisterre.wolfsonmicro.main>
References: <1274266526-29439-1-git-send-email-jhnikula@gmail.com>
	<201005191500.14607.peter.ujfalusi@nokia.com>
	(sfid-20100519_130040_682330_DD580844)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3146B24663
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 17:05:03 +0200 (CEST)
In-Reply-To: <201005191500.14607.peter.ujfalusi@nokia.com>
	(sfid-20100519_130040_682330_DD580844)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-05-19 at 15:00 +0300, Peter Ujfalusi wrote:
> On Wednesday 19 May 2010 13:55:26 ext Jarkko Nikula wrote:
> > Codec output pin should be defined with SND_SOC_DAPM_OUTPUT as otherwise
> > external widgets doesn't alter the output state.
> > 
> > Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> > Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > ---
> > I noticed this with a widget and audio map below where state of
> > "Headphone Jack" wasn't changing the codec output.

> This is intentional.
> TPA is _not_ a codec, it is amplifier.

It seems reasonable enough for a user to want to do this - the only
difference with regard to the headphone amplifiers integrated onto
CODECs is that it happens to be on a separate piece of silicon.

> > SND_SOC_DAPM_HP("Headphone Jack", NULL),
> > 
> > {"Headphone Jack", NULL, "TPA6130A2 Headphone Left"},
> > {"Headphone Jack", NULL, "TPA6130A2 Headphone Right"},
> > {"TPA6130A2 Left", NULL, "LLOUT"},
> > {"TPA6130A2 Right", NULL, "RLOUT"}

> And this is how you should use it in a machine driver:
> Connect the codec's outputs to TPA. The TPA code adds the HPs for you already, 
> so you don't need to care about it...

It's not unreasonable for a user to want to wire the device through to a
board-defined jack. For example, they may find this helps with
documenting which physical jack is used or they may have a jack that's
got multiple output types on it such as a dock connector. They may also
wish to use the event that is available on the jack widget to perform
some board specific action when the headphone is activated.

There's no actual requirement to define headphone widgets if they don't
have any other code associated with them - if the outputs are left
unconnected the effect will be the same as if a noop and unused
headphone widget were there.
