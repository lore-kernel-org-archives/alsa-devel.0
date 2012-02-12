From: Jean-Yves Avenard <jyavenard@gmail.com>
Subject: 1ca3d59d5a3e762fb1c002bcd912914bc858b430 broke
 passthrough [Was: Re: ALSA 1.0.25 broke AC3 passthrough?]
Date: Sun, 12 Feb 2012 21:25:32 +1100
Message-ID: <CANpj82JKFx1YXgaY3HZyTSyCZs83ZdvEtYGAbNJPdb6q7qN7kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 71C77103AD7
	for <alsa-devel@alsa-project.org>; Sun, 12 Feb 2012 11:25:36 +0100 (CET)
Received: by yhr47 with SMTP id 47so2057702yhr.38
	for <alsa-devel@alsa-project.org>; Sun, 12 Feb 2012 02:25:32 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi again

Allright.. Took me forever doing a bisect in alsa-kmirror while
finding the proper revision in alsa-drivers to be able to compile it.
So painful..
How do you guys ever manage to quickly do bisect ???

Anyhow...

What broke passthrough for me (and others) is this commit:

commit 1ca3d59d5a3e762fb1c002bcd912914bc858b430
Author: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date:   Thu Aug 4 10:12:56 2011 -0500

    ALSA: hda: option to enable arbitrary buffer/period sizes

    Add new parameter to disable rounding of buffer/period sizes to
    multiples of 128 bytes. This is more efficient in terms of memory
    access but isn't required by the HDA spec and prevents users from
    specifying exact period/buffer sizes. For example for 44.1kHz, a
    period size set to 20ms will be rounded to 19.59ms.

    Tested and enabled on Intel HDA controllers. Option is disabled by
    default for other controllers.

    Tested-by: Wu Fengguang <fengguang.wu@intel.com>
    Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    Signed-off-by: Takashi Iwai <tiwai@suse.de>
    Signed-off-by: Jaroslav Kysela <perex@perex.cz>

It's not an obvious breakage however and it only occurs with specific
combinations of hardware buffer size (as seen for me in
/proc/asound/card1/pcm3p/sub0/prealloc) and request of buffer time and
period size.

With the default ALSA hardware buffer size of 64kB, AC3/DTS works.
With 4096, it doesn't and it will make the tested applications hang.

both MythTV and mplayer (and I know of a few others), request by
default a buffer time of 500ms with a period of 4 (requested
respectively through snd_pcm_hw_params_set_buffer_time_near and
snd_pcm_hw_params_set_periods_near)

With those combinations: (4MB hardware buffer, 500ms and period of 4),
trying to write audio with snd_pcm_writei will hang to eventually fail
with the error "Input/output error"

Disabling the functionality introduced in that changeset, fix it for
v1.0.25 (using the following patch:
diff --git a/pci/hda/hda_intel.c b/pci/hda/hda_intel.c
index 9cbde2f..9227389 100644
--- a/pci/hda/hda_intel.c
+++ b/pci/hda/hda_intel.c
@@ -2773,8 +2773,8 @@ static int __devinit azx_create(struct snd_card *card, str
        }

        /* disable buffer size rounding to 128-byte multiples if supported */
-       if (chip->driver_caps & AZX_DCAPS_BUFSIZE)
-               align_buffer_size = 0;
+//     if (chip->driver_caps & AZX_DCAPS_BUFSIZE)
+//             align_buffer_size = 0;

        /* allow 64bit DMA address if supported by H/W */
        if ((gcap & ICH6_GCAP_64OK) && !pci_set_dma_mask(pci, DMA_BIT_MASK(64)))

)

Hope this help
Regards
Jean-Yves Avenard
