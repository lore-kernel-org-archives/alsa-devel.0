From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8974: configure pll and mclk
 divider automatically
Date: Mon, 25 Jan 2016 13:49:53 +0000
Message-ID: <20160125134953.GK1490@localhost.localdomain>
References: <1453725403-6261-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 04C2F260532
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2016 14:50:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1453725403-6261-1-git-send-email-mans@mansr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mans Rullgard <mans@mansr.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 25, 2016 at 12:36:43PM +0000, Mans Rullgard wrote:
> This adds a set_sysclk() DAI op so the card driver can set the
> input clock frequency.  If this is done, the pll and mclk divider
> are configured to produce the required 256x fs clock when the
> sample rate is set by hw_params().
> 
> These additions make the codec work with the simple-card driver.
> Card drivers calling set_pll() and set_clkdiv() directly are
> unaffected.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
