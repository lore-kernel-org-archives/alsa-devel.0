From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4] ASoC: Add support for Maxim Integrated MAX98927
 Amplifier
Date: Mon, 3 Apr 2017 11:30:53 -0500
Message-ID: <20170403163053.u6b3yadkfyh4z7h5@rob-hp-laptop>
References: <1490922994-19294-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1490922994-19294-1-git-send-email-ryans.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Lee <ryans.lee@maximintegrated.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com, arnd@arndb.de, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, bardliao@realtek.com, nh6z@nh6z.net, KCHSU0@nuvoton.com, axel.lin@ingics.com, romain.perier@collabora.com, srinivas.kandagatla@linaro.org, oder_chiou@realtek.com, Paul.Handrigan@cirrus.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dgreid@google.com, ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 31, 2017 at 10:16:34AM +0900, Ryan Lee wrote:
> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
> ---
> 
> Changes since v4:
> 	* Removed support for SND_SOC_DAIFMT_CBS_CFM.
> 	* Fixed coding style for indention.
> 	* Removed variables if it has only one user.
> 	* Assigned ch_size directly.
> 	* Removed oring.
> 	* Put the return false in the switch statement.
> 	* Removed 'Monomix Output' and 'Speaker Source' controls.
> 	* Modified control names per control-names.rst.
> 	* Moved Revision ID check code to i2c_probe function.
> 	* Added 'Current Limit' control.
> 	* Removed 'devm__kfree' function.
> 
> Changes since v3:
> 	* Combined MAX98926 and MAX98927 binding. Kept existing property name.

This looks fine, but:
 
> Changes since v2:
> 	* Removed local register read/write function to avoid duplication of ASoC core function.
> 
>  .../devicetree/bindings/sound/max98925.txt         |  22 -
>  .../devicetree/bindings/sound/max98926.txt         |  32 -
>  .../devicetree/bindings/sound/max9892x.txt         |  41 +
>  sound/soc/codecs/Kconfig                           |   5 +
>  sound/soc/codecs/Makefile                          |   2 +
>  sound/soc/codecs/max98927.c                        | 841 +++++++++++++++++++++
>  sound/soc/codecs/max98927.h                        | 272 +++++++
>  7 files changed, 1161 insertions(+), 54 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/max98925.txt
>  delete mode 100644 Documentation/devicetree/bindings/sound/max98926.txt
>  create mode 100755 Documentation/devicetree/bindings/sound/max9892x.txt
>  mode change 100644 => 100755 sound/soc/codecs/Kconfig
>  mode change 100644 => 100755 sound/soc/codecs/Makefile
>  create mode 100755 sound/soc/codecs/max98927.c
>  create mode 100755 sound/soc/codecs/max98927.h

These should all be 644 mode.

Rob
