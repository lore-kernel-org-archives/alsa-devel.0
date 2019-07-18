From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/2] ALSA: AMD and Nvidia HD-audio component
	notifier support
Date: Thu, 18 Jul 2019 11:43:19 +0200
Message-ID: <20190718094321.16442-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE8B0F800C0
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2019 11:43:24 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A5BC0ABF4
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2019 09:43:23 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

this is a revival of my old patchset for adding the support of drm
audio component for AMD and Nvidia HDMI codecs.  This is only HD-audio
side, and we need the support in DRM side as well, but it's a step
forward to the better HDMI hotplug handling.  I'm going to submit the
radeon and nouveau patches later once after merging this for 5.4
kernel.

The first patch is somewhat new, a sort of optimization.  The second
patch has been slightly rewritten frm the previous version and the
support for Nvidia was added as well.

Lightly tested on a Dell desktop with Nvidia graphics.


Takashi

===

Takashi Iwai (2):
  ALSA: hda/hdmi - Don't report spurious jack state changes
  ALSA: hda/hdmi - Allow audio component for AMD/ATI and Nvidia HDMI

 sound/pci/hda/patch_hdmi.c | 265 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 229 insertions(+), 36 deletions(-)

-- 
2.16.4
