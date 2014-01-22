From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v2 1/4] ASoC: tlv320aic32x4: Use signed int
	mixer controls
Date: Wed, 22 Jan 2014 11:22:20 +0100
Message-ID: <20140122102220.GC25016@pengutronix.de>
References: <1390219558-25341-1-git-send-email-mpa@pengutronix.de>
 <1390219558-25341-2-git-send-email-mpa@pengutronix.de>
 <20140121211455.GZ17314@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 11702261B35
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 11:22:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140121211455.GZ17314@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, Jan 21, 2014 at 09:14:55PM +0000, Mark Brown wrote:
> On Mon, Jan 20, 2014 at 01:05:55PM +0100, Markus Pargmann wrote:
> 
> > +	SOC_DOUBLE_R_S_TLV("PCM Playback Volume", AIC32X4_LDACVOL,
> > +			AIC32X4_RDACVOL, 0, (s8)0x81, 0x30, 7, 0, tlv_pcm),
> 
> These casts are icky - I'd expect either signed numbers being used here
> or the macros to deal with any required casting.  On the other hand
> there's fun and games with the type sizes...

I used this cast for the minimum value to get a easily comparable hex
value. The reference manual does not state the real negative number,
instead it show it in binary '0b1000 0001'. But I can convert those
casted values to negative numbers.

> 
> Also this seems to depend on the patch series adding these controls,
> please note such dependencies when submitting.

Yes, sorry, I had it in the summary of the first version of this series,
forgot to add it in the summary for v2.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
