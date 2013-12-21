From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/10] ASoC: ARM: ux500: Better prepare for full Device
 Tree
Date: Sat, 21 Dec 2013 14:29:59 +0000
Message-ID: <20131221142959.GH30815@sirena.org.uk>
References: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 19, 2013 at 03:54:57PM +0000, Lee Jones wrote:
> At this moment in time the Ux500 ASoC driver obtains its DMA information
> via AUXDATA platform data passing. To make the driver more independent
> we have to start extracting it from the Device Tree. This patch-set goes
> some way to ensure the ux500 Audio driver is ready for the switch over.

This all looks good to me, I guess it's OK if I merge the ARM patch?
