From: "Zhong Li" <zql@glomationinc.com>
Subject: Re: [PATCH 2/2] ASoC: sam9x5_wm8731: change to work in
	DSP A mode
Date: Wed, 4 Dec 2013 10:54:11 -0500
Message-ID: <075e01cef109$136c56f0$3a4504d0$@com>
References: <1386124624-22414-1-git-send-email-voice.shen@atmel.com>
 <1386124624-22414-3-git-send-email-voice.shen@atmel.com>
 <529F1424.7040501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway06.websitewelcome.com (gateway06.websitewelcome.com
 [64.5.52.9]) by alsa0.perex.cz (Postfix) with ESMTP id 7DB98261701
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 16:54:45 +0100 (CET)
Received: from ham05.websitewelcome.com (unknown [184.173.222.181])
 by gateway06.websitewelcome.com (Postfix) with ESMTP id CEAF2108068A9
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 09:54:43 -0600 (CST)
Received: from gator4086.hostgator.com (gator4086.hostgator.com [192.185.4.98])
 by ham05.websitewelcome.com (Postfix) with ESMTP id CFAE8DDDD0EAE
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 09:54:13 -0600 (CST)
In-Reply-To: <529F1424.7040501@gmail.com>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Richard Genoud' <richard.genoud@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Richard,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces@lists.infradead.org] On Behalf Of Richard Genoud
> Sent: Wednesday, December 04, 2013 6:38 AM
> To: Bo Shen
> Cc: zql@glomationinc.com; nicolas.ferre@atmel.com; alsa-devel@alsa-
> project.org; linux-sound@vger.kernel.org; broonie@kernel.org; linux-
> arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 2/2] ASoC: sam9x5_wm8731: change to work in DSP A
> mode
> 
> On 04/12/2013 03:37, Bo Shen wrote:
> > Change sam9x5 with wm8731 work in DSP A mode, this will fix the
> > left/right channel swap issue.
> >

> >
> Tested-by: Richard Genoud <richard.genoud@gmail.com> on at91sam9g35-ek
> with 3.12-rc2 + "ASoC: wm8731: fix dsp mode configuration"
> 
> 
> Thanks !
> 
> 

Where can I get a snap shot of your kernel source?  My test still have the
same issue after I applied the two patches.


Thanks,

Zhong
