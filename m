From: Rongjun Ying <Rongjun.Ying@csr.com>
Subject: Re: [PATCH v4-resend 1/7] ASoC: sirf: Add SiRF
 internal audio codec driver
Date: Mon, 3 Mar 2014 02:15:17 +0000
Message-ID: <86130EF012BDF348AA0D464A4F449478012AE52440@SHAASIEXM01.ASIA.ROOT.PRI>
References: <1393399342-31177-1-git-send-email-rongjun.ying@csr.com>
 <1393399342-31177-2-git-send-email-rongjun.ying@csr.com>
 <20140227053339.GU9383@sirena.org.uk>
 <86130EF012BDF348AA0D464A4F449478012AE51755@SHAASIEXM01.ASIA.ROOT.PRI>
 <20140301031646.GJ29849@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cluster-d.mailcontrol.com (cluster-d.mailcontrol.com
 [85.115.60.190])
 by alsa0.perex.cz (Postfix) with ESMTP id DC9962654D3
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 03:15:29 +0100 (CET)
In-Reply-To: <20140301031646.GJ29849@sirena.org.uk>
Content-Language: zh-CN
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, DL-SHA-WorkGroupLinux <DL-SHA-WorkGroupLinux@internal.csr.com>, Liam Girdwood <lgirdwood@gmail.com>, RongJun Ying <rjying@gmail.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Saturday, March 01, 2014 11:17 AM
> To: Rongjun Ying
> Cc: RongJun Ying; Liam Girdwood; Jaroslav Kysela; Takashi Iwai; alsa-
> devel@alsa-project.org; DL-SHA-WorkGroupLinux
> Subject: Re: [PATCH v4-resend 1/7] ASoC: sirf: Add SiRF internal audio
> codec driver
> 
> On Fri, Feb 28, 2014 at 01:52:32AM +0000, Rongjun Ying wrote:
> 
> > > > +static struct sirf_audio_codec_reg_bits
> > > sirf_audio_codec_reg_bits_prima2 = {
> > > > +	.dig_mic_en_bits = 20,
> > > > +	.dig_mic_freq_bits = 21,
> 
> > > This looks like the sort of thing that the regmap_field layer was
> > > supposed to hide?
> 
> > Do you mean I need use the regmap_field_read/write to hide these?
> 
> You should certainly consider it and if it's not a good approach
> understanding why may help us improve that API.
> 
> > > > +static int sirf_audio_codec_runtime_suspend(struct device *dev)
> {
> > > > +	struct sirf_audio_codec *sirf_audio_codec =
> dev_get_drvdata(dev);
> > > > +	regmap_update_bits(sirf_audio_codec->regmap,
> AUDIO_IC_CODEC_CTRL1,
> > > > +		(1 << sirf_audio_codec->reg_bits->codec_clk_en_bits),
> > > > +		0);
> > > > +	return 0;
> > > > +}
> 
> > > Can you disable the clock in the clock API as well?  This might
> > > allow further supply clocks to be disabled and is genarally good
> practice.
> 
> > This is a workaround. The capture ADC and touch ADC use a same power
> > supply, The codec ADC's change pump set or clear will impact touch
> ADC unstable.
> > So It's need enable codec clock and set change pump when the Audio
> driver init.
> 
> That doesn't really answer the question for me - I wasn't asking why
> the clock was being disabled, I was asking why the disable wasn't also
> being done at the clock API level.

The codec clock is only used by this driver. And this clock is not managed by
clock controller. The Audio controller codec is always enable. So I think 
it is not need abstract to general clock API.

Thanks.
RongJun Ying



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
