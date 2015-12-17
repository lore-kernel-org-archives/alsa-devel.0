From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: rt5677: Reconfigure PLL1 after resume
Date: Thu, 17 Dec 2015 05:21:05 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D7010E04FF@RTITMBSV03.realtek.com.tw>
References: <1450216285-14875-1-git-send-email-benzh@chromium.org>
 <20151216192127.GQ5727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FD752654B7
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2015 06:21:12 +0100 (CET)
In-Reply-To: <20151216192127.GQ5727@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Ben Zhang <benzh@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Anatol Pomozov <anatol@google.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Thursday, December 17, 2015 3:21 AM
> To: Ben Zhang
> Cc: alsa-devel@alsa-project.org; Liam Girdwood; Bard Liao; Oder Chiou;
> John Lin; Dylan Reid; Anatol Pomozov
> Subject: Re: [PATCH] ASoC: rt5677: Reconfigure PLL1 after resume
> 
> On Tue, Dec 15, 2015 at 01:51:25PM -0800, Ben Zhang wrote:
> > Sometimes PLL1 stops working if the codec loses power during suspend
> > (when pow-ldo2 or reset gpio is used).
> > MX-7Bh(RT5677_PLL1_CTRL2) is cleared and won't be restored by
> regcache
> > since it's volatile. MX-7Bh has one status bit and M code for PLL1.
> > rt5677_set_dai_pll doesn't reconfigure
> > PLL1 after resume because it thinks the PLL params are not changed.
> 
> > This patch clears the cached PLL params at resume so that
> > rt5677_set_dai_pll can reconfigure the PLL after resume.
> 
> This is something I'd expect the machine driver to handle - if it's stopped
> using the PLL I'd expect it to explicitly turn it off, suspend (or the CODEC
> going idle for that matter normally, the PLL is burning
> power) should do that.  If anything I'd expect the CODEC driver to restore
> the current settings.

The main reason of this patch is MX-7Bh(RT5677_PLL1_CTRL2) is volatile.
However, the status bit of MX-7Bh is currently not used by codec driver.
So, it should be no problem if we set it non-volatile.

> 
> That said I'll apply this since it at least doesn't make things worse.

Can we revert it and resend a patch?

> 
> ------Please consider the environment before printing this e-mail.
