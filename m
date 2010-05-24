From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Mixer volume/decibel mapping
Date: Mon, 24 May 2010 10:52:03 +0800
Message-ID: <AANLkTikXWtp87B0Gq_B-vQZXZlBl_MEBqbuHt6N5cTbi@mail.gmail.com>
References: <201005191834.57919.vand2@gmx.de>
	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>
	<4BF629B3.9020904@ladisch.de>
	<201005210951.36495.peter.ujfalusi@nokia.com>
	<4BF658C6.4030404@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f187.google.com (mail-pz0-f187.google.com
	[209.85.222.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F2D6243DB
	for <alsa-devel@alsa-project.org>;
	Mon, 24 May 2010 04:52:05 +0200 (CEST)
Received: by pzk17 with SMTP id 17so1354860pzk.5
	for <alsa-devel@alsa-project.org>; Sun, 23 May 2010 19:52:03 -0700 (PDT)
In-Reply-To: <4BF658C6.4030404@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/5/21 Clemens Ladisch <clemens@ladisch.de>

> Peter Ujfalusi wrote:
> > On Friday 21 May 2010 09:35:31 ext Clemens Ladisch wrote:
> > > James Courtier-Dutton wrote:
> > > > I believe it could be extended to support a continuous range.
> > > > For example, some hardware uses a 32bit value to control the gain.
> > > > The mix operation is simply "the_sample" * "the_control_value".
> > > > So in this case the hardware has a linear control that can be
> > > > considered continuous for our purposes.
> > >
> > > Such controls already exist:
> > >
> > > $ grep -rl DB_LINEAR sound/
> > > ...
> >
> > The DB_SCALE also provides linear mapping:
> > For example, if the HW volume control has a range 0 .. 100
> > In HW these means:
> > 0 == -10dB, 1 == -9.8dB, 2 == -9.6dB .. 99 = 9.8dB, 100 = 10dB
> > So it is linear.
>
> This is not what is meant by "linear", because dB values are not linear.
>
> DB_LINEAR means that the mixer control value is a multiplier for the
> PCM sample value, as James wrote.  A DB_LINEAR mapping has
> 0 == -infinity dB, full scale == 0 dB, and the mapping between mixer
> control values and corresponding dB values it _not_ linear.
>
> TLV_DB_LINEAR_ITEM is a quite misleading name, but it actually means
> "dB mapping for a mixer control whose value has a linear effect on the
> sound output", _not_ a linear value <-> dB mapping.
>
>
> Regards,
> Clemens
>
>
seem max(full scale) is more then 0dB for some codecs , only three drivers
have 0dB as max and TLV_DB_GAIN_MUTE  (-99999.99dB) as min

PA 's inf dB is only -200dB

include/tlv.h:#define TLV_DB_GAIN_MUTE    -9999999


pci/ymfpci/ymfpci_main.c:static const DECLARE_TLV_DB_LINEAR(db_scale_native,
TLV_DB_GAIN_MUTE, 0);
pci/oxygen/oxygen.c:static const DECLARE_TLV_DB_LINEAR(ak4396_db_scale,
TLV_DB_GAIN_MUTE, 0);
pci/oxygen/hifier.c:static const DECLARE_TLV_DB_LINEAR(ak4396_db_scale,
TLV_DB_GAIN_MUTE, 0);
soc/codecs/wm8990.c:static const DECLARE_TLV_DB_LINEAR(rec_mix_tlv, -1500,
600);
soc/codecs/wm8990.c:static const DECLARE_TLV_DB_LINEAR(in_pga_tlv, -1650,
3000);
soc/codecs/wm8990.c:static const DECLARE_TLV_DB_LINEAR(out_mix_tlv, 0,
-2100);
soc/codecs/wm8990.c:static const DECLARE_TLV_DB_LINEAR(out_pga_tlv, -7300,
600);
soc/codecs/wm8990.c:static const DECLARE_TLV_DB_LINEAR(out_omix_tlv, -600,
0);
soc/codecs/wm8990.c:static const DECLARE_TLV_DB_LINEAR(out_dac_tlv, -7163,
0);
soc/codecs/wm8990.c:static const DECLARE_TLV_DB_LINEAR(in_adc_tlv, -7163,
1763);
soc/codecs/wm8990.c:static const DECLARE_TLV_DB_LINEAR(out_sidetone_tlv,
-3600, 0);
soc/codecs/wm8990.c:    0, 7, TLV_DB_LINEAR_ITEM(-1200, 600),
soc/codecs/wm8400.c:static const DECLARE_TLV_DB_LINEAR(rec_mix_tlv, -1500,
600);
soc/codecs/wm8400.c:static const DECLARE_TLV_DB_LINEAR(in_pga_tlv, -1650,
3000);
soc/codecs/wm8400.c:static const DECLARE_TLV_DB_LINEAR(out_mix_tlv, -2100,
0);
soc/codecs/wm8400.c:static const DECLARE_TLV_DB_LINEAR(out_pga_tlv, -7300,
600);
soc/codecs/wm8400.c:static const DECLARE_TLV_DB_LINEAR(out_omix_tlv, -600,
0);
soc/codecs/wm8400.c:static const DECLARE_TLV_DB_LINEAR(out_dac_tlv, -7163,
0);
soc/codecs/wm8400.c:static const DECLARE_TLV_DB_LINEAR(in_adc_tlv, -7163,
1763);
soc/codecs/wm8400.c:static const DECLARE_TLV_DB_LINEAR(out_sidetone_tlv,
-3600, 0);
soc/codecs/wm8400.c:    0,7, TLV_DB_LINEAR_ITEM(-1200, 600),
soc/codecs/wm8350.c:static DECLARE_TLV_DB_LINEAR(pre_amp_tlv, -1200, 3525);
soc/codecs/wm8350.c:static DECLARE_TLV_DB_LINEAR(out_pga_tlv, -5700, 600);
soc/codecs/stac9766.c:static const DECLARE_TLV_DB_LINEAR(master_tlv, -4600,
0);
soc/codecs/stac9766.c:static const DECLARE_TLV_DB_LINEAR(record_tlv, 0,
2250);
soc/codecs/stac9766.c:static const DECLARE_TLV_DB_LINEAR(beep_tlv, -4500,
0);
soc/codecs/stac9766.c:static const DECLARE_TLV_DB_LINEAR(mix_tlv, -3450,
1200);
