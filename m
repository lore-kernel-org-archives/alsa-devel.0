From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/6] HD-audio cleanup patches
Date: Mon, 18 Aug 2014 17:30:27 +0200
Message-ID: <1408375833-22957-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 38E5E26575E
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 17:30:36 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A7D2EAC81
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 15:30:35 +0000 (UTC)
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

below is a series of cleanup patches for HD-audio, targeted for 3.18.
Most of them are pretty trivial, just removing the unnecessary codes
or replacing with the helper functions.  Some resulted in relatively
large rewrites with tables, and LOC slightly grows, but the actual
code size is reduced by that.

 [PATCH 1/6] ALSA: hda - Remove obsoleted snd_hda_check_board_config()
 [PATCH 2/6] ALSA: hda - Remove obsoleted EXPORT_SYMBOL_HDA() macro
 [PATCH 3/6] ALSA: hda/realtek - Optimize alc888_coef_init()
 [PATCH 4/6] ALSA: hda/realtek - Use alc_write_coef_idx() in
 [PATCH 5/6] ALSA: hda/realtek - Add alc_update_coef*_idx() helper
 [PATCH 6/6] ALSA: hda/realtek - Use tables for batch COEF


Takashi
