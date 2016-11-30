From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [RFC] ASOC: HDMI audio info frame speaker allocation
Date: Wed, 30 Nov 2016 18:54:32 +0100
Message-ID: <5007d5a5-1f3b-b7ae-f923-43e839be381e@st.com>
References: <1480325634-23320-1-git-send-email-arnaud.pouliquen@st.com>
 <1480325634-23320-2-git-send-email-arnaud.pouliquen@st.com>
 <b6cf1216-7408-584f-6966-2d2a7cb20df3@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 07684266912
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2016 18:54:40 +0100 (CET)
In-Reply-To: <b6cf1216-7408-584f-6966-2d2a7cb20df3@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Vinod Koul <vinod.koul@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hello,

I'm trying to understand how to implement the speaker allocation for
HDMI output.

input:
 - HDMI sink provides the speaker presence in ELD structure
 - audio source can also contain channels position.

output:
 Audio info frame (IF) should contain audio channel allocation (
hdmi_audio_infoframe structure).

So if i well understand the concept, application should be in charge of
aligning channels with HDMI sink speakers...

Regarding HDA driver, audio IF channel allocation is computing based on
"Playback Channel Map"control . Application set the speaker information
of the audio IF through this control.

On ASOC side, in hdmi-codec,
 -'ELD" control exists  to export speaker information to application
 - info frame channel allocation is hardware coded in
hdmi_codec_hw_params. The configuration is set by default depending on
the number of channels. Drawback is that application is not aware of the
configuration selected by the driver.

So it seems that something is missing to do the link between EDID
information and audio source channel mapping on one side and audio IF
configuration on other side.

What should be the best strategy to support feature in ASoC?
- No update in hdmi-codec, consider that application should know
the configuration available for 2,4,6 and 8 channels
  => seems not very flexible...

- Update hdmi-codec to implement "Playback Channel Map" in read-only, to
provide channel mapping information to application.
 => impact is light, but application can get the correct mapping only
after the update of the number of channels (so after hw_params ops call)

- Update hdmi-codec to implement "Playback Channel Map" in read and
write access.
 => HDA implementation. Seems the more flexible solution from my windows...

- Implement control in drm drivers
  => seems not reasonable.

- Other?

Thanks in advance for your answers.

Regards
Arnaud
