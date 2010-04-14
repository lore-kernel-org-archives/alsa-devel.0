From: Takashi Iwai <tiwai@suse.de>
Subject: BKL removal from ALSA core
Date: Wed, 14 Apr 2010 10:14:19 +0200
Message-ID: <1271232862-16183-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C1CE24476
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 10:14:44 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 0F2A06CB00
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 10:14:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
I recently cleaned up ALSA core code a bit.  The first attemp is the
removal of BKL, at least, in ALSA side.  There are still in sound_core.c
and OSS drivers, but who cares ;)

The patches below are in sound git tree topic/bkl branch.

 [PATCH 1/3] ALSA: pcm - Remove BKL from async callback
 [PATCH 2/3] ALSA: info - Remove BKL
 [PATCH 3/3] ALSA: Remove BKL from open multiplexer


Takashi
