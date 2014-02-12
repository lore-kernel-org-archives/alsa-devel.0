From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 00/10] Use standard printk helpers for ALSA
	core codes
Date: Wed, 12 Feb 2014 12:33:02 +0100
Message-ID: <1392204792-12655-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 34B04264F34
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 12:33:18 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DDF84ABF7
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:33:17 +0000 (UTC)
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

OK, this is the last batch.  This series converts the use of
snd_printk() and co with the standard ones like dev_err() in ALSA
core codes.  This became possible now by the new card device
management.


Takashi
