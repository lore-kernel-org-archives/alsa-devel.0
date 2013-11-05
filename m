From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/5] Let's kill BUG*()
Date: Tue,  5 Nov 2013 18:10:38 +0100
Message-ID: <1383671443-13707-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D8B32619F9
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:10:47 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DC569A67E7
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:10:46 +0100 (CET)
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

this is a series of trivial patches to kill BUG() and BUG_ON()
in sound/* (except for ASoC codes, which will follow later).

Basically BUG() and BUG_ON() are usless for drivers like sound
drivers, because they stop the whole operation intentionally by
calling panic().  In this patch series, they are replaced with
WARN_ON(), snd_BUG() or something else more soft ones.

 [PATCH 1/5] ALSA: ctxfi: Use WARN_ON() instead of BUG_ON()
 [PATCH 2/5] ALSA: ps3: Use WARN_ON() instead of BUG_ON()
 [PATCH 3/5] ALSA: sparc/cs4231: Use WARN_ON() instead of BUG_ON()
 [PATCH 4/5] ALSA: mips/ad1843: Use WARN_ON() instead of BUG_ON()
 [PATCH 5/5] ALSA: pxa2xx: Replace BUG() with snd_BUG()


Takashi
