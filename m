From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [alsa-devel] [RFC PATCH] mfd: arizona: Add gating of external
 MCLKn clocks
Date: Thu, 25 Aug 2016 15:26:41 +0200
Message-ID: <bec76144-9dd1-4b67-ea17-0a0a2e190b91@samsung.com>
References: <1471627036-19465-1-git-send-email-s.nawrocki@samsung.com>
 <20160822092233.GN21682@localhost.localdomain>
 <d47e7106-037f-b40c-71e5-099ee30874e6@samsung.com>
 <20160823162825.GO21682@localhost.localdomain>
 <6b1626c1-d223-4e39-8065-a7421bd3944c@samsung.com>
 <20160825130234.GQ21682@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20160825130234.GQ21682@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, lee.jones@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 08/25/2016 03:02 PM, Charles Keepax wrote:
> Yes so the MCLK needs to be available before we start the FLL, so
> my thinking was we would enable the clock that corresponds
> to the source for the FLL in arizona_set_fll before we start
> enabling the FLL.
> 
> The direct MCLK would require a little more work but we could
> probably enable the clock in this case from wm5110_sysclk_ev.
> 
> I have sent you through a copy of my prototype clock patches you
> can have a look at. I am going to have a bit of a look over this
> today and hopefully will be able to get back to you with more
> concrete thoughts later today.

Thanks, I will have a closer look at the patches.

I have hard coded the MCLK frequency in the tm2_wm511 machine driver
as its fixed anyway and now if the MCLK gating was taken care of by
the CODEC we wouldn't need at all to get at the MCLK clocks in the
machine driver.
