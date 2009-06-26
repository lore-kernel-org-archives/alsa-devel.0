From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: [PATCH] ASoC: Remove word "Switch" from Handsfree
	switch name
Date: Fri, 26 Jun 2009 10:39:58 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E356082BA@dlee04.ent.ti.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E35607E71@dlee04.ent.ti.com>
	<200906260907.07628.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 86481248CD
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Jun 2009 17:40:10 +0200 (CEST)
In-Reply-To: <200906260907.07628.peter.ujfalusi@nokia.com>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

> On Thursday 25 June 2009 20:36:14 ext Lopez Cruz, Misael wrote:
> > SoC dapm adds the suffix "Switch" to SND_SOC_DAPM_SWITCH controls, 
> > removing word "Switch" from HandsfreeL/HandsfreeR widget name for 
> > avoiding to duplicate it.
> >
> > Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
> > ---
> >  sound/soc/codecs/twl4030.c |   12 ++++++------
> >  1 files changed, 6 insertions(+), 6 deletions(-)

> Can you add the TWL4030 to the patch name in the future? It 
> is much easier to spot it in that way.

I'm sorry I forgot it. I'll take care of that next time.

> Thank you!
> Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
