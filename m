From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Mixer volume/decibel mapping
Date: Sat, 22 May 2010 17:24:58 +0800
Message-ID: <AANLkTinHXfjSzLVb1kugdGN1NdmHL_XhqnkVmfvNqL74@mail.gmail.com>
References: <201005191834.57919.vand2@gmx.de>
	<AANLkTimQtKql4p3UEs2Wh_tZ6YhzLGgl1q5G18A1y9Jk@mail.gmail.com>
	<AANLkTilKqn_X3FUdDmCqy3YKdYeT47oIGGaqUitzruDk@mail.gmail.com>
	<201005201141.28755.vand2@gmx.de>
	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>
	<4BF629B3.9020904@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 0FE8524820
	for <alsa-devel@alsa-project.org>;
	Sat, 22 May 2010 11:24:59 +0200 (CEST)
Received: by pvc22 with SMTP id 22so834011pvc.38
	for <alsa-devel@alsa-project.org>; Sat, 22 May 2010 02:24:58 -0700 (PDT)
In-Reply-To: <4BF629B3.9020904@ladisch.de>
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

> James Courtier-Dutton wrote:
> > I believe it could be extended to support a continuous range.
> > For example, some hardware uses a 32bit value to control the gain.
> > The mix operation is simply "the_sample" * "the_control_value".
> > So in this case the hardware has a linear control that can be
> > considered continuous for our purposes.
>
> Such controls already exist:
>
> $ grep -rl DB_LINEAR sound/
> sound/i2c/other/ak4xxx-adda.c
> sound/pci/oxygen/hifier.c
> sound/pci/oxygen/oxygen.c
> sound/pci/ymfpci/ymfpci_main.c
> sound/soc/codecs/stac9766.c
> sound/soc/codecs/wm8350.c
> sound/soc/codecs/wm8400.c
> sound/soc/codecs/wm8990.c
>

why is STAC9766 different from other AC97 2.3 codec ?

static const DECLARE_TLV_DB_LINEAR(master_tlv, -4600, 0);
static const DECLARE_TLV_DB_LINEAR(record_tlv, 0, 2250);
static const DECLARE_TLV_DB_LINEAR(beep_tlv, -4500, 0);
static const DECLARE_TLV_DB_LINEAR(mix_tlv, -3450, 1200);

static const struct snd_kcontrol_new stac9766_snd_ac97_controls[] = {
