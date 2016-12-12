From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: atmel: tse850: rely on the ssc to register
 as a cpu dai by itself
Date: Mon, 12 Dec 2016 10:34:23 -0600
Message-ID: <20161212163423.kwlxy56ys2o2e7nn@rob-hp-laptop>
References: <1481052157-23400-1-git-send-email-peda@axentia.se>
 <1481052157-23400-3-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1481052157-23400-3-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 06, 2016 at 08:22:37PM +0100, Peter Rosin wrote:
> This breaks devicetree compatibility, but in this case that is ok. All
> affected units are either on my desk, or running an even older version
> of the driver that is not compatible with the upstreamed version anyway
> (and when these other units are eventually updated, they will get a
> fresh dtb as well, so that is not a significant problem either).

Perfect.

> All of that is of course assuming that noone else has managed to build
> something that can use this driver, but that seems extremely improbable.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../bindings/sound/axentia,tse850-pcm5142.txt      | 11 ++++++++---

Acked-by: Rob Herring <robh@kernel.org>

>  sound/soc/atmel/tse850-pcm5142.c                   | 23 +++-------------------
>  2 files changed, 11 insertions(+), 23 deletions(-)
