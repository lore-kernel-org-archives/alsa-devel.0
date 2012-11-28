From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: mic bias for tlv320aic3x?
Date: Wed, 28 Nov 2012 10:28:53 +0100 (CET)
Message-ID: <alpine.DEB.2.01.1211280927500.26303@pmeerw.net>
References: <alpine.DEB.2.01.1211271808130.20477@pmeerw.net>
 <20121127175326.GB13065@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pmeerw.net (ns.pmeerw.net [87.118.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id D4E78261570
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 10:28:54 +0100 (CET)
In-Reply-To: <20121127175326.GB13065@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

> > I'd like to enable 2V mic bias on the tlv320aic3x (which offers 2V, 2.5V, 
> > AVDD, off) -- I'd have expected some control in alsamixer to so, but there 
> > is none
 
> > what is the proper way to implement mic bias selection?
 
> As platform data or possibly via an API offered to the machine driver,
> we've yet to see any use case where it's something that should be varied
> directly from the application layer.

I can see the platform data way

I'd be happy with an API to control from the machine driver -- is 
snd_soc_dapm_enable_pin() to be used for this + some SND_SOC_DAPM_MIC? 

I am missing the overall strategy how this is supposed to work

is there a good reference driver?

per default, Mic Bias is off
there already are some mic bias definitions in tlv320aic3x:

	/* Mic Bias */
	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "Mic Bias 2V",
			 MICBIAS_CTRL, 6, 3, 1, 0),
	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "Mic Bias 2.5V",
			 MICBIAS_CTRL, 6, 3, 2, 0),
	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "Mic Bias AVDD",
			 MICBIAS_CTRL, 6, 3, 3, 0),

however, those are not referenced anywhere and it is not clear how to 
access those from the machine driver

as for the use case: user wants to connect either a microphone or line-in 
to a connector, hence mic bias selection is necessary -- this doesn't 
sound so unusual

thanks, regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
