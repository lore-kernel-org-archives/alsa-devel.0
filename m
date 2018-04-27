From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: tas6424: Add support for the standby pin
Date: Fri, 27 Apr 2018 15:13:59 -0500
Message-ID: <20180427201359.pl2artabp23eimcc@rob-hp-laptop>
References: <1524837349-16350-1-git-send-email-jjhiblot@ti.com>
 <1524837349-16350-2-git-send-email-jjhiblot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1524837349-16350-2-git-send-email-jjhiblot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: broonie@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, dannenberg@ti.com, afd@ti.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 27, 2018 at 03:55:47PM +0200, Jean-Jacques Hiblot wrote:
> The standby pin can be connected to a GPIO. In that case we have to drive
> it to the correct values for the TAS6424 to operate properly.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
> ---
>  .../devicetree/bindings/sound/ti,tas6424.txt       |  1 +
>  sound/soc/codecs/tas6424.c                         | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
