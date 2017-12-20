From: srainey@delta-info.com
Subject: =?utf-8?q?pcm=5Fpost=5Fstart_race_condition_with_har?=
 =?utf-8?q?dware_error_interrupts?=
Date: Wed, 20 Dec 2017 12:07:50 -0500 (EST)
Message-ID: <1513789670.25613586@apps.rackspace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp113.iad3a.emailsrvr.com (smtp113.iad3a.emailsrvr.com
 [173.203.187.113])
 by alsa0.perex.cz (Postfix) with ESMTP id B6D102677EC
 for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2017 18:07:51 +0100 (CET)
Received: from smtp31.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
 by smtp31.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 6EAA1249D3
 for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2017 12:07:50 -0500 (EST)
Received: from app62.wa-webapps.iad3a (relay-webapps.rsapps.net
 [172.27.255.140])
 by smtp31.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 5619B24A86
 for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2017 12:07:50 -0500 (EST)
Received: from delta-info.com (localhost.localdomain [127.0.0.1])
 by app62.wa-webapps.iad3a (Postfix) with ESMTP id 3EFFD41200
 for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2017 12:07:50 -0500 (EST)
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
List-Id: alsa-devel@alsa-project.org


This is more of a general question/issue, but a bit of background: I encountered this in trying to resolve an issue on a fairly mature embedded ARM platform wherein captured audio was left/right swapped some small percent (~4%) of the time on startup.  I should mention that I'm locked into using a fairly old kernel on this platform, but having a quick look at the latest at kernel.org reveals it to be not much changed.
 
In tracing events, I found that during the stream startup, the following sequence is possible (and indeed does happen some small percent of time):
 
-Audio Pipeline startups routines are kicked off through snd_pcm_action_start, eventually calling the driver's trigger op.
 
-The driver's trigger function is called with  SNDRV_PCM_TRIGGER_START command, which configures the necessary hardware and enables interrupts.
 
-While the startup sequence is still running, an interrupt is generated due to some real error condition in the hardware, and the ISR sets the stream's state to SNDRV_PCM_STATE_XRUN.
 
-The startup sequence reaches snd_pcm_post_start, which unconditionally sets the stream's state to RUNNING, clobbering the error state if it was set.  See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/core/pcm_native.c?h=v4.15-rc4#n1192
 
If the hardware reaches an error state, the user must be informed in order to take action, but the unconditional assignment here does not allow that to happen if there is a hardware error in this small startup time.  I don't have a patch because I am working on a very old vendor provided kernel (2.6.37), but by only setting the state if the current state is PREPARED, along with some other necessary changes in the driver, I was able to mitigate the l/r swap issue and get correct behavior.
 
This is likely a very rare issue, but also it was somewhat difficult to debug.  I'm not familiar enough with kernel dev processes or the audio framework to say something should be done or if there is perhaps some other solution here.  It seems like something *should* be done anyway. 
 
 
 
