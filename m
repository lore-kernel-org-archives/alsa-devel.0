From: Liam Girdwood <lrg@ti.com>
Subject: Re: Required/preferred multichannel order for ALSA
Date: Fri, 27 Apr 2012 10:21:37 +0100
Message-ID: <1335518497.4150.6.camel@odin>
References: <4F99BF45.4020909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog129.obsmtp.com (na3sys009aog129.obsmtp.com
	[74.125.149.142])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A72E10BE54
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 11:21:42 +0200 (CEST)
Received: by werb10 with SMTP id b10so488695wer.17
	for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2012 02:21:39 -0700 (PDT)
In-Reply-To: <4F99BF45.4020909@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: "Castaneda Gonzalez, Axel" <x0055901@ti.com>, alsa-devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "Guiriec,
	Sebastien" <s-guiriec@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-04-26 at 16:33 -0500, Ricardo Neri wrote:
> Hi Takashi, list,
> 
> I am implementing multichannel support for HDMI on Texas Instruments' 
> OMAP4. I would like to know if ALSA mandates a specific channel order or 
> has a preferred one.
> 
> I tried to find some guidance in alsa-lib or in the alsa driver. All I 
> could find is the order described in speaker-test: 
> FL/FR/RL/RR/C/LFE/SL/SR. This order seems to be in use due to historical 
> reasons [1]. It was also mentioned that an API to set/get the channel 
> mapping was going to be implemented [2]; I tried to find it without 
> success. As [1] and [2] are very old posts, I was wondering if the 
> situation has changed.
> 
> My question arises from the fact that HDMI audio uses the channel 
> ordering defined in CEA-861 section 6.6.2, which is different from what 
> speaker-test expects. This also different from the order that SMPTE 320M 
> specifies. OMAP4 is able to alter the channel mapping, so I could match 
> what ALSA expects if such required/preferred order exists.
> 
> Thanks in advance for your comments.
> 
> Ricardo
> 
> 
> [1].http://www.spinics.net/lists/alsa-devel/msg24444.html
> [2].http://www.spinics.net/lists/alsa-devel/msg24495.html

A lot of hardware now can remap channels to suit the use case so it
would probably be good to have an ALSA API to get/set the mappings.

This seems like it would be a good subject for the BoF.

Liam
