From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [RFC] ALSA scenario API
Date: Wed, 17 Oct 2007 01:12:13 +0100
Message-ID: <1192579933.12060.772.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B7A624513
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Oct 2007 02:12:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leijin Tang <Leijin.Tang@access-company.com>, alsa-devel <alsa-devel@alsa-project.org>, ohm-devel <ohm-devel@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

A little late with this but "better late than never".....I did promise a
few people that I would post what was imho needed for ALSA scenarios.

Also, apologies for cross posting, but it some of this probably applies
to both lists... 

ALSA probably needs functionality to define and set audio usage
scenarios. A scenario is simply a list of sound card mixer settings for
a given use case. This is quite important for mobile devices (e.g.
Smartphones, GPS, PDA, etc) with complex audio routing and power
requirements. Some example scenarios could be :-

"HiFi Headphone Playback"
"HiFi Speaker Playback"
"Handset Phone Call"
"Headset Phone Call"
etc...

Scenarios are changed atm by either manually setting each control (e.g.
using alsamixer or alsa-lib in apps) or by using alsactl to restore a
scenario. The above two methods are not very portable between devices
and applications. We would ideally like to just say "set Phone Call
Handset" for a regular handset phone call or "set HiFi Headphones" for
MP3 playback.

ALSA also needs to have functionality to alias mixer controls. This
would allow a single master volume/mute control to be exposed to user
space and have it aliased to different hardware controls based upon the
current scenario. e.g. Many mobile devices have different physical
volume controls for speaker and headphones. This makes it somewhat
difficult for user space apps to change the correct volume (without
being bound to the hardware). We would like to be able to just say "set
volume to 0dB" and have the alias take care of the correct physical
CODEC mixer for the current scenario.

Proposal:
========

1. Add some new scenario functions to (s)alsa-lib. e.g.

snd_scenario_set();
snd_scenario_get();
snd_scenario_list();

_set() would set the scenario e.g.

snd_scenario_set(card, SND_VOICE_CALL_HANDSET);

We would need to have a list of standard scenarios so that applications
could be more portable. Vendor scenario's should also be supported.

_get() would return the current scenario.

_list() would return a list of supported scenarios for the given device.


2. Add some new mixer alias functions to set/get the current "master"
volume/mute. e.g.

snd_kcontrol *snd_scenario_volume_set(card, type, volume);
snd_kcontrol *snd_scenario_switch_set(card, type, switch);

where type is playback, capture, sidetone, bypass, etc

This would set the volume for the current scenario and would guarantee
always to get/set the _correct_ volume/switch.

3. Add a new function to return the active PCM for a given scenario.
e.g.

snd_scenario_get_pcm(card, scenario);

Would return the given PCM for a particular scenario. i.e. the WM9713
driver has PCM 0.0 for high quality (higher power) audio (MP3), PCM 0.1
for lower power voice and PCM 0.2 for lowest power and quality system
sounds.

Note: scenarios may need to be more tightly bound to PCM's rather than
cards. 

4. Define a file format to represent each scenario. Probably base this
upon alsactl's format as alsamixer could be used to quickly generate
good settings and then save them with alsactl. Alias, scenario names and
PCM would need to be added later somehow.

5. (Optional) Allow scenarios to define active kcontrols. This would
allow tools like alsamixer to only display mixer controls for the given
scenario. Controls that don't effect the scenario would not be rendered.
(similar to alsamixers Playback|Capture|All tab)

6. (OHM list) Add input driver (or similar) for sound card user events.
We need to be able to send events like "Headphone Jack Insertion", "Mic
Jack Insertion", etc to user space. This would allow changing of
scenario and power configuration depending on policy and configuration. 

Just my 2p

Unfortunately I'm not in a position to implement any of this
functionality. However, it's probably useful to folks working on mobile
devices. Maybe a good project for Google SoC.

HTH

Liam
