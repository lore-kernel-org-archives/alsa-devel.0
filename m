From: gsantosh@codeaurora.org
Subject: Question on wait_for_avail function
Date: Wed, 5 Jun 2013 08:28:14 -0000
Message-ID: <1794d77072add642c43309c0a06bfadb.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.11.231])
 by alsa0.perex.cz (Postfix) with ESMTP id 11D3F261A03
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 10:28:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi Liam,

Consider an use case
1) Write is blocked as there is no space to write the data,
after the return from snd_pcm_playback_avail()function in wait_for_avail
2) HAL issues pause in parallel to the write
I see that the following function snd_pcm_post_pause unblock the write
		wake_up(&runtime->sleep);
		wake_up(&runtime->tsleep);
But i do not see any case handling for the pause state in the
wait_for_avail function, it is not coming out of the for loop as there
will not be any change in the buffer states.

Please explain what is the intention behind the wake in pause callback.

Want to understand why there is no handling of pause in wait_for_avail
function.

and also is there any restriction from ALSA framework that we should not
issue pause while write is blocked or going on.

Regards,
Santosh M G.
