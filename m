From: Wei Ni <wni@nvidia.com>
Subject: About HDMI audio driver
Date: Tue, 29 Dec 2009 15:56:32 +0800
Message-ID: <6B4D417B830BC44B8026029FD256F7F1BEBFFFD037@HKMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.112.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 09B8D2433C
	for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2009 08:56:36 +0100 (CET)
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

Hi, Takashi
I'm a nvidia engineer. We plan to develop the new hdmi audio driver for the new chipset. It support the latest HD Audio Specification.
I download the latest kernel source, it has patch_intelhdmi.c. And this file have many defines and routines for HDMI operations.
If I develop hdmi driver, it also need to define the same functions in patch_nvhdmi.c, it seems not very well.
Do you have plan to change these codes to common code?  I think these codes are common for HDMI audio.

BTW I have a another question.
Because the standard ALSA channel mapping is different with the Windows setting. So  we could use channel-slot assignment (verb 0x734) to fix.
How can I know the audio is using ALSA setting or Windows setting? Does there have any mechanism to support this operation?

Thanks
Wei.


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
