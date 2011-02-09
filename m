From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH 1/3] ASoC: sn95031: Add jack support in the
	codec
Date: Wed, 9 Feb 2011 18:36:44 +0530
Message-ID: <438BB0150E931F4B9CE701519A4463010846D59CDE@bgsmsx502.gar.corp.intel.com>
References: <1297242747-18632-1-git-send-email-vinod.koul@intel.com>
	<1297242747-18632-2-git-send-email-vinod.koul@intel.com>
	<20110209121139.GA24042@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 738DB2440F
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 14:06:54 +0100 (CET)
In-Reply-To: <20110209121139.GA24042@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha,
	Priya" <priya.harsha@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Wednesday, February 09, 2011 5:42 PM
> To: Koul, Vinod
> Cc: alsa-devel@alsa-project.org; lrg@slimlogic.co.uk; Harsha, Priya
> Subject: Re: [PATCH 1/3] ASoC: sn95031: Add jack support in the codec
> 
> On Wed, Feb 09, 2011 at 02:42:25PM +0530, Koul, Vinod wrote:
> 
> > +void disable_jack_btn(struct snd_soc_codec *codec)
> > +{
> > +	snd_soc_write(codec, SN95031_BTNCTRL2, 0x00);
> > +}
> > +EXPORT_SYMBOL_GPL(disable_jack_btn);
> 
> This needs to be namespaced.  It's also surprising that the matching
> enable function isn't exposed...
Yes, that's right, this should be namespaced :)

This buttons are disabled at init, but I added code to check jack status at
init, If it finds a avalid check it will enabled jack or disable otherwise.

I don't strictly need this.
I will remove this as exported and fix namespace...

> The code itself looks OK.
In that case would it be okay if you accept this and I will send follow
patch right away fixing this...Or I will resend all three?

~Vinod
