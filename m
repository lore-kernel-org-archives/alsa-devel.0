From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCH 0/3] ALSA: Add DSP firmware loader
Date: Thu, 30 Aug 2012 13:21:03 -0700
Message-ID: <1346358066-7851-1-git-send-email-ian_minett@creativelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Ian Minett <ian_minett@creativelabs.com>
List-Id: alsa-devel@alsa-project.org

From: Ian Minett <ian_minett@creativelabs.com>

Hi Takashi,
Thanks for the recent code samples, they were very useful. We've built on them
to produce this latest patchset, incorporating the updates you provided to add the loader functions, and doing a minimal update to the CA0132 codec to use the new ops
to perform the firmware transfer.
Please let us know if any tweaks are needed to the update.

Thanks,
- Ian

Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

---
1:
- memalloc.h
- pcm.h
- pcm_memory.c
- sgbuf.c
Include Takashi's updates:
Make snd_sgbuf_get_{ptr|addr}() available for non-SG cases.
Passing struct snd_dma_buffer pointer instead, so that they work no
matter whether real SG buffer is used or not.

2:
- hda_intel.c
- hda_codec.h
Include Takashi's updates:
Pass DMA buffer pointers in calls to setup_bdle().
Add new callback routines to controller to handle loading
firmware binaries.
Add new switch to Kconfig to enable DSP firmware loader.

3:
- patch_ca0132.c
- ca0132_regs.h
Add support for DSP firmware transfer to CA0132 codec:
Add transfer handler functions.
Call the new snd_hda_codec_load_dsp_xxx loader ops to control download.
Add chip access routines.
