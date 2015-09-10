From: Zidan Wang <zidan.wang@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: wm8960: correct the min gain
 value of some PGA
Date: Thu, 10 Sep 2015 09:15:32 +0800
Message-ID: <20150910011529.GA13451@shlinux2>
References: <22ae1784eb84bf45b23bb7095b7dea8a116c0c2c.1441798038.git.zidan.wang@freescale.com>
 <20150909114954.GA30013@edi-sw-dsktp001.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0146.outbound.protection.outlook.com [157.56.110.146])
 by alsa0.perex.cz (Postfix) with ESMTP id 7706F260A5B
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2015 04:27:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150909114954.GA30013@edi-sw-dsktp001.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 09, 2015 at 12:49:54PM +0100, Charles Keepax wrote:
> On Wed, Sep 09, 2015 at 07:29:10PM +0800, Zidan Wang wrote:
> > The min gain is the corresponding gain value when the register value is 0
> > instead of 1, just correct it.
> > 
> > Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> > ---
> >  sound/soc/codecs/wm8960.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
> > index e3b7d0c..6163474 100644
> > --- a/sound/soc/codecs/wm8960.c
> > +++ b/sound/soc/codecs/wm8960.c
> > @@ -211,11 +211,11 @@ static int wm8960_put_deemph(struct snd_kcontrol *kcontrol,
> >  	return wm8960_set_deemph(codec);
> >  }
> >  
> > -static const DECLARE_TLV_DB_SCALE(adc_tlv, -9700, 50, 0);
> > -static const DECLARE_TLV_DB_SCALE(dac_tlv, -12700, 50, 1);
> > +static const DECLARE_TLV_DB_SCALE(adc_tlv, -9750, 50, 1);
> > +static const DECLARE_TLV_DB_SCALE(dac_tlv, -12750, 50, 1);
> 
> The value zero is used for digital mute here. So I don't think it
> is really appropriate to extend the TLV to show it as -97.5dB or
> -127.5dB.

I think the min register value will corresponding to the min gain.
So value 0 will also have a gain value, although it's for digital mute.

Refer to wm8962 codec driver, beep gain range is -90db~-6db, step in 6db,
but it define the beep gain like below:
static const DECLARE_TLV_DB_SCALE(beep_tlv, -9600, 600, 1);

Best Regards,
Zidan Wang
> 
> >  static const DECLARE_TLV_DB_SCALE(bypass_tlv, -2100, 300, 0);
> >  static const DECLARE_TLV_DB_SCALE(out_tlv, -12100, 100, 1);
> > -static const DECLARE_TLV_DB_SCALE(boost_tlv, -1200, 300, 1);
> > +static const DECLARE_TLV_DB_SCALE(boost_tlv, -1500, 300, 1);
> 
> Same here.
> 
> >  
> >  static const struct snd_kcontrol_new wm8960_snd_controls[] = {
> >  SOC_DOUBLE_R_TLV("Capture Volume", WM8960_LINVOL, WM8960_RINVOL,
> > -- 
> > 1.9.1
> 
> Thanks,
> Charles
