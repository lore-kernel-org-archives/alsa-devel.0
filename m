From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] Kill the rest snd_print*() usages
Date: Tue, 28 Oct 2014 17:45:12 +0100
Message-ID: <1414514715-569-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C9D22261AAB
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 17:45:17 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4CA1AAC7E
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 16:45:17 +0000 (UTC)
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

it's a small series to get rid of snd_print*() usages in a few
PCI sound drivers.  There remain still a few, I know, but this is
just a matter of cleanup, so let them be there...

 [PATCH 1/3] ALSA: ctxfi: Kill the rest snd_print*()
 [PATCH 2/3] ALSA: pcxhr: Kill the rest snd_print*()
 [PATCH 3/3] ALSA: au88x0: Kill the rest snd_print*()

Takashi
