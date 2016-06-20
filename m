From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: rt5670: patch reg-0x8a
Date: Mon, 20 Jun 2016 02:10:55 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D70116C6A1@RTITMBSV03.realtek.com.tw>
References: <1466136482-21944-1-git-send-email-bardliao@realtek.com>
 <20160617111022.GD26099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 456662650DA
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 04:11:04 +0200 (CEST)
In-Reply-To: <20160617111022.GD26099@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, June 17, 2016 7:10 PM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org;
> lars@metafoo.de; Flove; Oder Chiou; Jack Yu
> Subject: Re: [PATCH] ASoC: rt5670: patch reg-0x8a
> 
> On Fri, Jun 17, 2016 at 12:08:02PM +0800, Bard Liao wrote:
> 
> > reg-8a assign the tracking source for each ASRC tracker. The default
> > value is 0x0000 which means all ASRC trackers will track LRCK1. But in
> > most case, we wish each ASRC tracker track the corresponding LRCK.
> > i.e. ASRC1 tracks LRCK1, ASRC2 tracks LRCK2 and so on. So, we rewrite
> > reg-8a as 0x0123.
> 
> Shouldn't this be configurable?

In hardware of view, yes. But, it is not necessary since we can choose
which ASRC we want to use. That is selected by another register and is
implemented by rt5670_sel_asrc_clk_src function. Without this patch,
no matter what ASRC is selected, it will track LRCK1. But with this patch,
we can use ASRC2 to track LRCK2. It means we can decide which LRCK
is tracked by selecting which ASRC we are using with a fixed value of
reg-8a.

> 
> ------Please consider the environment before printing this e-mail.
