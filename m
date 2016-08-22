From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH] mfd: arizona: Add gating of external MCLKn clocks
Date: Mon, 22 Aug 2016 10:22:33 +0100
Message-ID: <20160822092233.GN21682@localhost.localdomain>
References: <1471627036-19465-1-git-send-email-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471627036-19465-1-git-send-email-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: broonie@kernel.org, lee.jones@linaro.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 19, 2016 at 07:17:16PM +0200, Sylwester Nawrocki wrote:
> This patch adds handling of the CODEC's external MCLK{1,2} clocks
> needed for board configurations where these clocks are not always on
> oscillators.
> The 32k source MCLKn clock is basically kept permanently enabled while
> the other MCLKn clock is being gated in the MFD's runtime suspend/resume
> callbacks.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> I'm not sure it's a correct approach hence only an RFC patch.
> ---

Yeah I am not sure this is quite the correct approach, there are
quite a few corner cases that would not be covered well here. For
example an internally divided down 32k in which case both the 32k
and MCLK would come from the same pin, or using the 32k to feed
an FLL in which case we are trying to enable MCLK1 unnecessarily.

I think we could request the 32k clock source from this part
of the code, but without implementing clock drivers for the
chips internal clocking I think the main MCLK would need to be
requested from the machine driver for now.

On that note, I have been working on a patch chain that adds an
actual clock driver for the chip unfortunately this has been
delayed somewhat due to issues interfacing SPI backed clocks to
the clock framework. Krzysztof Kozlowski has sent a series that
appears to resolve these issues for me so hopefully once the
clock guys have had a look at that I can send my clock driver.
My current implementation mostly just implements the 32k clock
but we can start building that out to include the SYSCLKs and
FLLs etc. fairly quickly. The best thing might be to wait for
that and then build additional features onto that.

Let me know if you want to get an early look at that code.

Thanks,
Charles
