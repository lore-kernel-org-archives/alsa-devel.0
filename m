From: David Henningsson <david.henningsson@canonical.com>
Subject: Send to stable for "ALSA: hda - Move one-time init
	codes from generic_hdmi_init()"?
Date: Mon, 11 Mar 2013 11:03:09 +0100
Message-ID: <513DABDD.9020200@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 8357E26086D
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 11:03:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Should this patch be sent to stable?

commit 8b8d654b55648561287bd8baca0f75f964a17038
Author: Takashi Iwai <tiwai@suse.de>
Date: Wed Jun 20 16:32:22 2012 +0200

     ALSA: hda - Move one-time init codes from generic_hdmi_init()

I'm investigating a kernel panic under kernel 3.5, and I'm not 100% sure 
(still waiting for person with hw to report back), but the only 
reasonable explanation I can find is that there is some power management 
activity going while the repoll timer (for hdmi_present_sense) is 
running, and that generic_hdmi_init reinitializes the delayed_work 
struct, thus causing the panic when the timer has elapsed.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
