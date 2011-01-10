From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: question on SND_SOC_DAPM_MUX
Date: Mon, 10 Jan 2011 16:20:01 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630108443A6711@bgsmsx502.gar.corp.intel.com>
References: <438BB0150E931F4B9CE701519A44630104C119C00F@bgsmsx502.gar.corp.intel.com>
	<CF32F28EDF8D20468EEDCBE4975DA0272AA367@008-AM1MPN1-027.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 9AFA82441D
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 11:51:11 +0100 (CET)
In-Reply-To: <CF32F28EDF8D20468EEDCBE4975DA0272AA367@008-AM1MPN1-027.mgdnok.nokia.com>
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
To: "peter.ujfalusi@nokia.com" <peter.ujfalusi@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

> >
> > So I added :
> >   { "MIC1 Enable", "amic", "ADC Left"}
> 
> You need to specify the route like:
>   { "Input MICL", "amic", "ADC Left"}
> 
> So, if the "Input MICL" MUX is in amic position, it will connect to "ADC Left"
> 
> > But while adding the routes it returns an error that
> > "sn95031: Failed to add route ADC Left->MIC1 Enable "
> 
> Since the "MIC1 Enable" widget does not have the amic route, I believe.
> 
Thanks Peter, 
It worked as you described, I was putting the map wrongly.... inverted actually :(

~Vinod
