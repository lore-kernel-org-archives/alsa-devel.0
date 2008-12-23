From: "Medisetty, Naresh" <naresh@ti.com>
Subject: Re: [PATCH 0/8]ALSA: ASoc: DaVinci: cleanup
Date: Tue, 23 Dec 2008 14:05:33 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B670170622FF42E7@dbde02.ent.ti.com>
References: <1229629006-4261-1-git-send-email-troy.kisky@boundarydevices.com>
	<FF55437E1F14DA4BAEB721A458B670170622FF42E1@dbde02.ent.ti.com>,
	<20081222112500.GA3322@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 93B64103818
	for <alsa-devel@alsa-project.org>; Tue, 23 Dec 2008 09:36:47 +0100 (CET)
In-Reply-To: <20081222112500.GA3322@sirena.org.uk>
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
To: Mark Brown <broonie@sirena.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Mark,

> On Mon, Dec 22, 2008 at 12:06:05PM +0530, Medisetty, Naresh wrote:
> 
> > Still I find difficulty to agree with Troy regarding the meaning
> change of
> > SND_SOC_DAIFMT_NB_NF, since the existing meaning is correct w.r.t
> davinci
> > McBSP.
> 
> Could you expand on that a bit - what are you referring to as the 
> standard here?  This could just be a case of different hardware 
> manufacturers implementing slightly different things and giving them 
> the same name.

Yes, Exactly it's just a case of different manufacturers implementing the same thing in different way.

I am referring the davinci ASP default polarities (without inversion) of FS and BCLK as standard.
In davinci ASP Frame sync signals internal to the ASP are active high. 
The Frame sync clock (either FSX or FSR) is XORed with Frame sync polarity bit (FSXP or FSRP).
So if the requirement is for frame sync active low FSXP and FSRP bits in PCR register should be set.

Similarly the BCLK (CLKX and CLKR) is XORed with BCLK polarity bit (CLKXP and CLKRP).
Internally the transmit data driven on rising edge of CLKX and receive data sampled on falling edge of CLKR.
To inverse this CLKXP and CLKRP should be set.

According to this the existing code is proper since it is not setting any polarity bits in _SOC_DAIFMT_NB_NF (Normal bit and Normal Frame )case.

And also in AIC33 codec there is no question of polarities since it is directly configurable through modes (either I2S or DSP).


Regards
Naresh
