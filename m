From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH RFC/RFT] ASoC: rt5677: Convert to use
	rl6231_pll_calc
Date: Mon, 23 Jun 2014 05:32:29 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D1269453316C@RTITMBSV03.realtek.com.tw>
References: <1402980091.13607.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 556B6261609
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 07:32:38 +0200 (CEST)
In-Reply-To: <1402980091.13607.1.camel@phoenix>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Axel Lin [mailto:axel.lin@ingics.com]
> Sent: Tuesday, June 17, 2014 12:42 PM
> To: Mark Brown
> Cc: Oder Chiou; Liam Girdwood; alsa-devel@alsa-project.org
> Subject: [PATCH RFC/RFT] ASoC: rt5677: Convert to use rl6231_pll_calc
> 
> The implementation of rt5677_pll_calc() has the same logic of rl6231_pll_calc().
> The only difference is the lower boundary checking for freq_in.
> 
> This patch calls rl6231_pll_calc() instead of open-coded.
> The k_bp of struct rt5677_pll_code is always false, thus also remove the
> code to check pll_code.k_bp.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
Tested-by: Oder Chiou <oder_chiou@realtek.com>

> ---
> Hi Oder,
> This patch removes the usage of k_bp from struct rt5677_pll_code because it is
> always false. I think if k_bp is necessay in the further development, maybe
> it's better to add it to rl6231_pll_code. How do you think?
> 
It is the better way, thanks.
