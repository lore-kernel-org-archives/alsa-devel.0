From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: sof/hda rework to share more of patch_hdmi.c logic
Date: Thu, 15 Aug 2019 17:28:02 +0300 (EEST)
Message-ID: <alpine.DEB.2.21.1908151641110.16459@zeliteleevi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B54C5F8011F
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 16:28:07 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I notice you are doing a lot of cleanups to HDA code. Just FYI I'm looking 
into modifying the SOF Intel backend to use 
snd-hda-codec-hdmi/patch_hdmi.c for HDMI/DP audio support, i.e. to be able 
to share this code between snd-hda-intel and SOF Intel (and not using 
hdac-hdmi).

Let me know if this clashes with something you are already looking into. I 
have a very rough version up and running, but it still needs some work. If 
the general idea seems ok to you, I'll continue to work on a RFC patch and 
send for review.

This will change how HDMI is exposed to user-space with SOF Intel drivers, 
so we need to be extra careful how this is introduced. But this really 
seems to be the best way to go to avoid the duplicated maintenance work 
with two drivers that we now have.

PS Tracked in SOF github as 
   https://github.com/thesofproject/linux/issues/1123

Br, Kai
