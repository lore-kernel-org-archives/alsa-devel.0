From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 0/3] ALSA: hda - Delay HDMI presence reports
	while waiting for ELD information
Date: Thu,  7 Nov 2013 13:38:22 +0100
Message-ID: <1383827905-2618-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E974265524
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 13:38:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I tested the patch you sent me last week on an Intel machine and it seems to
work. I don't have any full set of PulseAudio patches written yet that makes of
use of this, so I tested mainly with printk's to see that the eld was updated
before the jack was sent to userspace.

In addition, I added a workaround for the race condition that could happen
if you try to probe two monitors simultaneously.

For completeness I'm also sending the patch you sent me in this series. I think
it is good enough to go into 3.13.
