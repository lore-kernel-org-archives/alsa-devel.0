From: "Harisangam, Sharvari (S.)" <sharvari.harisangam@visteon.com>
Subject: Re: [PATCH] ASoC : fsl_ssi : Correct the condition to
 check AC97 mode
Date: Wed, 28 Dec 2016 15:53:33 +0000
Message-ID: <20161228155321.GA19963@ubuntu>
References: <20161228110636.GA14768@ubuntu> <87inq4f6pa.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0094.outbound.protection.outlook.com [104.47.0.94])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C78F266998
 for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2016 16:53:34 +0100 (CET)
In-Reply-To: <87inq4f6pa.fsf@linux-m68k.org>
Content-Language: en-US
Content-ID: <3BCDDC9195E28644829B9F3F2FEB7B7B@eurprd06.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 28, 2016 at 03:50:57PM +0100, Andreas Schwab wrote:
> On Dez 28 2016, "Harisangam, Sharvari (S.)" <sharvari.harisangam@visteon.com> wrote:
> 
> > +	return !!(ssi_private->dai_fmt & SND_SOC_DAIFMT_AC97) ==
> > +		SND_SOC_DAIFMT_AC97;
> 
> This is never true.
> 
> Andreas.
> 
> -- 
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."

Ok. I missed the braces there. I will modify and resubmit the patch

-Thanks
Sharvari
