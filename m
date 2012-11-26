From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/2] Add channel map support to usb-audio
Date: Mon, 26 Nov 2012 16:36:31 +0100
Message-ID: <1353944193-16190-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F3FEE265177
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 16:36:45 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id C37E2A4386
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 16:36:45 +0100 (CET)
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

the following patches are my recent work to add the channel map support
to usb-audio driver.  Since UAC2 has yet more channel definitions, I
had to extend SNDRV_CHMAP_*.

Other than that, a fairly straightforward implementation by converting
the channel config bitmap of usb descriptor to the chmap array.


Takashi
