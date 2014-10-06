From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH RESEND] ASoC: rt5670: Add dsp support
Date: Mon, 6 Oct 2014 02:18:47 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D7656642@RTITMBSV03.realtek.com.tw>
References: <1411957901-12156-1-git-send-email-bardliao@realtek.com>
 <20141003163224.GC3594@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F8652605A8
 for <alsa-devel@alsa-project.org>; Mon,  6 Oct 2014 04:19:03 +0200 (CEST)
In-Reply-To: <20141003163224.GC3594@sirena.org.uk>
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
> Sent: Saturday, October 04, 2014 12:32 AM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; lars@metafoo.de;
> Flove; Oder Chiou
> Subject: Re: [PATCH RESEND] ASoC: rt5670: Add dsp support
> 
> > +/* DSP Mode */
> > +static const char * const rt5670_dsp_mode[] = {
> > +	"Mode 1", "Mode 2", "Mode 3", "Mode 4", "Mode 5"
> > +};
> 
> What exactly are these modes?

These are DSP working modes, such as noise suppression, echo cancellation...
The reason we won't have a specific name on alsa control is that the driver
will be more flexible and we can define customized modes on the firmware.
For example, the 5 modes may be noise suppression 1, noise suppression 2,
noise suppression + echo cancellation, voice tracking, echo cancellation.

> 
> ------Please consider the environment before printing this e-mail.
