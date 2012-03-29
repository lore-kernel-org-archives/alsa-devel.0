From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: sgtl5000: Enable VAG when DAC/ADC up
Date: Thu, 29 Mar 2012 22:04:23 +0800
Message-ID: <20120329140420.GD19506@S2101-09.ap.freescale.net>
References: <1333000305-27280-1-git-send-email-shawn.guo@linaro.org>
	<20120329071700.GA18127@zzm-ubuntu>
	<20120329105831.GC3668@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C08D104470
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 16:04:31 +0200 (CEST)
Received: by ghbg19 with SMTP id g19so1549518ghb.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2012 07:04:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120329105831.GC3668@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Zeng Zhaoming <zengzm.kernel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 29, 2012 at 11:58:32AM +0100, Mark Brown wrote:
> On Thu, Mar 29, 2012 at 03:17:00PM +0800, Zeng Zhaoming wrote:
> 
> > So the code should be:
> > +      {"MIC_IN", NULL, "Mic Bias},	       /* mic bias --> mic_in */
> >        {"Capture Mux", "MIC_IN", "MIC_IN"},    /* mic_in --> adc_mux */
> > -+     {"Mic Bias", NULL, "MIC_IN"},           /* mic_in --> mic bias */
> > -+     {"Capture Mux", "MIC_IN", "Mic Bias"},  /* mic bias --> adc_mux */
> 
> > and platform code
> > +      {"Mic Bias", NULL, "MIC"},
> > -      {"MIC_IN", NULL, "MIC"},
> 
> No, the bias should be a supply for the microphone - ensuring that this
> happens is the whole point of the patch I sent the other day.

The "MIC" above is confusing.  I guess the following that I have in
machine driver might be a little clearer.

        {"Mic Bias", NULL, "Mic Jack"},
        {"MIC_IN", NULL, "Mic Bias"},

And I need to present it in device tree though.

-- 
Regards,
Shawn
