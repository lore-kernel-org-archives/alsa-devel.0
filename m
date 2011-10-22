From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/2] ASoC: core: Add flag to ignore
 pmdown_time at pcm_close
Date: Sat, 22 Oct 2011 10:33:26 +0100
Message-ID: <20111022093326.GA2890@opensource.wolfsonmicro.com>
References: <1318592614-13110-1-git-send-email-peter.ujfalusi@ti.com>
	<1318592614-13110-2-git-send-email-peter.ujfalusi@ti.com>
	<12D0C12AF19E15409D57F22566E88EF50A813690AD@bgsmsx501.gar.corp.intel.com>
	<20111021085303.GB3513@opensource.wolfsonmicro.com>
	<12D0C12AF19E15409D57F22566E88EF50A81369249@bgsmsx501.gar.corp.intel.com>
	<20111021091358.GG3513@opensource.wolfsonmicro.com>
	<12D0C12AF19E15409D57F22566E88EF50A813D504E@bgsmsx501.gar.corp.intel.com>
	<3CA6C6D9F70D314CA34352990B57DA1507C8CB95AD@bgsmsx502.gar.corp.intel.com>
	<20111021194131.GA2843@opensource.wolfsonmicro.com>
	<3CA6C6D9F70D314CA34352990B57DA1507C8CB9611@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EC59C2459A
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Oct 2011 11:33:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3CA6C6D9F70D314CA34352990B57DA1507C8CB9611@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, "Babu, Ramesh" <ramesh.babu@intel.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 22, 2011 at 01:54:23AM +0530, Nallasellan, Singaravelan wrote:

When I said you shouldn't top post that's exactly what I meant!  This is
basic mailing list etiquette for public Linux lists because for
example...

> Agree. System integrator may not like to delay closing modem ports for 6 seconds either. Need to close the ports immediately or delay. 

...not having any context quoted means the reader can't easily tell wht
it is that you are agreeing with.  You should also fix your mail client
to word wrap within paragraphs as I also mentioned.

> Do you suggest that we shouldn't delay in the driver and introduce delay in the user pace?
> I prefer to remove the delay altogether from the driver. Do you see any issue which might cause glitches?

The delay is very important for CPU use cases as brief gaps in playback
are extremely common there.  The power up and power down are generally
noticable and to be avoided.
