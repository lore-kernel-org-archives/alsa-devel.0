From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH 4/6] ASoC: rt5645: add device tree support
Date: Tue, 5 May 2015 05:59:24 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D701067433@RTITMBSV03.realtek.com.tw>
References: <1430389127-24609-1-git-send-email-bardliao@realtek.com>
 <1430389127-24609-4-git-send-email-bardliao@realtek.com>
 <20150501163247.GC22845@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D701066F9B@RTITMBSV03.realtek.com.tw>
 <20150504115907.GG15510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 646BB2608BB
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2015 07:59:34 +0200 (CEST)
In-Reply-To: <20150504115907.GG15510@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "zhengxing@rock-chips.com" <zhengxing@rock-chips.com>, "yang.a.fang@intel.com" <yang.a.fang@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Monday, May 04, 2015 7:59 PM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; lars@metafoo.de;
> Flove; Oder Chiou; John Lin; koro.chen@mediatek.com;
> yang.a.fang@intel.com; zhengxing@rock-chips.com
> Subject: Re: [PATCH 4/6] ASoC: rt5645: add device tree support
> 
> On Mon, May 04, 2015 at 05:21:59AM +0000, Bard Liao wrote:
> 
> > > > +  Boolean. Indicate if codec IRQ is used or not. It is usually
> > > > +used for JD
> > > > +  and/or headset button detection.
> 
> > > I'm not sure I understand what this is for?  I'd expect that the
> > > interrupt would be used if specified, though if a GPIO is specified
> > > I guess that'd override it.
> 
> > It is for codec IRQ though it is called en-jd-func. rt5645 IRQ is not
> > for JD only but also other functions (like button detection). Another
> > thing is that a separate CPU pin is used for JD IRQ in some HW design.
> > It means some HW design use their own JD function. That's what
> > hp-det-gpio for.
> 
> I'm still not clear here - why is there a need for a separate flag over just
> specifying the additional GPIO/interrupt to use for this function?

Oh, we can assume codec IRQ is used if codec JD or button detection
function is used. I will send a patch to remove dmic_en and en_jd_func
in platform data and send the device tree support patch again.

Thanks.

> 
> ------Please consider the environment before printing this e-mail.
