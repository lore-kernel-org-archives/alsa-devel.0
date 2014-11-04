From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/5] A few ALSA PCM core update patches
Date: Tue,  4 Nov 2014 14:28:11 +0100
Message-ID: <1415107696-17123-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F126726147E
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 14:28:19 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5FF74AB08
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 13:28:19 +0000 (UTC)
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

here is a small series of patches for cleaning up / enhancing the
PCM core stuff.

 [PATCH 1/5] ALSA: pcm: Simplify snd_pcm_action_lock_irq()
 [PATCH 2/5] ALSA: pcm: Refactoring snd_pcm_action()
 [PATCH 3/5] ALSA: pcm: Correct PCM BUG error message
 [PATCH 4/5] ALSA: pcm: Replace PCM hwptr tracking with tracepoints
 [PATCH 5/5] ALSA: pcm: Add xrun_injection proc entry


Takashi
