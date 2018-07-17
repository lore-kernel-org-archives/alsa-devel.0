From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 00/15] ASoC: meson: add axg audio subsystem support
Date: Tue, 17 Jul 2018 17:38:47 +0200
Message-ID: <1531841927.26720.18.camel@baylibre.com>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717153643.8806-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2018-07-17 at 17:36 +0200, Jerome Brunet wrote:
> This patchset adds support for the audio subsystem found on Amlogic's
> axg SoC family. The first SoC of this family is the A113D/X targeted
> at smart speaker application. The G12a SoC family, Amlogic next-gen
> STB chipset, will reuse this audio subsystem with a few changes.
> 
> This patchset implements the DPCM machine driver and the different
> components it made of. Several components are still missing, such
> spdif input and pdm, and will submitted later on.
> 
> The fancier part of this patchset is probably around the TDM. Properly
> modeling the SoC architecture and its capatilities made things a little
> more complex than usual (details in the related commit descriptions)
> 
> If necessary, this patchset could broken into smaller series. For the
> intial submission, I wanted to give a global view of the subsystem.
> Hopefully, it will make it a bit easier to understand.
> 
> Jerome Brunet (15):
>   ASoC: meson: add axg fifos DT binding documentation
>   ASoC: meson: add axg fifo base driver
>   ASoC: meson: add axg frddr driver
>   ASoC: meson: add axg toddr driver
>   ASoC: meson: add axg spdif output DT bindings documentation
>   ASoC: meson: add axg spdif output
>   ASoC: meson: add axg tdm formatters DT bindings documentation
>   ASoC: meson: add axg tdm interface DT bindings documentation
>   ASoC: meson: add tdm formatter base driver
>   ASoC: meson: add tdm interface driver
>   ASoC: meson: add tdm output driver
>   ASoC: meson: add tdm input driver
>   ASoC: export snd_soc_of_get_slot_mask
>   ASoC: meson: add axg sound card DT bindings documentation
>   ASoC: meson: add axg sound card support
> 

Really sorry for the noise, messed up with format-patch.
Please ignore this series. I will resend it
