From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [alsa-devel] [RFC PATCH] mfd: arizona: Add gating of external
 MCLKn clocks
Date: Thu, 25 Aug 2016 12:18:47 +0200
Message-ID: <6b1626c1-d223-4e39-8065-a7421bd3944c@samsung.com>
References: <1471627036-19465-1-git-send-email-s.nawrocki@samsung.com>
 <20160822092233.GN21682@localhost.localdomain>
 <d47e7106-037f-b40c-71e5-099ee30874e6@samsung.com>
 <20160823162825.GO21682@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20160823162825.GO21682@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, lee.jones@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 08/23/2016 06:28 PM, Charles Keepax wrote:
> Apologies it seems I missed another version of this on the
> mailing list, please do feel free to add me or the
> patches@opensource.wolfsonmicro.com list as a direct CC on
> any patches using our CODECs, I am always more than happy to look
> over things and feel bad when I miss stuff. I will have a look
> at the latest version of the patch.

Actually I should have copied you on the last iteration after
addressing your review comments, sorry about this omission.

> I think we should be able to do something requesting the 32k
> approximately as your existing patch here does, but then
> requesting the main MCLK from the set_pll and set_sysclk
> handlers. Eventually I would like the internal SYSCLK and FLLs
> represented in the clock framework, so I want to have a quick
> think about how that would migrate over. Let me see what I can
> come up with here.

Sounds good, I assume you mean enabling/disabling from the set_pll
and set_syclk handlers. Do you find any issues with that? I think
the CODEC should ensure external MCLK is enabled when setting FLL,
otherwise it will not lock?
Presumably arizona_set_fll() and arizona_set_sysclk() are places
where it should be checked what the root source clock is and enable
it if it's not yet enabled?
