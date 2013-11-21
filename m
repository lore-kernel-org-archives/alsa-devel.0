From: Oleksij Rempel <linux@rempel-privat.de>
Subject: acceptable noise level for mic boost
Date: Thu, 21 Nov 2013 16:35:20 +0100
Message-ID: <528E2838.8050208@rempel-privat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 66CF9260786
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 16:35:25 +0100 (CET)
Received: from [192.168.1.138] ([93.218.98.132]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0M2FhY-1VR2470lKm-00s4dC for
 <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 16:35:23 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

what is acceptable noise level for mic boost?
My laptop has three levels of mic boost (+36dB). Level 3 is useless
since noise level will be about 0db. With level 1 i get -12dB noise, so
there is almost 12dB room for data... but it is not enough for normal
speech, which is about 20dB.

Are there any ALSA guide for HW designers, which will say some thing
like acceptable levels are 90-20dB?
There are some Skype and Microsoft prescriptions for certification.
For example M$ prescribe 18dB or more for speech to noise ration for
build in mics. It sound like good number to start.

In my case, i need to remove mic boost completely to guarantee minimum
18dB SpNR. Suddenly i didn't found correct way to do it.
I will be thankful for some tip.
-- 
Regards,
Oleksij
