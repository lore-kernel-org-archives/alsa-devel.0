From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [RFC] SoC WM8940 Driver
Date: Mon, 27 Apr 2009 11:40:43 +0000
Message-ID: <49F599BB.9050805@cam.ac.uk>
References: <49F21310.4060009@cam.ac.uk> <20090425102100.GA4394@sirena.org.uk>
	<49F345A8.1030901@cam.ac.uk> <20090425180346.GA4072@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ppsw-1.csi.cam.ac.uk (ppsw-1.csi.cam.ac.uk [131.111.8.131])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B810103800
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 13:40:19 +0200 (CEST)
In-Reply-To: <20090425180346.GA4072@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> 
>>>> +	SOC_SINGLE("Digital Loopback Switch adc to dac", WM8940_COMPANDINGCTL,
>>>> +		   0, 1, 0),
> 
>>> This should be called Digital Sidetone Switch and probably ought to be a
>>> DAPM control - there's an ADC to DAC route.
> 
>> I'll take your word for it!
> 
> If you switch the ADC to the DAC then you've got an audio path between
> them.
Hi Mark,

I'm having some trouble getting my head around how to actually specify the audio
route for this Sidetone route.

As far as I can tell you can't specify the following,

{"DAC", "Digtal Sidetone Switch", "ADC"}
As in snd_soc_dapm_add_route only mux, switch and mixer controls can take
a control element.

I can find plenty of examples for cases where this path routes through a mixer
or mux, but in this simple case (it's either connected or not and no
volume controls are on that path) what do I do?

Nearest I can currently come up with is to insert a mux with only one option...

Thanks,

Jonathan
