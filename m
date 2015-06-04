From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 00/22] ASoC: tas2552: Fixes,
 cleanups and improvements
Date: Thu, 4 Jun 2015 15:34:11 +0300
Message-ID: <557045C3.2090407@ti.com>
References: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 10C9E266748
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 14:34:15 +0200 (CEST)
In-Reply-To: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 06/04/2015 03:22 PM, Peter Ujfalusi wrote:
> Hi,
> =

> I have used the TAS2552-EVM to verify that my setup is in working conditi=
on for
> a work on other audio product.
> During the bringup of the EVM I have faced some issues and limitation wit=
h the
> driver. The result is this series against the tas2552 driver.

Something messed up my branch it seams while fixing couple of checkpatch
errors... Aargh. I will resend as soon as I figure out what happened.

Sorry,
P=E9ter

> Notable changes:
> - Fixes for kernel crashes
> - The enable-gpio was not optional as it was documented in the DTS
> - Register bit definitions were not correct in several places
> - Adding recommended startup/stop sequence
> - Handling of sample formats the driver claims to support
> - PLL configuration fixes and reference clock selection
> - TDM support
> - Gain control fix and control to select DIN source
> =

> Regards,
> Peter
> ---
> Peter Ujfalusi (22):
>   ASoC: tas2552: Make the enable-gpio really optional
>   ASoC: tas2552: Fix kernel crash when the codec is loaded but not part
>     of a card
>   ASoC: tas2552: Fix kernel crash caused by wrong kcontrol entry
>   ASoC: tas2552: Correct PDM configuration register bit definitions
>   ASoC: tas2552: Correct CFG1 register bit definitions
>   ASoC: tas2552: Simplify the tas2552_mute function
>   ASoC: tas2552: Simplify and reverse the functionality of
>     tas2552_sw_shutdown
>   ASoC: tas2552: Rename mclk parameter to pll_clkin to match with the
>     datasheet
>   DT/sound: bindings header file for tas2552 codec
>   ASoC: tas2552: Add support for pll and pdm source clock selection
>   ASoC: tas2552: Correct dai format support
>   ASoC: tas2552: Correct and clean up data format and BCLK/WCLK
>     direction
>   ASoC: tas2552: Add TDM support
>   ASoC: tas2552: Clean up the Digital - Analog DAPM route definition
>   ASoC: tas2552: Correct the Speaker Driver Playback Volume (PGA_GAIN)
>   ASoC: tas2552: Implement startup/stop sequence as per TRM
>   ASoC: tas2552: Add support for word length configuration
>   ASoC: tas2552: Configure the WCLK frequency based on the stream
>   ASoC: tas2552: Add control for selecting DIN source
>   ASoC: tas2552: Correct Output Data register usage
>   ASoC: tas2552: Correct Boost Auto-Pass Through Control register usage
>   ASoC: tas2552: Code, define alignment changes for uniformity
> =

>  include/dt-bindings/sound/tas2552.h |  18 ++
>  sound/soc/codecs/tas2552.c          | 435 +++++++++++++++++++++++++++---=
------
>  sound/soc/codecs/tas2552.h          | 149 ++++++------
>  3 files changed, 431 insertions(+), 171 deletions(-)
>  create mode 100644 include/dt-bindings/sound/tas2552.h
> =
