From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 0/9] Final bits for HD-audio generic parser
Date: Thu, 17 Jan 2013 17:54:45 +0100
Message-ID: <1358441694-32004-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0833D2651CE
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 17:55:00 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id D2980A3DDF
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 17:54:59 +0100 (CET)
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

this is the final bits for improving / fixing the HD-audio generic
parser for migrating patch_sigmatel.c.  After these, patch_sigmatel.c
is converted to use the generic parser, and all done!

As usual, the patches are found in sound-unstable git tree
test/hda-gen-parser branch (it's already merged into master and
test/hda-migrate branch, too).

Takashi
