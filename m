From: Vladimir Barinov <Vladimir_Barinov@mentor.com>
Subject: Re: [PATCH 2/3] ASoC: tlv320aic3x: Convert codec->hw_read to snd_soc_read
Date: Fri, 14 Oct 2011 23:44:21 +0400
Message-ID: <4E989115.5000304@mentor.com>
References: <1318556120.6379.1.camel@phoenix> <1318556220.6379.3.camel@phoenix> <20111014193553.GH2931@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111014193553.GH2931@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Axel Lin <axel.lin@gmail.com>, linux-kernel@vger.kernel.org, Vladimir Barinov <vbarinov@embeddedalley.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Fri, Oct 14, 2011 at 09:37:00AM +0800, Axel Lin wrote:
>   
>> codec->hw_read is broken now, let's covert to snd_soc_read.
>>
>> Signed-off-by: Axel Lin <axel.lin@gmail.com>
>>     
>
> Applied, thanks.  You really should CC the TI guys on this driver,
> especially Jarkko, as they have been doing most of the work on it.
> Vladimir hasn't been very active since the initial contribution.
>   
Yes, please, since I have no actual h/w and can't maintain the codec 
driver anymore.
Also the layer specific changes (not h/w related) should be reviewed by 
ASoC guru and not me.

Regards,
Vladimir
