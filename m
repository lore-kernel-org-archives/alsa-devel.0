From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [alsa-devel] [RFC PATCH 2/2] ASoC: samsung: Print a one-time
 message if the snow driver's probe defers
Date: Thu, 27 Oct 2016 12:51:12 -0300
Message-ID: <bc156581-dee2-371d-6b5a-ecf811caf958@osg.samsung.com>
References: <1476897666-13974-1-git-send-email-javier@osg.samsung.com>
 <CGME20161019181043eucas1p2d52e28825ae57bbfd19c6d290c6ceb05@eucas1p2.samsung.com>
 <1476897666-13974-3-git-send-email-javier@osg.samsung.com>
 <29147d0b-ecf7-726a-b12b-f93d548f0c99@samsung.com>
 <06ba6563-2792-cb08-694e-4582618ae7fb@osg.samsung.com>
 <7a730a84-ce97-2148-87d9-64211a1aaa6b@samsung.com>
 <4a9f1e7c-0ca7-b9fd-9da6-4fe7edca135a@osg.samsung.com>
 <6bc2b72b-7bcc-e5e8-b4e3-9b254e786c40@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6bc2b72b-7bcc-e5e8-b4e3-9b254e786c40@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: alsa-devel@alsa-project.org

Hello Sylwester,

On 10/27/2016 12:48 PM, Sylwester Nawrocki wrote:
> On 10/27/2016 05:38 PM, Javier Martinez Canillas wrote:
>> +Marek,
>>
>> Hello,
>>
>> On 10/20/2016 08:27 AM, Sylwester Nawrocki wrote:
>>> On 10/20/2016 12:41 PM, Javier Martinez Canillas wrote:
>>>> I see no relevant changes in exynos_defconfig between v4.7..v4.8 and
>>>> also no changes in drivers/Makefile that could cause things to be
>>>> initialized on a different order.
>>>
>>> I remember this
>>>
>>> commit 6eb1c9496b81680f2cd2e0eda06c531317e2e28d
>>> clk: probe common clock drivers earlier
>>>
>>> going in recently, but it's rather dubious it could cause such trouble.
>>>
>>> Anyway, I'd try to add some debug prints to samsung_i2s_probe() to see
>>> what's the issue with the CPU DAI registration.
>>>
>>
>> fyi, Marek already fixed this issue on patch "ASoC: samsung: get access to
>> DMA engine early to defer probe properly":
> 
> Yeah, we have spent some time together today investigating this issue.
> 

Thanks a lot. I thought you would be aware but wanted to mention it on this
thread for completeness.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
