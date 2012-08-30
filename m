From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 0/3] ALSA: snd-usb: Regression fixes for 3.5
Date: Thu, 30 Aug 2012 18:52:28 +0200
Message-ID: <1346345551-8956-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 792CD265DB2
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2012 18:52:56 +0200 (CEST)
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
Cc: tiwai@suse.de, linux@romal.de, clemens@ladisch.de, linuxaudio@showlabor.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Here are 3 more regression fixes for snd-usb in 3.5. It's annoying
they haven't been found earlier, but at least we're now back to the
streaming quality we had before the streaming refactoring.

Anyone with a USB device, please give it a quick shot at least.

Thanks,
Daniel


Daniel Mack (3):
  ALSA: snd-usb: restore delay information
  ALSA: snd-usb: fix calls to next_packet_size
  ALSA: snd-usb: fix cross-interface streaming devices

 sound/usb/endpoint.c | 13 +------------
 sound/usb/endpoint.h |  1 +
 sound/usb/pcm.c      | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 49 insertions(+), 16 deletions(-)

-- 
1.7.11.4
