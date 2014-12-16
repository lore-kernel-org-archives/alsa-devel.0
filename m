From: Dylan Reid <dgreid@google.com>
Subject: Streaming wake-up buffer from DSP to SoC over SPI
Date: Mon, 15 Dec 2014 18:45:37 -0800
Message-ID: <CAEUnVG6n15vNYgZoZXzRZvgAqej1Lb3bHDEy9cyQ+UCJbuv2kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 by alsa0.perex.cz (Postfix) with ESMTP id CBBFE26055F
 for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2014 03:45:58 +0100 (CET)
Received: by mail-oi0-f51.google.com with SMTP id e131so9035285oig.24
 for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2014 18:45:57 -0800 (PST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

What is the right way to model a bursty, SPI based audio transfer?
There could be hours between samples, then several seconds of audio
will be ready.

The codec, an rt5677, is attached to the SoC with both an IIS bus and
a SPI bus.  The IIS bus is used for normal audio playback and record.
The SPI bus is used for transferring audio that caused a voice wake,
"OK Google" in this case.

When the codec detects the wake up phrase, the SoC will read out two
plus seconds of buffered data over the SPI bus and continue to stream
audio data over SPI for the rest of the query.  Nexus 9 has a custom
ioctl to access rt5677-spi and some user-space smarts to poll for more
data.

I was thinking of making a separate PCM device.  The odd things are
that it would have to originate from soc/codecs, the codec would own
the codec and cpu end of the link, and the hw_ptr position would need
to be queried over SPI.  But it would make userspace access to it more
standard looking.

Thanks for any opinions or thoughts.

Dylan
