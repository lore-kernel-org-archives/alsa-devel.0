From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/6] Rewrite some drivers to use nonatomic PCM
	ops
Date: Thu, 11 Sep 2014 16:00:19 +0200
Message-ID: <1410444025-22772-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A53B226575B
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 16:00:32 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2C270AD26
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 14:00:30 +0000 (UTC)
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

here is a series of patches that can be applied on the top of my
for-next branch including the patches for nonatomic PCM ops
support.  They rewrite a few drivers to use this new feature,
mostly by converting to the threaded irq from tasklet and merging
the code into the original trigger callback.

I've tested a few Digigram devices I have, but some are just
compile-tested.

 [PATCH 1/6] pcmcia: Add pcmcia_request_threaded_irq()
 [PATCH 2/6] ALSA: vx: Use nonatomic PCM ops
 [PATCH 3/6] ALSA: mixart: Use nonatomic PCM ops
 [PATCH 4/6] ALSA: pcxhr: Use nonatomic PCM ops
 [PATCH 5/6] ALSA: lx6464es: Use nonatomic PCM ops
 [PATCH 6/6] ALSA: pdaudiocf: Use nonatomic PCM ops


Takashi
