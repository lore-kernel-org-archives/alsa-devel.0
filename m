From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCH 0/10] ALSA: Add DSP firmware loader (v3)
Date: Thu, 20 Sep 2012 20:29:11 -0700
Message-ID: <1348198161-9256-1-git-send-email-ian_minett@creativelabs.com>
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

Hi, thanks for the response. I've resubmitted the patch series with updates 
to the ones that needed altering based on the feedback.

The MODULE_FIRMWARE line has been shifted to the firmware loading patch, 
DSP download is now guarded by the config switch and code changes that were 
bundled in with the previous comments patch have moved to a new patch. Also, 
hda_stream_format has been removed.

Regarding the SCP packet endianness, the DSP image requires data to be sent as
little-endian, so we may need to swizzle data being sent to the DSP before the
transfer. Is there a recommended or standard way of detecting and handling the 
case of running on big-endian architectures?

>Does the firmware on chip survive after S3?
The firmware does need to be reloaded when the chip loses power, so it 
doesn't survive S3.

Thanks very much,
- Ian

Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

---
1:
- memalloc.h
- pcm.h
- pcm_memory.c
- sgbuf.c
Include Takashi's patch:
Make snd_sgbuf_get_{ptr|addr}() available for non-SG cases.
Passing struct snd_dma_buffer pointer instead, so that they work no
matter whether real SG buffer is used or not.

2:
- hda_intel.c
- hda_codec.h
Include Takashi's code:
Pass DMA buffer pointers in calls to setup_bdle().
Add DSP loader callback routines to controller.

Add new DSP loader switch to Kconfig to enable DSP firmware loading.

3:
- patch_ca0132.c
- ca0132_regs.h
Add DSP register definitions header file

4 (updated):
- patch_ca0132.c
Add DSP firmware enums and defs to CA0132 codec
MODULE_FIRMWARE not declared in this patch, moved into patch #5

5 (updated):
- patch_ca0132.c
Add calls to new DSP loader system to transfer firmware binary
to the hardware.
Add chip read/write routines, DSP I/O, SCP packet format
helper functions and transfer DMA management.
Add MODULE_FIRMWARE line for DSP firmware binary
Protect DSP download using CONFIG_SND_HDA_DSP_LOADER switch 

6:
- patch_ca0132.c
Add DSP firmware caching to CA0132 codec

7 (updated):
- patch_ca0132.c
Add comments and descriptions to functions.
Previous code changes moved to patch #9

8:
- hda_codec.h
Change return value for load_dsp_prepare to -ENOSYS
in case where DSP loader routines are not available.

9 (new):
- patch_ca0132.c
Merge chipio write address functions and update timeout mechanism
in dsp_write_wait().

10 (new):
- patch_ca0132.c
Remove unnecessary struct hda_stream_format and references to it.
