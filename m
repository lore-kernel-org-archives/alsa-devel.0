From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/5] ALSA: usb-audio: fixes for quirks of
	Tascam US-16x08
Date: Tue, 21 Feb 2017 05:09:16 +0900
Message-ID: <20170220200921.824-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 1EE85266B2A
 for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2017 21:09:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: onkel@paraair.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

A commit d2bb390a2081 ("ALSA: usb-audio: Tascam US-16x08 DSP mixer quirk")
was merged just now, while static code checker reports some apparent bugs.

This patchset is to solve the bugs.

Takashi Sakamoto (5):
  ALSA: usb-audio: localize one-referer variable
  ALSA: usb-audio: purge needless variable length array
  ALSA: usb-audio: localize function without external linkage
  ALSA: usb-audio: deallocate memory objects in error path
  ALSA: usb-audio: fix msleep timeout due to minimum resolution of task
    scheduling

 sound/usb/mixer_us16x08.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

-- 
2.9.3
