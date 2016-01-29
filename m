From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: add cs4271 and cs4272 support
Date: Fri, 29 Jan 2016 10:10:03 -0600
Message-ID: <20160129161003.GA1079@rob-hp-laptop>
References: <1453978355-23620-1-git-send-email-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453978355-23620-1-git-send-email-eu@felipetonello.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Felipe F. Tonello" <eu@felipetonello.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Nicolin Chen <nicoleotsuka@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 28, 2016 at 10:52:35AM +0000, Felipe F. Tonello wrote:
> add cs4271 and cs42727 support for fsl-asoc-card
> 
> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
> ---
>  .../devicetree/bindings/sound/imx-audio-cs427x.txt | 47 ++++++++++++++++++++++
>  sound/soc/fsl/Kconfig                              |  4 +-
>  sound/soc/fsl/fsl-asoc-card.c                      |  7 ++++
>  3 files changed, 56 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-cs427x.txt

Acked-by: Rob Herring <robh@kernel.org>
