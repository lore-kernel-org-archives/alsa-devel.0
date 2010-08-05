From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: Re: [PATCH v4 1/1] ASoC: TI WL1273 FM Radio Codec.
Date: Thu, 05 Aug 2010 10:29:24 +0300
Message-ID: <1280993364.2296.4.camel@masi.mnp.nokia.com>
References: <1280914979-21235-1-git-send-email-matti.j.aaltonen@nokia.com>
	<1280914979-21235-2-git-send-email-matti.j.aaltonen@nokia.com>
	<20100804163111.GC32504@rakim.wolfsonmicro.main>
Reply-To: matti.j.aaltonen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (mgw-sa02.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 09ED024450
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 09:29:26 +0200 (CEST)
In-Reply-To: <20100804163111.GC32504@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Ujfalusi Peter <peter.ujfalusi@nokia.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hello.

On Wed, 2010-08-04 at 18:31 +0200, ext Mark Brown wrote:
> On Wed, Aug 04, 2010 at 12:42:59PM +0300, Matti J. Aaltonen wrote:
> > This is an ALSA codec for the Texas Instruments WL1273 FM Radio.
> 
> This basically looks OK but...
> 
> > +/* codec private data */
> > +struct wl1273_priv {
> > +	struct snd_soc_codec codec;
> > +	enum wl1273_mode mode;
> > +	struct wl1273_core *core;
> > +	unsigned int channels;
> > +};
> 
> ...why would anything outside the driver be peering into this?

Well, I see no reason... So I'll move it from the header to the c -file
and then it's fine?

Cheers,
Matti A.
