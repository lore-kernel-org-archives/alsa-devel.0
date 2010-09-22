From: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Subject: Re: [PATCH] ASoC: Add max98088 CODEC driver
Date: Tue, 21 Sep 2010 19:49:30 -0700
Message-ID: <B2150E1E4418E1438554A300EA5040E40D46E1B8E7@ITSVLEX06.it.maxim-ic.internal>
References: <B2150E1E4418E1438554A300EA5040E40D469C123B@ITSVLEX06.it.maxim-ic.internal>
	<20100901111432.GE17548@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40D46A5BB13@ITSVLEX06.it.maxim-ic.internal>
	<20100903101721.GE16587@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from antispam01.maxim-ic.com (antispam01.maxim-ic.com
	[205.153.101.182])
	by alsa0.perex.cz (Postfix) with ESMTP id AC89A103809
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Sep 2010 04:49:38 +0200 (CEST)
In-Reply-To: <20100903101721.GE16587@rakim.wolfsonmicro.main>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Joonyoung@alsa-project.org, Shim <jy0922.shim@samsung.com>, Takashi Iwai <tiwai@suse.de>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marroquin <Jesse.Marroquin@maxim-ic.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Jesse@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 03, 2010, Mark Brown wrote:
> On Thu, Sep 02, 2010 at 04:30:14PM -0700, Peter Hsiang wrote:
> > On Wed, Sep 01, 2010, Mark Brown wrote:
> 
> > > > +/*
> > > > + * Read the MAX98088 I2C register space
> > > > + * Note: this driver source code is backward compatible to kernel
> > > > + * version 2.6.32.
> > > > + */
> > > > +static unsigned int max98088_read(struct snd_soc_codec *codec,
> > > > +                                 unsigned int reg)
> 
> > > Just use soc-cache.  Compatibility code for older kernels isn't really
> > > acceptable for mainline due to the increased maintainance burden and it
> > > will at best result in a driver that doesn't work as well as possible.
> 
> > This integrated registers feature is not available in 2.6.32
> > Is it ok with you to keep it this way for this release?  Thanks.
> 
> No, you should use the features of the current kernel.  For your
> backport you can do things like supply soc-cache.c as well.

The soc-cache.c in the latest kernel-next version supports codecs
with volatile registers in 16 bit mode, but not for the 8 bit mode.
See snd_soc_8_8_write.

The source code comments confirmed this:
"Note at present this code can not be used by CODECs with 
volatile registers."  

For this codec (with volatile registers), should we use the read
and write functions in the codec driver until the 8-bit mode is
supported by Linux soc-cache.c?
