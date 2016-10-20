From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [alsa-devel] [RFC PATCH 2/2] ASoC: samsung: Print a one-time
 message if the snow driver's probe defers
Date: Thu, 20 Oct 2016 11:12:49 +0200
Message-ID: <29147d0b-ecf7-726a-b12b-f93d548f0c99@samsung.com>
References: <1476897666-13974-1-git-send-email-javier@osg.samsung.com>
 <CGME20161019181043eucas1p2d52e28825ae57bbfd19c6d290c6ceb05@eucas1p2.samsung.com>
 <1476897666-13974-3-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1476897666-13974-3-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 10/19/2016 07:21 PM, Javier Martinez Canillas wrote:
> If the snd_soc_register_card() fails due a missing resource and the probe
> has to be deferred, the driver prints an error message.
> 
> But since many probe retries can happen before a resource is available,
> the printed messages can spam the kernel log buffer and slow the boot.

Do you know why CPU DAI is not registered by the time snow machine
driver gets probed? Did you try to debug the I2S driver? Does perhaps
deferring happen due to some I2S clocks missing? DMA seems to be
already initialized.
The deferral loop looks suspicious, do you perhaps know what commits
in v4.8 cause such changes in probing order? Did you start to use
some drivers as loadable module?

As far as the error log is concerned, I would just not print anything
in snow_probe() when register_card() returns EPROBE_DEFER.

-- 
Thanks,
Sylwester
