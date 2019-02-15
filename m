From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH] ASoC: samsung: odroid: Ensure proper sample rate on
 pri/sec PCM
Date: Fri, 15 Feb 2019 12:32:13 +0100
Message-ID: <54683fa7-6a07-5706-5b8a-ce7be5d02646@samsung.com>
References: <CGME20190214160039epcas2p34b9e3b3ca5f9b0aa1fb5ed59403a6fe1@epcas2p3.samsung.com>
        <20190214160011.3940-1-s.nawrocki@samsung.com>
        <CAJKOXPd20QPjvEV_TzKi8fcJM-Ws4Te6W0ZRvzNVt2c-60VKAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAJKOXPd20QPjvEV_TzKi8fcJM-Ws4Te6W0ZRvzNVt2c-60VKAQ@mail.gmail.com>
Content-language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2/15/19 08:24, Krzysztof Kozlowski wrote:
> Is this the fix for
> "aplay: set_params:1403: Unable to install hw params:"
> which appeared in today's next (so after your last round of patches get merged)?
> https://krzk.eu/#/builders/1/builds/3093/steps/24/logs/stdio

No, but I have just prepared a fix for that one. I should have done
sound playback/recording test for a scenario without DTS updates rather
than just looking at card initialization completion.
Without DTS changes there will be 1 or 2 DAPM routes missing. I'm going to
post a patch adding missing DAPM routes in the card driver for backwards
compatibility.

> Also, since yesterday (so with previous rounds of patches) the audss
> rebind freezes entire kernel:
> https://krzk.eu/#/builders/1/builds/3093/steps/25/logs/stdio
> https://krzk.eu/#/builders/1/builds/3093/steps/25/logs/serial0
> 
> It is not important test but it was always passing in my suite.

The reason might be that I used platform_device_del() rather than
platform_device_unregister(). I will post other fix I have for scenario 
with multiple "multi-I2S" devices, it should also be a solution for 
that rebind issue.

-- 
Regards,
Sylwester
