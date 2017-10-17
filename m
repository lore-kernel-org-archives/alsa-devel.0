From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 0/2] ALSA: hda - Fix incorrect TLV callback
	check
Date: Tue, 17 Oct 2017 12:33:59 +0200
Message-ID: <20171017103401.5556-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EAE14266F4E
 for <alsa-devel@alsa-project.org>; Tue, 17 Oct 2017 12:34:06 +0200 (CEST)
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
Cc: PaX Team <pageexec@freemail.hu>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a revised patchset for addressing the incorrect TLV callback
check introduced by a set_fs() removal commit.  A fix for a
superfluous '-' in the code is split as another fix so that it can be
applied to older kernels without the rest.  Other than that, only the
changelog text updates since the older patch (that was embedded in the
mail thread "4.13 regression: get_kctl_0dB_offset doesn't handle all
possible callbacks").


thanks,

Takashi

===

Takashi Iwai (2):
  ALSA: hda: Remove superfluous '-' added by printk conversion
  ALSA: hda - Fix incorrect TLV callback check introduced during
    set_fs() removal

 include/sound/control.h   |  3 ++
 sound/core/vmaster.c      | 31 +++++++++++++++
 sound/pci/hda/hda_codec.c | 97 +++++++++++++++++++++++++++--------------------
 3 files changed, 89 insertions(+), 42 deletions(-)

-- 
2.14.2
