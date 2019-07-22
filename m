From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v1 0/3] Allow reconfiguration of clock rate
Date: Mon, 22 Jul 2019 16:24:00 +0900
Message-ID: <20190722072403.11008-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com
Cc: twischer@de.adit-jv.com, jiada_wang@mentor.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

There is use case in Gstreamer ALSA sink, in case of changed caps
Gsreatmer reconfigs and it calls snd_pcm_hw_free() before snd_pcm_prepre().
See gstreamer1.0-plugins-base/
gst-libs/gst/audio/gstaudiobasesink.c: gst_audio_base_sink_setcaps():
- gst_audio_ring_buffer_release()
- gst_audio_sink_ring_buffer_release()
- gst_alsasink_unprepare()
- snd_pcm_hw_free()
is called before
- gst_audio_ring_buffer_acquire()
- gst_audio_sink_ring_buffer_acquire()
- gst_alsasink_prepare()
- set_hwparams()
- snd_pcm_hw_params()
- snd_pcm_prepare()

But with current implementation after clock rate is started in .prepare
reconfiguration of clock rate is not allowed, unless the stream is stopped.

This patch set by move stop of clock to .hw_free callback,
to allow reconfiguration of clock rate.

Jiada Wang (1):
  ASoC: rsnd: call .hw_{params,free} in pair for same stream

Timo Wischer (2):
  ASoC: rsnd: Support hw_free() callback at DAI level
  ASoC: rsnd: Allow reconfiguration of clock rate

 sound/soc/sh/rcar/core.c | 22 +++++++++++++--
 sound/soc/sh/rcar/rsnd.h | 36 ++++++++++++++++++++----
 sound/soc/sh/rcar/ssi.c  | 61 +++++++++++++++++++++++++++++-----------
 sound/soc/sh/rcar/ssiu.c |  3 +-
 4 files changed, 96 insertions(+), 26 deletions(-)

-- 
2.19.2
