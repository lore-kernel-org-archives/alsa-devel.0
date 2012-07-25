From: gsantosh@codeaurora.org
Subject: ALSA concurrent use case for 5.1 LPCM on HDMI.
Date: Wed, 25 Jul 2012 01:37:02 -0700 (PDT)
Message-ID: <16e078f384eda9134af4b78dec4ec090.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
 [199.106.114.251])
 by alsa0.perex.cz (Postfix) with ESMTP id 14FDF265D9A
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 10:37:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Hi All,

I have following use case I am facing an issue with the ALSA framework,

Consider a use case

1)	System tone or any stream running on Front End 0 with stereo channel
configuration On Back End 0(HDMI)
2)	Start a local file playback for 5.1 LPCM on Front End 1 with 5.1
channel configuration On Back End 0(HDMI)

Here FE0 and FE1 is routed to same BE0.

When step 2 is done I see following behavior of ALSA which is not correct.
Framework will check that the BE0 is running with FE0 routed and running,
Framework will not trigger the fixup and hw_params callback to re
configure the session for FE1 with 5.1 channel.

With this effect we are playing the FE1 session with stereo instead of 5.1
channel configuration, how to rectify this issue?

Regards,
Santosh M G.
