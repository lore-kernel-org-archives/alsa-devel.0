From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 0/3] alsa-lib - improve surround 2.1 support
Date: Fri, 21 Feb 2014 16:24:19 +0100
Message-ID: <1392996262-27970-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id D9A1A2658DE
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2014 16:24:24 +0100 (CET)
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

So, in order to support 2.1 surround on both 4-channels (e g FL FR LFE LFE,
on internal subwoofer) and 6-channels (e g FL FR RL RR C LFE, on desktops
with 5.1 out), I needed to make the route plugin more chmap aware.

This also included allowing a new syntax for the ttable, which I think is
quite nice. The new syntax also falls back to ALSAs standard chmap in case
the hardware does not support it.

David Henningsson (3):
  route: Allow chmap syntax for slave channels in ttable
  route: Select slave chmap based on ttable information
  conf: Allow 2.1 surround to use different number of channels

 src/conf/pcm/surround21.conf |   7 +-
 src/pcm/pcm_route.c          | 304 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 271 insertions(+), 40 deletions(-)

-- 
1.9.0
