From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [RFC] sound: ASoC: multiple DAIs/codecs on single audio stream
Date: Tue, 16 Apr 2013 19:45:08 +0200
Message-ID: <516D8E24.9020308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Russell King <linux@arm.linux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I am rewriting Marvell Kirkwood/Dove audio driver and I am having
a hard time to match the controllers features to ASoC API.

The controller has a dma controller for one playback buffer. It can
play the stream to both I2S and SPDIF interfaces with independent mute.

Now, for example, I have a board with i2s codec and spdif tx diode
connected to the above controller:

DMA (platform) -+-> I2S (dai) ----> I2S_Codec (codec)
                 |
                 +-> SPDIF (dai) --> SPDIF_TX (codec)

Is there any way in the current ASoC API to have the above setup?

I tried to attach two codecs to a single DAI and that will already
create two playback streams with two buffers. I guess it will also
happen if I have two DAIs connected to the same platform driver?

For an API for SoC audio, shouldn't there be some relation between
platform, DAI, and codec, e.g.:
- a platform represents a single audio stream buffer
- a platform can be attached to one or more DAIs,
- a DAI can be attached to one codec only

Regards,
   Sebastian
