From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: omap: rx51: Add FM transmitter
 support
Date: Tue, 22 Feb 2011 09:18:44 +0200
Message-ID: <20110222091844.a85aa610.jhnikula@gmail.com>
References: <1298293042-13801-1-git-send-email-jhnikula@gmail.com>
	<4D635EBF.3040409@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A426103875
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 08:17:56 +0100 (CET)
Received: by eyg5 with SMTP id 5so640876eyg.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 23:17:54 -0800 (PST)
In-Reply-To: <4D635EBF.3040409@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 22 Feb 2011 08:59:11 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> >  	{"DMic Rate 64", NULL, "Mic Bias 2V"},
> >  	{"Mic Bias 2V", NULL, "DMic"},
> > @@ -292,6 +295,7 @@ static const struct snd_kcontrol_new aic34_rx51_controls[] = {
> >  		     rx51_get_input, rx51_set_input),
> >  	SOC_ENUM_EXT("Jack Function", rx51_enum[2],
> >  		     rx51_get_jack, rx51_set_jack),
> 
> Have you thought of converting the 'Jack Function' to DAPM_PIN_SWITCH as
> well?
> 
Yes, but then I realized it has multiple functions (that I
implemented) :-)

-- 
Jarkko
