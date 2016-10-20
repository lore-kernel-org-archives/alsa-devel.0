From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [alsa-devel] [RFC PATCH 2/2] ASoC: samsung: Print a one-time
 message if the snow driver's probe defers
Date: Thu, 20 Oct 2016 07:41:57 -0300
Message-ID: <06ba6563-2792-cb08-694e-4582618ae7fb@osg.samsung.com>
References: <1476897666-13974-1-git-send-email-javier@osg.samsung.com>
 <CGME20161019181043eucas1p2d52e28825ae57bbfd19c6d290c6ceb05@eucas1p2.samsung.com>
 <1476897666-13974-3-git-send-email-javier@osg.samsung.com>
 <29147d0b-ecf7-726a-b12b-f93d548f0c99@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <29147d0b-ecf7-726a-b12b-f93d548f0c99@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hello Sylwester,

Thanks a lot for your feedback.

On 10/20/2016 06:12 AM, Sylwester Nawrocki wrote:
> On 10/19/2016 07:21 PM, Javier Martinez Canillas wrote:
>> If the snd_soc_register_card() fails due a missing resource and the probe
>> has to be deferred, the driver prints an error message.
>>
>> But since many probe retries can happen before a resource is available,
>> the printed messages can spam the kernel log buffer and slow the boot.
> 
> Do you know why CPU DAI is not registered by the time snow machine
> driver gets probed? Did you try to debug the I2S driver? Does perhaps
> deferring happen due to some I2S clocks missing? DMA seems to be
> already initialized.
> The deferral loop looks suspicious, do you perhaps know what commits

It's suspicious indeed and I've been trying to figure out what changed
the behavior in v4.8 but I haven't found it yet.

> in v4.8 cause such changes in probing order? Did you start to use

I did a git bisect to find the first v4.8 commit that caused this but
finished in a merge commit c9b95e5961c0 ("Merge tag 'sound-4.8-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound").

That branch alone works the same than v4.7 so it seems that is not a
single commit but a combination from different branches that caused
this on integration.

> some drivers as loadable module?
>

I see no relevant changes in exynos_defconfig between v4.7..v4.8 and
also no changes in drivers/Makefile that could cause things to be
initialized on a different order.

But I thought the patches had merits on its own since probe deferral
can make a driver probe many times and the error logs were noisy. I
wasn't sure though and that's why are marked as RFC.

> As far as the error log is concerned, I would just not print anything
> in snow_probe() when register_card() returns EPROBE_DEFER.
> 

I believe it may be useful to know that a driver's probe is deferring due
a missing dependency but have no strong opinion and can remove the message.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
