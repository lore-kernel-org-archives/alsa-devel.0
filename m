From: Wei Ni <wni@nvidia.com>
Subject: Re: About HDMI audio driver
Date: Tue, 29 Dec 2009 16:43:02 +0800
Message-ID: <6B4D417B830BC44B8026029FD256F7F1BEBFFFD038@HKMAIL01.nvidia.com>
References: <6B4D417B830BC44B8026029FD256F7F1BEBFFFD037@HKMAIL01.nvidia.com>
	<s5hy6km6v0n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.112.145])
	by alsa0.perex.cz (Postfix) with ESMTP id AB0AD243A9
	for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2009 09:43:06 +0100 (CET)
In-Reply-To: <s5hy6km6v0n.wl%tiwai@suse.de>
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
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: Peer Chen <pchen@nvidia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Ok, thanks for your reply.
Happy holidays!

Thanks
Wei.

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Tuesday, December 29, 2009 4:32 PM
To: Wei Ni
Cc: alsa-devel@alsa-project.org; Peer Chen
Subject: Re: About HDMI audio driver

At Tue, 29 Dec 2009 15:56:32 +0800,
Wei Ni wrote:
> 
> Hi, Takashi
> I'm a nvidia engineer. We plan to develop the new hdmi audio driver for the new chipset. It support the latest HD Audio Specification.
> I download the latest kernel source, it has patch_intelhdmi.c. And this file have many defines and routines for HDMI operations.
> If I develop hdmi driver, it also need to define the same functions in patch_nvhdmi.c, it seems not very well.
> Do you have plan to change these codes to common code?  I think these codes are common for HDMI audio.

Well, ideally, we merge all three patch_*hdmi.c into one, say,
patch_hdmi.c.  The merging of patch_atihdmi.c would be trivial, but
nvidia one would need a bit more changes to add codec-specific
setups.

So, it'd be nice if you implement the newer code in that direction.

> BTW I have a another question.
> Because the standard ALSA channel mapping is different with the Windows setting. So  we could use channel-slot assignment (verb 0x734) to fix.
> How can I know the audio is using ALSA setting or Windows setting? Does there have any mechanism to support this operation?

Right now there is no "Windows" setting on ALSA.
The channel map is fixed as FL/FR/RL/RR/C/LFE/SL/SR.

I have a plan to add an API for querying / changing the channel map, but
it's still a vaporware.

BTW, I'm on vacation from tomorrow until Jan. 10.  So the reply may be
delayed.


thanks,

Takashi
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
