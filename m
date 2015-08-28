From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH v2] ASoC: rt5645: Prevent the pop sound of
	the headphone while rebooting or shutdowning
Date: Fri, 28 Aug 2015 01:47:10 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D12694F918FA@RTITMBSV03.realtek.com.tw>
References: <1440659691-1835-1-git-send-email-oder_chiou@realtek.com>
 <20150827191722.GK5313@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 464E7265CB5
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2015 03:47:19 +0200 (CEST)
In-Reply-To: <20150827191722.GK5313@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, "woojoo.lee@samsung.com" <woojoo.lee@samsung.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, August 28, 2015 3:17 AM
> To: Oder Chiou
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Flove; Bard Liao; John Lin;
> woojoo.lee@samsung.com
> Subject: Re: [PATCH v2] ASoC: rt5645: Prevent the pop sound of the headphone
> while rebooting or shutdowning
> 
> On Thu, Aug 27, 2015 at 03:14:51PM +0800, Oder Chiou wrote:
> > Add i2c shutdown function to prevent the pop sound of the headphone while
> > the system is rebooting or shutdowning. It de-initials the jack detection
> > function, and it cannot be turned off in _BIAS_OFF. If we don't de-initial
> > it, the pop sound will be heard in the situation of powering off. And
> > replace the related register settings from magic number to meaningful
> > defined name.
> 
> A comment in the changelog is useful but I was really looking for one in
> the code here so people don't need to dive into the logs to understand
> what's going on.
> 
Thank you for your kind remind and advice.
