From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/5] PCM mmap (temporary) fixes for
	non-coherent architectures
Date: Thu, 26 Nov 2009 16:13:03 +0100
Message-ID: <1259248388-20095-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 42A79103894
	for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2009 16:13:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-mips@linux-mips.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Becky Bruce <beckyb@kernel.crashing.org>, Wu Zhangjin <wuzhangjin@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ralf Baechle <ralf@linux-mips.org>, Kumar Gala <galak@gate.crashing.org>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a patchset to fix Oopses from ALSA PCM core with mmap on MIPS
and PPC non-coherent architectures.  This contains also a clean-up for
ARM mmap.

In this patch series, I don't try to port dma_mmap_coherent() to these
architectures yet, but just put ugly ifdefs in the ALSA core side.
Understand that this is a first step forward to a more cleaner solution,
and the purpose right now is just to fix up long-standing Oops.
I'll try to push dma_mmap_coherent() patches for the next kernel once
again after this gets merged.

Since the changes are minimal, I'd like to put them in ASAP for 2.6.33.
Please review and give feedbacks if any problem is found.


Thanks,

Takashi
