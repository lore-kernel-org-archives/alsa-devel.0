From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 2/5] ASoC: Move standard
	kcontrol	helpers to the component level
Date: Mon, 12 May 2014 11:52:57 +0100
Message-ID: <20140512105257.GG25203@opensource.wolfsonmicro.com>
References: <20140509150034.GH2870@dragon> <536CF16F.8010807@metafoo.de>
 <CAOMZO5Cb4Q80ux1R9EOcsaCPFsmxz3K5Obt02or=s0RitmPMKw@mail.gmail.com>
 <536CFBE7.3070805@metafoo.de> <20140510050747.GI2870@dragon>
 <536DCF6F.9020507@metafoo.de> <536DD108.2090607@metafoo.de>
 <20140510083131.GL2870@dragon> <536DE548.9050008@metafoo.de>
 <20140510091209.GM2870@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EA40E264F3D
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 12:52:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140510091209.GM2870@dragon>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Fabio Estevam <festevam@gmail.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sat, May 10, 2014 at 05:12:11PM +0800, Shawn Guo wrote:
> On Sat, May 10, 2014 at 10:37:28AM +0200, Lars-Peter Clausen wrote:
> > On 05/10/2014 10:31 AM, Shawn Guo wrote:
> > >On Sat, May 10, 2014 at 09:11:04AM +0200, Lars-Peter Clausen wrote:
> > >>On 05/10/2014 09:04 AM, Lars-Peter Clausen wrote:
> > >>[..]
> > >>>>The error message only shows up with Debian wheezy and does not with
> > >>>>yocto rootfs.  And even when the error message shows, the audio still
> > >>>>functions well on Debian wheezy.  So it's just a noisy error message
> > >>>>for me which is only seen after your kernel patch.
> > >>>
> > >>>The keyword here is "seen". The error quite likely predated the commit, but
> > >>>it was silently discarded.
> > >>>
> > >>>regmap_read() returns -EBUSY when there is no cached register value and
> > >>>cache_only is set to true. But I'm not sure why that would happen, try to
> > >>>add some printks to _regmap_read() to see if this is the source and if it is
> > >>>why it is.
> > >>
> > >>Both SGTL5000_CHIP_ANA_ADC_CTRL and SGTL5000_CHIP_MIC_CTRL don't
> > >>have an entry in sgtl5000_reg_defaults. So if cache_only is true,
> > >>controls which use these registers will return -EBUSY when you try
> > >>to read or write them.
> > >
> > >Hmm, it's a wm8962 than sgtl5000 on board imx6q-sabresd.
> > 
> > Ok, misread the boardname. But the issue will be the same.
> > cache_only = true and trying to read/update a register that is not
> > in the cache.
> 
> Yea, you're right.  When the error message shows up, _regmap_read()
> returns -EBUSY for reg WM8962_CLASS_D_CONTROL_1.  But how do I find out
> why the reg is not in the cache?

Looking at this a bit more can you let me know when it is
failing, I assume it is in relation to setting the "Speaker
Switch" control?

Thanks,
Charles
