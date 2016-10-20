From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [alsa-devel] [RFC PATCH 2/2] ASoC: samsung: Print a one-time
 message if the snow driver's probe defers
Date: Thu, 20 Oct 2016 13:27:09 +0200
Message-ID: <7a730a84-ce97-2148-87d9-64211a1aaa6b@samsung.com>
References: <1476897666-13974-1-git-send-email-javier@osg.samsung.com>
 <CGME20161019181043eucas1p2d52e28825ae57bbfd19c6d290c6ceb05@eucas1p2.samsung.com>
 <1476897666-13974-3-git-send-email-javier@osg.samsung.com>
 <29147d0b-ecf7-726a-b12b-f93d548f0c99@samsung.com>
 <06ba6563-2792-cb08-694e-4582618ae7fb@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <06ba6563-2792-cb08-694e-4582618ae7fb@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 10/20/2016 12:41 PM, Javier Martinez Canillas wrote:
> I see no relevant changes in exynos_defconfig between v4.7..v4.8 and
> also no changes in drivers/Makefile that could cause things to be
> initialized on a different order.

I remember this

commit 6eb1c9496b81680f2cd2e0eda06c531317e2e28d
clk: probe common clock drivers earlier

going in recently, but it's rather dubious it could cause such trouble.

Anyway, I'd try to add some debug prints to samsung_i2s_probe() to see
what's the issue with the CPU DAI registration.

> But I thought the patches had merits on its own since probe deferral
> can make a driver probe many times and the error logs were noisy. I
> wasn't sure though and that's why are marked as RFC.

In general I wouldn't be disabling those err logs unless proper
EPROBE_DEFER handling is added on related error paths and we can
differentiate between probe deferral and real unrecoverable errors
and can disable logging only for EPROBE_DEFER cases.

>> As far as the error log is concerned, I would just not print anything
>> in snow_probe() when register_card() returns EPROBE_DEFER.
>>
> 
> I believe it may be useful to know that a driver's probe is deferring 
> due a missing dependency but have no strong opinion and can remove the
> message.

I'd rather rely on core code to inform about missing resources when
registering components.  Otherwise booting unnecessarily takes more
time when there is more probe deferring logs printed on the console.


--
Thanks,
Sylwester
