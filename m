From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC v2 0/7] Allow multiple callbacks for
	hda_jack
Date: Mon, 15 Sep 2014 14:48:16 +0200
Message-ID: <1410785303-19454-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 47A25261643
 for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2014 14:48:27 +0200 (CEST)
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
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi,

here is a v2 patchset for allowing multiple callbacks for hda_jack.
The difference from the previous patchset is typo fixes, more
comments on the return value from snd_hda_jack_detect_enable_callback(),
and the missing check of jack->jack_detect flag.


Takashi
