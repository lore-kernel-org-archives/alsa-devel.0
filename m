From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH v2] ASoC: rt5670: add clock source
	selection controls
Date: Tue, 2 Sep 2014 05:22:49 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D76153B1@RTITMBSV03.realtek.com.tw>
References: <1409549878-27304-1-git-send-email-bardliao@realtek.com>
 <20140901153433.GD29327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C30A26577F
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 07:22:57 +0200 (CEST)
In-Reply-To: <20140901153433.GD29327@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Monday, September 01, 2014 11:35 PM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; lars@metafoo.de;
> Flove; Oder Chiou
> Subject: Re: [PATCH v2] ASoC: rt5670: add clock source selection controls
> 
> On Mon, Sep 01, 2014 at 01:37:58PM +0800, bardliao@realtek.com
> wrote:
> 
> > +static const char * const rt5670_asrc_clk_source[] = {
> > +	"clk_sysy_div_out", "clk_i2s1_track", "clk_i2s2_track",
> > +	"clk_i2s3_track", "clk_i2s4_track", "clk_sys2", "clk_sys3",
> > +	"clk_sys4", "clk_sys5"
> > +};
> 
> Every time I see this patch I raise the same concern about the clocking
> usually being controlled in the kernel since other clocks are controlled
> within the kernel.  I've not seen a response to this yet - it's possible there
> is a good reason for putting this under userspace control but you need to
> make the case for doing that.

Which clock source should be selected mainly decided by the sampling
rate and the audio routing path. However, there are some exceptions.
For example, if the MCLK and I2S clock are asynchronous, we should
always select "clk_i2s_track" as the clock source. And In some cases,
we can choice "clk_i2s_track" or "clk_sysy_div_out" as the clock source.
Users can choose what they want to use.

Even if we ignore all the exceptions and make choice for users, it is still
hard to implement it in the driver since we need to read a lot of registers
to decide the clock source. It will be easier if we open it to user space
so user can configure it with the audio routing path.

> 
> ------Please consider the environment before printing this e-mail.
