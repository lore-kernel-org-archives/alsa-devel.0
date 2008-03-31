From: "Alexandre BOUIN" <a.bouin@kerlink.fr>
Subject: Re: Any wigets for ADC to DAC ?
Date: Mon, 31 Mar 2008 12:32:21 +0200
Message-ID: <34139.9691570134$1206959630@news.gmane.org>
References: <20080331102431.GB21135@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from scanner-relay-corvus2.pulsation.fr
	(scanner-relay-corvus2.pulsation.fr [80.74.64.70])
	by alsa0.perex.cz (Postfix) with SMTP id 8E47C24767
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Mar 2008 12:32:54 +0200 (CEST)
In-Reply-To: <20080331102431.GB21135@rakim.wolfsonmicro.main>
Content-Language: fr
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: 'ALSA-devel' <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > In intern, we're still using WM8900 codec. We'd like to know in ASoC
> layer,
> > there is a widget to declare a possible audio path between ADC and
> DAC.
> 
> If there were a direct connection the appropriate thing would just be
> to
> declare it (in that particular chip there is actually a digitial mixer
> in there).  Using such a path is not particularly supported by ASoC v1
> since it treats ADCs and DACs as sinks and sources only.

Thanks for this answer Mark.

Will be there a support for a such feature in ASoC v2  ?
