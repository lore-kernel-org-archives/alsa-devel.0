From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: wm8731 capture -dapm failure
Date: Tue, 9 Sep 2008 22:28:42 +0100
Message-ID: <200809092228.42271.gineera@aspect135.co.uk>
References: <200809091642.14114.gineera@aspect135.co.uk>
	<1220975642.17091.200.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-4.talktalk.net [62.24.128.234])
	by alsa0.perex.cz (Postfix) with ESMTP id B9CF324621
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 23:21:17 +0200 (CEST)
In-Reply-To: <1220975642.17091.200.camel@odin>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@kernel.org>, ALSA devel <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 09 September 2008 16:54, you wrote:
>
> No valid input to ADC.
>
> We currently have
>
> R/LLINEIN --> Input Mux --> ADC
>
> but R/LLINEIN are not active. Call snd_soc_dapm_enable_pin(codec, pin)
> to activate.
>
> Liam

Thanks, Liam; I think we had failed to realise the significance of 
machine-specific code in the dapm system, rather expecting everything to be 
available.  Indeed the line inputs are set not active.  Will pursue this 
tomorrow.

Alan
