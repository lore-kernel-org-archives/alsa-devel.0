From: Julia Lawall <julia@diku.dk>
Subject: question about sound/oss/vidc.c
Date: Tue, 16 Mar 2010 23:02:54 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1003162258230.26076@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw1.diku.dk (mgw1.diku.dk [130.225.96.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 21D53103800
	for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2010 23:03:00 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In sound/oss/vidc.c, the function vidc_audio_trigger contains thefollowing 
code:

        struct audio_operations *adev = audio_devs[dev];

        if (enable_bits & PCM_ENABLE_OUTPUT) {
                if (!(adev->flags & DMA_ACTIVE)) {
                        unsigned long flags;

                        local_irq_save(flags);

                        /* prevent recusion */
                        adev->flags |= DMA_ACTIVE;

			...
		}
	}

I wonder if the use of DMA_ACTIVE is correct?  This constant is defined 
inthe file sound/oss/dev_table.h within the definition of the structure 
dma_buffparms.  But here it is being used with the structure 
audio_operations.  The definition of audio_operations also contains the 
definitions of some constants.  Indeed, one of them, DMA_DUPLEX has the 
same value as DMA_ACTIVE.

thanks,
julia
