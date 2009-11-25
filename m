From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 03/12] add a mc13783 codec driver
Date: Wed, 25 Nov 2009 08:46:31 +0100
Message-ID: <20091125074631.GB27548@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<20091119193008.GC2814@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 313CA244C8
	for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2009 08:46:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091119193008.GC2814@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

> > +static int mc13783_set_tdm_slot_codec(struct snd_soc_dai *dai,
> > +	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
> > +{
> > +	struct snd_soc_codec *codec = dai->codec;
> > +	unsigned int reg;
> > +
> > +	if (slots != 4)
> > +		return -EINVAL;
> > +
> > +	reg = mc13783_read(codec, PMIC_SSI_NETWORK);
> > +
> > +	reg &= ~(0xfff << 0);
> > +	reg |= (0x00 << 2);	/* primary timeslot RX/TX(?) is 0 */
> > +	reg |= (0x01 << 4);	/* secondary timeslot TX is 1 */
> > +	reg |= (0x01 << 6);	/* secondary timeslot RX is 1 */
> 
> This appears to be pretty much ignoring the supplied arguments and using
> a fixed configuration?
> 

The problem here is that I don't really understand what arguments I
should supply to this function and how to parse them to archieve what I
want.

The MC13783 Voice Codec always uses a network mode to send data. It has
a fixed width of four slots.

PMIC_SSI_NETWORK[2:3] defines the slot for primary transmit/receive
PMIC_SSI_NETWORK[4:5] defines the secondary transmit timeslot
PMIC_SSI_NETWORK[6:7] defines the secondary receive timeslot

The Codec has two channels and it's not primarily desgined to do stereo
Audio. I want to put the primary channel into the first timeslot and
the secondary channel into the second timeslot.

Any idea how to do this correctly?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
