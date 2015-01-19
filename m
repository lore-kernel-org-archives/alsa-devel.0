From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/17] More line6 driver code reorg and cleanups
Date: Mon, 19 Jan 2015 16:54:34 +0100
Message-ID: <1421682891-11594-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 129DF2610B7
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 16:55:03 +0100 (CET)
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

Hi,

here is a series of patches I hacked quickly after merging line6
stuff into sound git tree.  There are two significant changes:

- Split to each driver and renames: now there are 4 card modules,
  snd-usb-pod, snd-usb-podhd, snd-usb-toneport and snd-usb-variax,
  while snd-usb-line6 serves as a common helper module.

- Many codes restrucruring, especially cleanup of the resource
  management; the destructor is solely called from card's private_free
  now

The current merged code is found in topic/line6 branch of sound.git
tree while this development code is found in test/line6 branch.
The devel branch hasn't been merged to linux-next yet, I'm waiting
for any good/bad test results.  So, give me any feedback.  Thanks!

(BTW, the next step would be to straighten the init code in pod.c,
 etc instead of (ab)using the system timer.  Instead, it should be
 a flat function with wait_event() of such.) 


Takashi
