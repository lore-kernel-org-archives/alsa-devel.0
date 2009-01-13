From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: SoC scenarii API
Date: Tue, 13 Jan 2009 12:36:13 +0100
Message-ID: <87iqojqvyq.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 782461037EC
	for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2009 12:36:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@sirena.org.uk, lrg@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Liam and Mark,

As mioa701 submission was stopped due to the need of a generic scenarii API,
this a first attempt to design such an API in order to unblock mioa701
submission.

This is oversimplified, no convenience macros are provided, just external
data structures and namespace polution.

I'm expecting a lot of comments from both of you.

Cheers.

--
Robert

enum pin_change {
	SCEN_PIN_OFF = 0,	/* Disable the pin */
	SCEN_PIN_ON,		/* Enable the pin */
	SCEN_PIN_LEAVE		/* Leave the pin in previous state */
};

struct setup_mixmux {
	char *mixname;		/* Codec Mixer or Muxer name */
	int  val;		/* Codec Mixer or Muxer value to enforce */
};

/**
 * struct soc_scenario - describes one sound usecase
 * @name: Scenario name, value as will be seen in alsa "SoC Mode" alsa control
 * @pin_setup: Pin configuration to perform on scenario activation
 *	Table of all pins, as they should be configured. Each elements is a
 *	pin_change value, describing how to handle a specific pin.
 *      Table size must be the same as in snd_soc_scenario_init().
 * @mixer_cleanup: Mixers/muxes to set up in phase (b)
 *	Table of all mixers/muxes to modify, NULL terminated.
 * @mixer_setup: Mixers/muxers to set up in phase (c)
 *	Table of all mixers/muxes to modify, NULL terminated
 * @lvol_master: Left volume aliased to "SoC Volume"
 * @rvol_master: Right volume aliased to "SoC Volume"
 * @lvol_mute: Left volume mute aliased to "SoC Volume" mute control
 * @rvol_mute: Right volume mute aliased to "SoC Volume" mute control
 *
 * This structure describes what a scenario change implies. The behaviour is to :
 *  a) enable several pins, disable others, leave others in their state
 *     (understand here snd_soc_dapm_enable_pin)
 *  b) set up some mixers and muxers to prepare the change, and clean up.
 *     This should be normally used to restore a "default state" if need be, before
 *     activating the mixers/muxers into their final state.
 *     Note: table in NULL, or always terminated by NULL pointer
 *     Note: this cleanup may/should be shared amongst all scenarii
 *  c) set up some mixers and muxers to the final state
 *     This should be normally used to restore a "default state" if need be, before
 *     activating the mixers/muxers into their final state.
 *     Note: table in NULL, or always terminated by NULL pointer
 */
struct soc_scenario {
	const char *name;				/* scenario name */
	const unsigned char pin_setup[];		/* pin_change for pins */
	const struct setup_mixmux mixes_cleanup[];	/* mix cleanup */
	const struct setup_mixmux mixes_setup[];	/* mix setup */
	const char *lvol_master;			/* left volume master */
	const char *rvol_master;			/* right volume master */
	const char *lvol_mute;				/* left volume mute */
	const char *rvol_mute;				/* right volume mute */
};

/**
 * snd_soc_scenario_init - initialize soc scenarii
 * @codec: codec associated to the pins/mixers/muxes/volumes/mutes
 * @scenario: table of scenarii
 * @nb_scenarii: number of scenarii
 * @pin_names: table of pin names
 * @nb_pins: number of pins handled by scenario
 *
 * Initialise the soc scenarii engine. The first scenario (0) will be used.
 * By default, the user could leave this scenario as non intrusive (not a single
 * pin changed, no mixers/muxes changes, and volume master inactive).
 */
int snd_soc_scenario_init(struct snd_soc_codec *codec,
			  struct soc_scenario *scenario, int nb_scenarii,
			  char *pin_names[], int nb_pins);

/**
 * snd_soc_scenario_init - initialize soc scenarii
 * @codec: codec used for the init
 */
void snd_soc_scenario_release(struct snd_soc_codec *code);
