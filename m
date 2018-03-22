From: <twischer@de.adit-jv.com>
Subject: [PATCH - IOPLUG DRAIN 0/2]
Date: Thu, 22 Mar 2018 14:48:55 +0100
Message-ID: <1521726537-7651-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id A242B26739D
 for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2018 14:49:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi Takashi,

> Why not poll()?

> IOW, why ioplug must be handled specially regarding the non-blocking
>operation?  The normal kernel driver behaves like that (returning
> -EAGAIN, and let apps to sync with poll()).


What do you think about the following solution?

(I thought the whole time that you have to use snd_pcm_wait() to wait for drain
in nonblocking mode but you have to use the poll_descriptors directly.)

Know I am expecting that the user is calling poll()
if snd_pcm_drain() returns -EAGAIN and
the user has to call snd_pcm_drain() again after poll returns
to check if drain is done.

Thanks for your help so far.

Best regards

Timo
