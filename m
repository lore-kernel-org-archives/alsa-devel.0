From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: MAX9877: add MAX9877 amp driver
Date: Wed, 15 Jul 2009 11:01:34 +0100
Message-ID: <20090715100133.GA18019@sirena.org.uk>
References: <4A5C2829.50402@samsung.com>
	<20090714095426.GA16295@rakim.wolfsonmicro.main>
	<4A5D2F60.9090101@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D7A024550
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jul 2009 12:01:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A5D2F60.9090101@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 15, 2009 at 10:22:40AM +0900, Joonyoung Shim wrote:
> On 7/14/2009 6:54 PM, Mark Brown wrote:

> >> +	SOC_SINGLE_EXT_TLV("MAX9877 Amp HP Left Playback Volume",
> >> +			MAX9877_HPL_VOLUME, 0, 31, 0,
> >> +			max9877_get_reg, max9877_set_reg, max9877_output_tlv),
> >> +	SOC_SINGLE_EXT_TLV("MAX9877 Amp HP Right Playback Volume",
> >> +			MAX9877_HPR_VOLUME, 0, 31, 0,
> >> +			max9877_get_reg, max9877_set_reg, max9877_output_tlv),

> > Ideally these would be a SOC_DOUBLE_EXT_TLV() but we don't have that yet
> > - would you mind sending a patch for that?

> I think these would be a SOC_DOUBLE_R_EXT_TLV() because HP Left register 
> and HP Right register are different. If this is right, i will send a 
> patch for this.

Yes, that sounds right (though if you want to add both macros I won't
stop you!).
