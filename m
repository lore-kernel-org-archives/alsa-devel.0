From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH 1/2] ASoC: rt5677: Add TDM
	channelselectfunction
Date: Thu, 16 Oct 2014 13:52:53 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D12694F29E4C@RTITMBSV03.realtek.com.tw>
References: <1413367334-12615-1-git-send-email-oder_chiou@realtek.com>
 <543FB7C6.90600@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 493CA2608F0
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 15:53:00 +0200 (CEST)
In-Reply-To: <543FB7C6.90600@metafoo.de>
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
To: Lars-Peter Clausen <lars@metafoo.de>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
> Sent: Thursday, October 16, 2014 8:19 PM
> To: Oder Chiou; broonie@kernel.org; lgirdwood@gmail.com
> Cc: Bard Liao; alsa-devel@alsa-project.org; Flove
> Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: rt5677: Add TDM channel
> selectfunction
> 
> On 10/15/2014 12:02 PM, Oder Chiou wrote:
> > Add TDM channel select function.
> 
> Can you explain in a bit more detail what this does exactly? Is this for channel to
> slot mapping?
> 

Yes, it is for channel to slot mapping, and it is not only for 8 channels mapping, but also
in 2, 4 and 6 channels mapping. If we want to use the 2 channels in the stereo2 adc path,
we need to set the setting to item "2/1/3/4" or "2/3/1/4".
