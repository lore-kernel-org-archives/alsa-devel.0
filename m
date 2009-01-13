From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: SoC scenarii API
Date: Tue, 13 Jan 2009 15:56:04 +0000
Message-ID: <20090113155602.GD11651@sirena.org.uk>
References: <87iqojqvyq.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id AFE901037E3
	for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2009 16:56:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87iqojqvyq.fsf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, lrg@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 13, 2009 at 12:36:13PM +0100, Robert Jarzmik wrote:

> As mioa701 submission was stopped due to the need of a generic scenarii API,
> this a first attempt to design such an API in order to unblock mioa701
> submission.

You can still carry on submitting the core machine support and then
patch it to add the scenario stuff later.  That'd probably make review
slightly easier too since it'd identify the new stuff explicitly.

In general I'd like to see more exploration of the use cases that this
is intended to satisfy, including in terms of the mioa701 itself.  The
documentation should make it clear that this is not intended to be a
scalable solution and is only intended to be useful for hardware that is
very limited.  

What are you using for user space - is it one of the standard stacks
like FSO?  Looking at the features you've got I'm a bit concerned that
the scenarios may get limiting in future: with both bluetooth and GSM
things are already pretty complex.  The only thing it's missing compared
to OpenMoko is WiFi.  For example, with your current scenarios I'm not
sure if it'd be possible to record a call or do simultaneous record and
playback?  For dealing with overheating I *expect* that you only need to
have the machine driver prevent particular combinations of outputs being
simultaneously enabled.

That said, this looks mostly reasonable as a scenario API.  I assume
that it creates new controls for the master volume and for selecting the
scenario?  The main issues I can see are with how state transitions are
managed and with how machine drivers interact with this if they need to
update the configuration at run time.

> struct setup_mixmux {
> 	char *mixname;		/* Codec Mixer or Muxer name */
> 	int  val;		/* Codec Mixer or Muxer value to enforce */
> };

This structure needs namespacing.  Also, "Mux" not "Muxer".

> /**
>  * struct soc_scenario - describes one sound usecase

snd_soc_scenario.

>  * @name: Scenario name, value as will be seen in alsa "SoC Mode" alsa control
>  * @pin_setup: Pin configuration to perform on scenario activation
>  *	Table of all pins, as they should be configured. Each elements is a
>  *	pin_change value, describing how to handle a specific pin.
>  *      Table size must be the same as in snd_soc_scenario_init().

The table size ought to be specified in only one place.

>  * @mixer_cleanup: Mixers/muxes to set up in phase (b)
>  *	Table of all mixers/muxes to modify, NULL terminated.
>  * @mixer_setup: Mixers/muxers to set up in phase (c)
>  *	Table of all mixers/muxes to modify, NULL terminated

Hrm.  This all feels either too flexible or too inflexible WRT state
transitions.  If you do need to impose ordering beyond what DAPM can
figure out for itself then I'd expect to see any number of steps being
allowed.  If that isn't required then the intermediate step could just
be dropped.  If there were going to be some sort of "idle" state to
transition through I'd expect to just see that identified and then the
switchover to do a state->idle->state transition.

This might also be better with snd_ctl_elem_values so that it can cope
with any control - there's definitely a need for configuring PGAs
per-scenario, for example.  Please also use a number of elements
parameter for consistency with the rest of the API (both here and ASoC
wide).

> struct soc_scenario {
> 	const char *name;				/* scenario name */
> 	const unsigned char pin_setup[];		/* pin_change for pins */
> 	const struct setup_mixmux mixes_cleanup[];	/* mix cleanup */
> 	const struct setup_mixmux mixes_setup[];	/* mix setup */

More natural would be pointers to arrays...

> int snd_soc_scenario_init(struct snd_soc_codec *codec,
> 			  struct soc_scenario *scenario, int nb_scenarii,

Please make this take a snd_soc_card rather than a snd_soc_codec.  Most
of the card-wide APIs currently take a codec but this is in the process
of being fixed.  Also, scenarios is the more usual plural in English.
For consistency with the rest of the API it'd be nice to use num rather
than nb.

Some of the documentation about the situations where this API should be
used should go with this function.

> 			  char *pin_names[], int nb_pins);

I'm not sure why the pin names are specified separately here?  Would it
not be better to just use the pin lists in the scenarios.

> /**
>  * snd_soc_scenario_init - initialize soc scenarii
>  * @codec: codec used for the init
>  */
> void snd_soc_scenario_release(struct snd_soc_codec *code);

I sense bitrot :)
