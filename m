From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH 0/2] ALSA: hda - More pop noise fixes for Dell
	XPS 13 9333
Date: Fri,  8 Aug 2014 19:34:39 +0200
Message-ID: <cover.1407518135.git.gabriele.mzt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
 [209.85.212.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BA8C26555C
 for <alsa-devel@alsa-project.org>; Fri,  8 Aug 2014 19:35:10 +0200 (CEST)
Received: by mail-wi0-f175.google.com with SMTP id ho1so1393384wib.14
 for <alsa-devel@alsa-project.org>; Fri, 08 Aug 2014 10:35:09 -0700 (PDT)
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
Cc: tiwai@suse.de, superquad.vortex2@gmail.com, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: alsa-devel@alsa-project.org

Fix the pop noises that happen when the laptop is booting and when it's
rebooting.

Gabriele Mazzotta (2):
  ALSA: hda - Set internal mic as default input source on Dell XPS 13
    9333
  ALSA: hda - Fix pop noises on reboot for Dell XPS 13 9333

 sound/pci/hda/patch_realtek.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
2.1.0.rc1
