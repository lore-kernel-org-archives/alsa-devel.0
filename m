From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: SoC scenarii API
Date: Fri, 20 Feb 2009 20:04:24 +0100
Message-ID: <87vdr5orpj.fsf@free.fr>
References: <87iqojqvyq.fsf@free.fr> <20090113155602.GD11651@sirena.org.uk>
	<87tz82yh1c.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 029D2103921
	for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2009 20:04:30 +0100 (CET)
In-Reply-To: <87tz82yh1c.fsf@free.fr> (Robert Jarzmik's message of "Tue\,
	13 Jan 2009 23\:31\:27 +0100")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, lrg@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

It's been a while since my last post.
This is a new proposition for the API. I hope I have not forgotten what has been
said previously.

As a side note, I'm a bit bothered by your comment about using
"snd_ctl_elem_value" instead of integers in structure soc_scen_setup_mix. My
concern is about size : snd_ctl_elem_value is huge, and as there will be many
mixes/muxes, the memory print will be huge. Can't we deal with only integers for
mixers and muxes ?

Cheers.

--
Robert

>From 16401a42858cff870a12202190467ac59ed12707 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Fri, 20 Feb 2009 17:44:09 +0100
Subject: [PATCH] Preliminary soc-scenario API.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 include/sound/soc-scenario.h |  119 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 119 insertions(+), 0 deletions(-)
 create mode 100644 include/sound/soc-scenario.h

diff --git a/include/sound/soc-scenario.h b/include/sound/soc-scenario.h
new file mode 100644
index 0000000..bf02d1e
--- /dev/null
+++ b/include/sound/soc-scenario.h
@@ -0,0 +1,119 @@
+/*
+ * Handles the machine boards scenarios
+ *
+ * Copyright (C) 2008 Robert Jarzmik
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *
+ * Some boards need to enforce use cases of audio paths to protect the hardware
+ * from overheating if uncorrectly used.
+ *
+ * This infrastructure is _not_ to be used as a scenario API. This should be
+ * left to userland applications. This API unique purpose is to protect devices
+ * from hardware destruction through pre-defined use cases.
+ *
+ * ALWAYS CONSIDER A USERLAND SOLUTION before using soc-scenario !!!
+ */
+
+/*
+ * Usage example:
+ * static struct scen_gsm = {
+ * 	.pin_activate = { "Front Speaker", "Front Mic", "GSM Line Out",
+ *			  "GSM Line In", NULL },
+ *	.pin_deactivate = { "Rear Speaker", NULL },
+ *	.mixes_num = 4,
+ *	.mixes = {
+ *		SOC_SCN_MIX("Left HP Mixer PC Beep Playback Switch", 1),
+ *		SOC_SCN_MIX("Left Headphone Out Mux", 2),
+ *		SOC_SCN_MIX("Right HP Mixer MonoIn Playback Switch" , 1),
+ *		SOC_SNC_MIX("Right Headphone Out Mux", 2),
+ *	},
+ * };
+ */
+
+#define SOC_SNC_MIX(_name, _val) { .mixname = _name, .val = _val }
+struct soc_scen_setup_mixmux {
+	char 			*mixname;	/* Codec Mixer or Mux name */
+	snd_ctl_elem_value	val;		/* Value to enforce */
+};
+
+/**
+ * struct soc_scenario - describes one sound usecase
+ * @name: Scenario name, value as will be seen in alsa "SoC Mode" alsa control
+ * @pin_activate: Pins to activate on scenario activation
+ * @pin_deactivate: Pins to deactivate on scenario activation
+ *	Table of all pins, as they should be configured. Each elements is a
+ *	pin_change value, describing how to handle a specific pin.
+ * @mixes_num: Size of array mixes[]
+ * @mixes: Mixers/muxes to set up in phase (b)
+ *	Table of all mixers and muxes to set up upon entering this scenario
+ * @lvol_master: Left volume aliased to "SoC Volume"
+ * @rvol_master: Right volume aliased to "SoC Volume"
+ * @lvol_mute: Left volume mute aliased to "SoC Volume" mute control
+ * @rvol_mute: Right volume mute aliased to "SoC Volume" mute control
+ *
+ * This structure describes what a scenario change implies. The behaviour is to :
+ *  a) enable several pins, disable others, leave others in their state
+ *     (understand here snd_soc_dapm_enable_pin)
+ *     Note: tables are NULL terminated
+ *  b) set up some mixers and muxes to the final state This should be normally
+ *     used to activate the mixers/muxes into their final state.
+ *     Note: table is NULL, or always terminated by NULL pointer
+ */
+struct soc_scenario {
+	const char *name;				/* scenario name */
+	const char *pin_activate[];			/* pins to activate */
+	const char *pin_deactivate[];			/* pins to deactivate */
+	const int mixes_num;				/* size of mixes[] */
+	const struct soc_scen_setup_mixmux mixes[];	/* mixers/muxes setup */
+	const char *lvol_master;			/* left volume master */
+	const char *rvol_master;			/* right volume master */
+	const char *lvol_mute;				/* left volume mute */
+	const char *rvol_mute;				/* right volume mute */
+};
+
+/**
+ * snd_soc_scenario_init - initialize soc scenarios
+ * @card: card associated to the pins/mixers/muxes/volumes/mutes
+ * @scenario: table of scenarios
+ * @num_scenarios: number of scenarios
+ *
+ * Remember, only use if hardware damage is to be prevented. See file header.
+ *
+ * Initialise the soc scenarios engine. The first scenario (0) will be used.  By
+ * default, the user could leave this scenario as non intrusive (not a single
+ * pin changed, no mixers/muxes changes, and volume master inactive).
+ */
+int snd_soc_scenario_init(struct snd_soc_card *card,
+			  struct soc_scenario *scenario, int num_scenarios);
+
+/**
+ * snd_soc_scenario_release - release soc scenarios
+ * @card: card used for the init
+ */
+void snd_soc_scenario_release(struct snd_soc_card *card);
+
+/**
+ * snd_soc_scenario_activate - activate a scenario
+ * @card: card associated to the pins/mixers/muxes/volumes/mutes
+ * @name: scenario name
+ *
+ * Activates a scenario. This is the same behaviour as through alsa control, if
+ * "SoC Mode" control was assigned a "name" value.
+ *
+ * Returns -EINVAL if name not known, or 0 upon success.
+ */
+int snd_soc_scenario_activate(struct snd_soc_card *card, char *name);
-- 
1.5.6.5
