From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH] ASoC: samsung-i2s: Check secondary DAI exists before
 referencing
Date: Tue, 09 Sep 2014 19:08:17 +0200
Message-ID: <540F3401.5090003@samsung.com>
References: <1410277909-27922-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1410277909-27922-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, broonie@kernel.org
Cc: sbkim73@samsung.com, lgirdwood@gmail.com, linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 09/09/14 17:51, Charles Keepax wrote:
> In a couple of places the driver is missing a check to ensure there is a
> secondary DAI before it de-references the pointer to it, causing a null
> pointer de-reference. This patch adds a check to avoid this.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Thanks for the patch. We had one of those occurrences fixed internally
but I missed to submit the patch upstream.
