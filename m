From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: rt5640: Add minimal support for
	RT5642
Date: Thu, 17 Apr 2014 01:59:17 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D73AC3AC@RTITMBSV03.realtek.com.tw>
References: <1397654176-5736-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 59E0F262631
 for <alsa-devel@alsa-project.org>; Thu, 17 Apr 2014 03:59:23 +0200 (CEST)
In-Reply-To: <1397654176-5736-1-git-send-email-jarkko.nikula@linux.intel.com>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Jarkko Nikula [mailto:jarkko.nikula@linux.intel.com]
> Sent: Wednesday, April 16, 2014 9:16 PM
> To: alsa-devel@alsa-project.org
> Cc: Mark Brown; Oder Chiou; Bard Liao; Liam Girdwood; Jarkko Nikula
> Subject: [PATCH] ASoC: rt5640: Add minimal support for RT5642
> 
> We have been using rt5640.c codec driver with RT5642 codec chip before commit
> 022d21f004c1 ("ASoC: rt5640: add rt5639 support"). That commits starts using
> device ID reading in reset register for adding device specific controls and routes
> runtime.
> 
> Now since device ID appears to be different between RT5640 and RT5642 the
> driver doesn't add those controls and routes that are valid also on RT5642.
> 
> Fix this by adding a device ID found by debugging and minimal code for supporting
> RT5642.
> 
> 
>  #define RT5639_RESET_ID				0x0008
>  #define RT5640_RESET_ID				0x000c
> +#define RT5642_RESET_ID				0x0006
> 

Actually, the device is store in bit 1 and 2. So we need a mask when reading the device ID.
I will send another patch for doing it.

> ------Please consider the environment before printing this e-mail.
