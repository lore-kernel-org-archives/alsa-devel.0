From: Takashi Iwai <tiwai@suse.de>
Subject: [RFC][PATCH 0/2] Allow nonatomic trigger operations
Date: Mon,  1 Sep 2014 14:00:30 +0200
Message-ID: <1409572832-32553-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DA6D7264EAA
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 14:00:44 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1FF24AD26
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 12:00:42 +0000 (UTC)
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

Hi,

this is a quick hack for the features that have been requested by
quite a few people since long time ago: the support of non-atomic
PCM trigger.  I've tested only with a limited driver set, so more
tests and comments/reviews are appreciated.

 [PATCH 1/2] ALSA: pcm: Allow nonatomic trigger operations
 [PATCH 2/2] ALSA: pcm: Uninline snd_pcm_stream_lock() and _unlock()

thanks,

Takashi
