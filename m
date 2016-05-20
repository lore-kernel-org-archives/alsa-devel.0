From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [RFC-PATCH 0/2] ASoC: simple_card: support for hw-params rules
Date: Fri, 20 May 2016 12:30:43 +0000
Message-ID: <1463747445-14167-1-git-send-email-kernel@martin.sperl.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Simple_card does require under some circumstances the ability
to configure certain hw_parameters based on clocks, bits, channels.

This patchset adds a generic way to configure these kind of things
via the device tree easily. This patchset implements this
for simple_card, but other drivers can just as easily make use of
this.

For now we have the following matchers and actions:
* matchers:
  * match_sample_bits
  * match_rate
  * match_channels
* actions:
  * set_fixed_bclk_size

As a note: the available matching rules and action rules right now
are hard-coded, but this could in principle get extended to be more
dynamic via kallsyms_lookup_name that would lookup the requested
symbol and assume it is a struct asoc_generic_hw_params_method,
on which it could apply several sanity-checks before using
the pointers for real.

This would allow other kinds of action methods to get exposed in
codec-drivers, that can then get used to handle some settings
specific to the codec.

I leave this is an exercise for later...

Martin Sperl (2):
  ASoC: hw-params-rules: add generic hw_params-rules
  ASoC: simple_card: add support for hw_params_rules

 .../devicetree/bindings/sound/hw-params-rules.txt  |  86 +++++
 .../devicetree/bindings/sound/simple-card.txt      |   1 +
 sound/soc/generic/Kconfig                          |   6 +
 sound/soc/generic/Makefile                         |   2 +
 sound/soc/generic/hw-params-rules.c                | 402 +++++++++++++++++++++
 sound/soc/generic/hw-params-rules.h                |  49 +++
 sound/soc/generic/simple-card.c                    |  11 +-
 7 files changed, 554 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/hw-params-rules.txt
 create mode 100644 sound/soc/generic/hw-params-rules.c
 create mode 100644 sound/soc/generic/hw-params-rules.h

--
2.1.4
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
