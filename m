From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7] ASoC: cs53l30: Add codec driver support for Cirrus
 CS53L30
Date: Wed, 1 Jun 2016 09:34:47 -0500
Message-ID: <20160601143447.GA25924@rob-hp-laptop>
References: <1464205114-17202-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464205114-17202-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: broonie@kernel.org, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, lgirdwood@gmail.com, Tim.Howe@cirrus.com, somduttar@nvidia.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 25, 2016 at 12:38:34PM -0700, Nicolin Chen wrote:
> CS53L30 is a Quad-Channel ADC from Cirrus Logic with an I2S/TDM DAI.
> So this patch adds a codec driver for CS53L30 that includes 4-channel
> 24-bit recording and TDM mode supports.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> Changelog:
> v6->v7
>  * Added vendor prefixes to properties in DT binding doc
>  * Updated the property names in the driver accordingly
>  * Added two required power supplies in the example
>  * Refined two dev_err messages
>  * Re-ordered the header files
>  * Revised the commit log
> v5->v6
>  * Added clock controls
>  * Reconstructed bitfield macros and improved coding style
>  * Fixed some misuses of regmap_update_bits()
>  * Added TLV volume controls to replace enums for preamplifier
>  * Added micbias level in DT instead of exposing to user-space
>  * Simplified SDOUTx controls by removing cs53l30_asp_sdout_event()
>    (Still be able to use set_tristate() instead)
>  * Removed useless header files and sort the rest alphabetically
>  * Registered runtime pm functions to the driver
>  * Added regulator controls (VA and VP)
>  * Added writeable register function for regmap
>  * Merged two ASP dais
>  * Added TDM support
>  * Added a simple introduction in commit log
> 
>  .../devicetree/bindings/sound/cs53l30.txt          |   40 +

Acked-by: Rob Herring <robh@kernel.org>

>  sound/soc/codecs/Kconfig                           |    6 +
>  sound/soc/codecs/Makefile                          |    2 +
>  sound/soc/codecs/cs53l30.c                         | 1097 ++++++++++++++++++++
>  sound/soc/codecs/cs53l30.h                         |  458 ++++++++
>  5 files changed, 1603 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/cs53l30.txt
>  create mode 100644 sound/soc/codecs/cs53l30.c
>  create mode 100644 sound/soc/codecs/cs53l30.h
