From: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Subject: [PATCH v14 0/8] ASoC: sun4i-codec: Add Line-In, FM-In,
 Mic 2, Capture Source, Differential Line-In
Date: Wed,  2 May 2018 23:07:52 +0200
Message-ID: <20180502210800.1971-1-dannym@scratchpost.org>
Reply-To: dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCPKHTHNWIPBBQORVDLQKGQEGUXU3ZQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>, Andrea Bondavalli <andrea.bondavalli74-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patchset adds some mixer controls to sun4i-codec for the Allwinner A10
and the Allwinner A20.

It also adds a mux for the capture source and the PGA for the MIC2 preamp.

Where possible, it uses SOC_DAPM_DOUBLE in order to cut down on the number
of distinct controls in alsamixer.

v14 changes compared to v13 are:
 - Merged some of the patches together if it made sense to test them together.
 - Use snd_soc_component_driver.
 - Moved SUN4I_CODEC_DAC_ACTL_LFMS, SUN4I_CODEC_DAC_ACTL_RFMS to the correct
   patch in the series.
 - Kept "Left Mixer Left DAC Playback Switch", "Right Mixer Left DAC
   Playback Switch" and "Right Mixer Right DAC Playback Switch" unchanged
   compared to the released version - for backward compatibility.

v13 changes compared to v12 are:
 - Added my "Signed-off-by".
 - Clarified some commit message text.

v12 changes compared to v11 are:
 - Split up patchset in another way.
 - Renamed "Mic1 Capture Volume" to "Mic1 Boost Volume".
 - Renamed "Mic2 Capture Volume" to "Mic2 Boost Volume".
 - Renamed "Line Capture Volume" to "Line Boost Volume".
 - Renamed "Differential Line Capture Switch" to "Differential Line Source".

v11 changes compared to v10 are:
 - Split up patchset.
 - Fixed typo in Differential Line Capture Switch.
 - Renamed "Non-Differential" value to "Stereo".
 - Removed duplicate PA Volume mixer control.

v10 changes compared to v9 are:
 - Use SOC_DAPM_DOUBLE where possible and it makes sense in order to cut
   down on the number of controls.

v9 changes compared to v8 are:
 - added Line Differential Capture Switch.
 - split Capture Source into Left Capture Select, Right Capture Select.
 - added Line Capture Volume.
 - rename "sun4i_codec_widgets" to "sun4i_codec_controls" for 
   consistency with the struct field it's used in.
 - rename "Line-In" to "Line".
 - rename "Power Amplifier Playback Volume" to "Headphone Playback Volume".

v8 changes compared to v7 are:
 - fixed the routes for line and mic capturing.

v7 changes compared to v6 are:
 - preparation for different A20, A10 controls is now in an extra patch.
 - all register definitions are now at the top.
 - sun7i-specific things (A20-specific things) are now less
   grouped-together.
 - rename "Power Amplifier Volume" to "Power Amplifier Playback Volume".

v6 changes compared to v5 are:
 - Mic preamplifier special cases for A20 and A10 now are now not
   icky: There are two different _widget arrays and the probe() function
   now selects the right one to pass to snd_soc_register_codec() unmodified.
 - sun7i-specific things (A20-specific things) are now grouped together.

v5 changes compared to v4 are:
 - Mic preamplifier controls have more common names now.
 - Mic preamplifier scale has a 0 dB entry as well now, as documented in the 
   A20 user manual.
 - Mic preamplifier has special cases for A20 and A10 now.
 - Gain controls have "Gain" in the name now.

v4 changes compared to v3 are:
 - names of the input are not uppercase anymore.
 - bit index constants are now named as in the A20 user manual v1.4.
 - added Mic1-In, Mac2-In.
 - added Mic1 and Mic2 Pre-Amplifiers.

v3 changes compared to v2 are:
 - added DAPM routes.

v2 changes compared to v1 are:
 - moved Line-In and FM-In playback switches to their respective 
   sun4i_codec_*_mixer_controls.

v1 changes:
 - added linein, fmin output volumes and switches.

Danny Milosavljevic (8):
  ASoC: sun4i-codec: Add MIC2 Pre-Amplifier, Mic2, Mic Playback Volume
  ASoC: sun4i-codec: Add Mic1 Boost Volume, Mic2 Boost Volume
  ASoC: sun4i-codec: Merge sun4i_codec_left_mixer_controls and
    sun4i_codec_right_mixer_controls into sun4i_codec_mixer_controls.
  ASoC: sun4i-codec: Add Mic1 Playback Switch, Mic2 Playback Switch.
  ASoC: sun4i-codec: Add FM Playback Volume, FM Left, FM Right, FM
    Playback Switch
  ASoC: sun4i-codec: Add Line Playback Volume, Line Boost Volume, Line
    Right, Line Left, Line Playback Switch
  ASoC: sun4i-codec: Add Differential Line Source.
  ASoC: sun4i-codec: Add Left Capture Select, Right Capture Select.

 sound/soc/sunxi/sun4i-codec.c | 233 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 209 insertions(+), 24 deletions(-)
