From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 0/8] Use generic parser for HD-audio codec
	drivers
Date: Tue,  8 Jan 2013 12:50:41 +0100
Message-ID: <1357645849-8181-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 69C302651B1
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:50:59 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 50175A3E1C
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:50:59 +0100 (CET)
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

this is the next series of patches to convert various codec drivers
to use the new generic parser code.  Most of changes are obvious, but
some places it gets tricky.

As mentioned in another mail, the patches are found in sound-unstable
git tree test/hda-migrate branch
  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable.git


Takashi
