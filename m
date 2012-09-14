From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCH 0/8] ALSA: Add DSP firmware loader (resub)
Date: Thu, 13 Sep 2012 18:15:50 -0700
Message-ID: <1347585358-2403-1-git-send-email-ian_minett@creativelabs.com>
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

>Thanks for the patches, and sorry for the late response, 
No problem, and sorry for ours too- we've been working on fixing the issues you
raised last time. Hopefully this submission will sort out many of those items.
Macros have been taken out, comments added, and firmware is now cached.

>Keep the git commit author as me.
Ok. I ensured you were set as the git commit author for the first two patchfiles. 
Is there anything else I need to do to properly retain your authorship on those 
commits?

>- Why hda_stream_format is defined?
hda_stream_format is defined to store the stream format information used for 
the DSP download.

Thanks,
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

4:
- patch_ca0132.c
Add DSP firmware enums and defs to CA0132 codec

5:
- patch_ca0132.c
Add calls to new DSP loader system to transfer firmware binary
to the hardware.
Add chip read/write routines, DSP I/O, SCP packet format
helper functions and transfer DMA management.

6:
- patch_ca0132.c
Add DSP firmware caching to CA0132 codec

7:
- patch_ca0132.c
Add comments and descriptions to functions.
Merge chipio write address functions and add fix to dsp_write_wait().

8:
- hda_codec.h
Change return value for load_dsp_prepare to -ENOSYS
in case where DSP loader routines are not available.
