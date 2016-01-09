From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 5/5] dt-bindings: bsm2835: fix bindings documentation to
 use new clock framework
Date: Sat, 9 Jan 2016 16:45:23 -0600
Message-ID: <20160109224523.GA17329@rob-hp-laptop>
References: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org>
 <1452331558-2520-6-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452331558-2520-6-git-send-email-kernel@martin.sperl.org>
Sender: linux-clk-owner@vger.kernel.org
To: kernel@martin.sperl.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Remi Pommarel <repk@triplefau.lt>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Matthias Reichl <hias@horus.com>, lFlorian Meier <florian.meier@koalo.de>
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 09, 2016 at 09:25:57AM +0000, kernel@martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> The bcm2835-i2s driver has been updated to use the new clock framework
> for the bcm2835 SOC.

You are breaking compatibility with the driver change. New kernels will 
not work with old dtbs as you have found. What should be done is fix the 
driver to work with the old and new dtb.
 
> This patch documents the required changes to the bindings.
> 
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

But I leave it to platform maintainers to decide if breaking 
compatibility is okay, so:

Acked-by: Rob Herring <robh@kernel.org>
