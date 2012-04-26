From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Required/preferred multichannel order for ALSA
Date: Thu, 26 Apr 2012 16:33:57 -0500
Message-ID: <4F99BF45.4020909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 5427E10BC60
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2012 23:34:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Castaneda Gonzalez, Axel" <x0055901@ti.com>, alsa-devel <alsa-devel@alsa-project.org>, Ujfalusi <peter.ujfalusi@ti.com>, "Guiriec,  Sebastien" <s-guiriec@ti.com>, Peter@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi, list,

I am implementing multichannel support for HDMI on Texas Instruments' 
OMAP4. I would like to know if ALSA mandates a specific channel order or 
has a preferred one.

I tried to find some guidance in alsa-lib or in the alsa driver. All I 
could find is the order described in speaker-test: 
FL/FR/RL/RR/C/LFE/SL/SR. This order seems to be in use due to historical 
reasons [1]. It was also mentioned that an API to set/get the channel 
mapping was going to be implemented [2]; I tried to find it without 
success. As [1] and [2] are very old posts, I was wondering if the 
situation has changed.

My question arises from the fact that HDMI audio uses the channel 
ordering defined in CEA-861 section 6.6.2, which is different from what 
speaker-test expects. This also different from the order that SMPTE 320M 
specifies. OMAP4 is able to alter the channel mapping, so I could match 
what ALSA expects if such required/preferred order exists.

Thanks in advance for your comments.

Ricardo


[1].http://www.spinics.net/lists/alsa-devel/msg24444.html
[2].http://www.spinics.net/lists/alsa-devel/msg24495.html
