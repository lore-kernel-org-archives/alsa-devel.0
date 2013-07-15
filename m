From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/10] snd_pcm_stop() lock fixes
Date: Mon, 15 Jul 2013 15:06:12 +0200
Message-ID: <1373893582-17116-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F2FF82610B4
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 15:05:26 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C0A2AA51CB
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 15:05:26 +0200 (CEST)
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

while reviewing another patch series, I stumbled on the snd_pcm_lock()
call in an unlocked context.  Then I started looking through the whole
tree, and found a bunch of drivers doing it wrong, too.  So here is a
patch series to fix them.

 [PATCH 01/10] ALSA: asihpi: Fix unlocked snd_pcm_stop() call
 [PATCH 02/10] ALSA: atiixp: Fix unlocked snd_pcm_stop() call
 [PATCH 03/10] ALSA: 6fire: Fix unlocked snd_pcm_stop() call
 [PATCH 04/10] ALSA: ua101: Fix unlocked snd_pcm_stop() call
 [PATCH 05/10] ALSA: usx2y: Fix unlocked snd_pcm_stop() call
 [PATCH 06/10] ALSA: pxa2xx: Fix unlocked snd_pcm_stop() call
 [PATCH 07/10] ASoC: atmel: Fix unlocked snd_pcm_stop() call
 [PATCH 08/10] ASoC: s6000: Fix unlocked snd_pcm_stop() call
 [PATCH 09/10] [media] saa7134: Fix unlocked snd_pcm_stop() call
 [PATCH 10/10] staging: line6: Fix unlocked snd_pcm_stop() call


Takashi
