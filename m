From: Peter Rosin <peda@axentia.se>
Subject: RE: [PATCH] ASoC: pcm512x: Remove hardcoding of pll-lock to GPIO4
Date: Tue, 24 Mar 2015 07:52:59 +0000
Message-ID: <80347e73030a4e31b9765defd4f6ff5a@EMAIL.axentia.se>
References: <1427145421-5544-1-git-send-email-hm@hmbedded.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427145421-5544-1-git-send-email-hm@hmbedded.co.uk>
Content-Language: sv-SE
Sender: linux-kernel-owner@vger.kernel.org
To: Howard Mitchell <hm@hmbedded.co.uk>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Howard Mitchell wrote:
> Currently GPIO4 is hardcoded to output the pll-lock signal.
> Unfortunately this is after the pll-out GPIO is configured which
> is selectable in the device tree. Therefore it is not possible to
> use GPIO4 for pll-out. Therefore this patch removes the
> configuration of GPIO4.

Howard, thanks for picking up my laundry!

Is master mode working for you otherwise? Have you seen any sign
of bad dividers for the various clocks, or anything like that?

Regarding the pin configuration, I suppose the cleanest approach
would be to implement it as a pin control driver? Then you could
also expose the pins as gpios and  select the pin functions in a more
standard way, right? I wouldn't know where to start with that
though. I have the feeling that it would also mean that there would
have to be a mfd driver for the chip???

However, there is the issue that we don't need anything more from
the chip, so we're happy with the driver as is (assuming the overclocking
patch goes in as planned for 4.1).

Cheers,
Peter
