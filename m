From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] Yet more kenreldoc fixes
Date: Mon, 10 Nov 2014 17:32:31 +0100
Message-ID: <1415637155-20918-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 52555261AFF
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 17:32:39 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 357D0ABE7
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 16:32:39 +0000 (UTC)
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

these are a series of patches to fix kerneldoc errors / warnings.
These aren't actaully compiled from DocBook directory, so they are
harmless, but better to be fixed, of course.

 [PATCH 1/4] ALSA: vx: Fix missing kenreldoc parameter descriptions
 [PATCH 2/4] ALSA: hda - Fix kerneldoc errors in patch_ca0132.c
 [PATCH 3/4] ALSA: mixart: Fix kerneldoc comments
 [PATCH 4/4] ALSA: Fix invalid kerneldoc markers


Takashi
