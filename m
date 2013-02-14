From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Allocating DMA buffer for non-PCM
Date: Thu, 14 Feb 2013 18:03:53 +0100
Message-ID: <511D18F9.3040906@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [188.40.101.23])
 by alsa0.perex.cz (Postfix) with ESMTP id A7046265334
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2013 18:04:03 +0100 (CET)
Received: from localhost (ltw.loris.tv [127.0.0.1])
 by ltw.loris.tv (Postfix) with ESMTP id D1E366221A
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2013 18:04:02 +0100 (CET)
Received: from ltw.loris.tv ([127.0.0.1])
 by localhost (ltw.loris.tv [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id CfEKp5ZEaVPd for <alsa-devel@alsa-project.org>;
 Thu, 14 Feb 2013 18:04:02 +0100 (CET)
Received: from [IPv6:2001:638:906:2:e269:95ff:fe88:796b]
 (foh.inf-ra.uni-jena.de [IPv6:2001:638:906:2:e269:95ff:fe88:796b])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ltw.loris.tv (Postfix) with ESMTPSA id 10C0E61D50
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2013 18:04:01 +0100 (CET)
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
List-Id: alsa-devel@alsa-project.org

Hi!

Would you say that the following is the proper way to allocate a DMA
buffer used to hold level data?

struct hdspm {
	struct pci_dev *pci;	/* and an pci info */
	struct snd_dma_buffer dmaLevelBuffer;
	u32 *level_buffer;	/* suitably aligned address */
    [..]
}

	/* allocate level buffer */
	err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV_SG,
			snd_dma_pci_data(hdspm->pci),
			MADIFX_LEVEL_BUFFER_SIZE, &hdspm->dmaLevelBuffer);
	if (err < 0) {
    /* error */ [..]
    }

    hdspm->level_buffer = snd_sgbuf_get_ptr(&(hdspm->dmaLevelBuffer), 0);

	memset(hdspm->level_buffer, 0, MADIFX_LEVEL_BUFFER_SIZE);


This used to work on my development machine (kernel 3.6.x), but now a
kernel 3.2.0 user reports a NULL pointer dereference of
hdspm->level_buffer, so apparently, snd_sgbuf_get_ptr() returned NULL
for him.

How could this possibly happen? Am I missing something? Better use
SNDRV_DMA_TYPE_DEV instead?



TIA
