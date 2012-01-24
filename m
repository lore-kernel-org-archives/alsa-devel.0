From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Hang up at .prepare( )
Date: Tue, 24 Jan 2012 18:38:45 +0900
Message-ID: <CANKRQngqJaAq7ucg3VzCMs+-KFXTSuJG=uq4d0kQ95gEMFfB4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Mike Frysinger <vapier@gentoo.org>, Daniel Mack <zonque@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi

I've started debugging our ASoC drivers.
I've faced issue when installing these drivers,
system becomes hang up at async_synchronize_full_domain() of
dapm_power_widgets()
in .prepare().

Do you have any information about this hang up ?

I show details below.

======Details============

 * Procedure
install codec-driver
install platform-driver
install machine driver

echo ml26124 0x1A > /sys/bus/i2c/devices/i2c-1/new_device
After this command,
occur system hang up within a few seconds

 * Call Trees

platform-driver:.open()
machine-driver:.hw_params()
codec-driver:.hw_params()
platform-driver:.dai_hw_params()
platform-driver:.hw_params()
platform-driver:.prepare()
platform-driver:.dai_digital_mute()
platform-driver:.prepare()
platform-driver:.dai_digital_mute()

platform-driver:.open()
machine-driver:.hw_params()
codec-driver:.hw_params()
platform-driver:.dai_hw_params()
platform-driver:.hw_params()
platform-driver:.prepare()
platform-driver:.dai_digital_mute()
platform-driver:.prepare()
platform-driver:.dai_digital_mute()
platform-driver:.hw_free
platform-driver:.dai_hw_free
platform-driver:.hw_free
platform-driver:.dai_hw_free
platform-driver:.close()

platform-driver:.open()
machine-driver:.hw_params()
codec-driver:.hw_params()
platform-driver:.dai_hw_params()
platform-driver:.hw_params()
platform-driver:.prepare()
platform-driver:.dai_digital_mute()
platform-driver:.prepare()
platform-driver:.dai_digital_mute()
platform-driver:.hw_free
platform-driver:.dai_hw_free
platform-driver:.hw_free
platform-driver:.dai_hw_free
platform-driver:.close()
platform-driver:.hw_free
platform-driver:.dai_hw_free
platform-driver:.hw_free
platform-driver:.dai_hw_free
platform-driver:.close()
platform-driver:.dai_digital_mute()

platform-driver:.open()
machine-driver:.hw_params()
codec-driver:.hw_params()
platform-driver:.dai_hw_params()
platform-driver:.hw_params()
platform-driver:.prepare()
platform-driver:.dai_digital_mute()
platform-driver:.prepare()
platform-driver:.dai_digital_mute()

platform-driver:.open()
machine-driver:.hw_params()
codec-driver:.hw_params()
platform-driver:.dai_hw_params()
platform-driver:.hw_params()
platform-driver:.prepare()
platform-driver:.dai_digital_mute()
platform-driver:.prepare()
platform-driver:.dai_digital_mute()
platform-driver:.hw_free
platform-driver:.dai_hw_free
platform-driver:.hw_free
platform-driver:.dai_hw_free
platform-driver:.close()

platform-driver:.open()
machine-driver:.hw_params()
codec-driver:.hw_params()
platform-driver:.dai_hw_params()
platform-driver:.hw_params()
platform-driver:.prepare()

==> Occur system hang up.

According to system log,
the hang up seems occuring at async_synchronize_full_domain(),
which is at soc_pcm_prepare -> soc_dapm_stream_event ->
dapm_power_widgets -> async_synchronize_full_domain [2nd call]

 * Test condition
CPU=Intel Atom E6xx series
IOH=LAPIS Semiconductor ML7213
Fedora15
Kernel=3.2

thanks in advance.
tomoya
