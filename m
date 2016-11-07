From: David Jordan <david2@system76.com>
Subject: Fixup set PCM/headphones volume from Master
Date: Mon, 07 Nov 2016 08:59:39 -0800
Message-ID: <1478537979.2123627.780087305.7503B79D@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 679EB2667B2
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2016 17:59:39 +0100 (CET)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 4A113208C9
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2016 11:59:39 -0500 (EST)
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

I'm working on a kernel-level fixup for a set of hardware which uses a
separate DAC for the "headphones" output.  So far, I've gotten
everything but the volume control working correctly.  "PCM Playback
Volume" controls the headphones volume since the same digital output
drives both SPDIF and the analog headphones jack.  

So, "PCM Playback Volume" should always equal "Master Playback Volume"
when headphones are plugged in. (You can't insert both an SPDIF and
headphones at the same time anyway, since they use the same jack, so
there's no downside there.)

Here's where I could really use some help from people who know ALSA
plumbing better than I do.  It seems to me this should be possible by
overriding the "Master Playback Volume" put function with one that finds
the "PCM Playback Volume" control and sets the volume for both controls.

For some reason, I can't seem to access the PCM control from my master
put function.  Attempts to find it via snd_ctl_find_id or
snd_ctl_find_numid result in kernel oops.  There might be something
simple I'm missing, or perhaps there is a better way to link the two
volume controls?


-- 
  David Jordan
  david2@system76.com
