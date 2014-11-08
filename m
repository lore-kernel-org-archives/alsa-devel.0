From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 0/3] ASoC: twl4030: support routine to external VOICE source.
Date: Sat, 08 Nov 2014 11:38:03 +1100
Message-ID: <20141108002637.6561.19002.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The 'voice' port of the twl4030 on my board is connected to
a GSM modem, not to the CPU.  As such it is not visible to ASLA
and normal approaches to configuring the interface (as one end of a
DAI) don't apply.

I need a way to tell the twl4030 that the connected device will
be master of 'clk' and 'FRM', and whether they are inverted.
Using device tree seems the correct approach - I am describing the
properties of the hardware attached the 'voice' port.

Using magic numbers from include/sound/soc-dai.h almost certainly
is not the right way to represent this information, but it isn't clear
to me what a good way would be.

So the current patch uses magic numbers as a proof of concept, and I'm
asking if there is any establish precedent, or any suggestions on
how to record in device tree the 'master' and 'polarity' of CLK and
FRM signals for an external device.
[I currently use (SND_SOC_DAIFMT_IB_NF | SND_SOC_DAIFMT_CBS_CFS)]

This is in the second patch.  The first silences a pointless warning
(when it is pointless) and the last allowed the voice linked to be
turned on or off via ALSA controls.

If the first and last can be applied without finalizing the
device-tree part yet, that would be great.

Thanks,
NeilBrown

---

NeilBrown (3):
      ASoC: twl4030: don't report EBUSY if no change requested.
      ASoC: twl4030: allow voice port to be connected externally.
      ASoC: twl4030: enable routing audio to 'voice' interface.


 .../devicetree/bindings/mfd/twl4030-audio.txt      |    7 ++
 include/linux/i2c/twl.h                            |    3 +
 sound/soc/codecs/twl4030.c                         |   78 ++++++++++++++++++--
 3 files changed, 82 insertions(+), 6 deletions(-)

--
Signature

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
