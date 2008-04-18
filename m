From: Daniel Mack <daniel@caiaq.org>
Subject: Re: [PATCH] asoc tlv320aic33: skip usage of PLL
	in	some cases
Date: Fri, 18 Apr 2008 10:13:15 +0200
Message-ID: <20080418081315.GA23555@buzzloop.caiaq.de>
References: <20080417191245.GA17039@buzzloop.caiaq.de>
	<20080417192552.GC17039@buzzloop.caiaq.de>
	<bd7b27490804180059h67a481b0md6fb1a5648338513@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 4CE3724AD5
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Apr 2008 10:13:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id D2A4B7F4039
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Apr 2008 10:13:23 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d8iyea7RuoIF for <alsa-devel@alsa-project.org>;
	Fri, 18 Apr 2008 10:13:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bd7b27490804180059h67a481b0md6fb1a5648338513@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Jarkko,

On Fri, Apr 18, 2008 at 10:59:08AM +0300, Jarkko Nikula wrote:
> I had a quick look to your patch and AIC33 spec.
>
> Is this the same than 256-clock transfer mode?

No, the 256-clock mode is for output only, while in my setup the TLV is
in slave mode. I attached this chip to the I2S output of an PXA270 which
always outputs sample rate * 256 as system clock. In this very case, the
PLL can be bypassed by selecting the left path described on page 27.

> Should you set the bit 3 in
> AIC3X_ASD_INTF_CTRLB in this case? Should you also still write the
> AIC3X_SAMPLE_RATE_SEL_REG?

AIC3X_SAMPLE_RATE_SEL_REG defaults to 0 which is what I want in this
case. Thus, I don't have to write it.

Daniel
