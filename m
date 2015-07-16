From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC PATCH 3/4] ALSA: core: add report of max dma
	burst
Date: Thu, 16 Jul 2015 10:11:28 +0800
Message-ID: <CAN8cciY3nfM+sOmcDAWhUwhE1CDncYyv==nQdPDPum5Vv3fp5w@mail.gmail.com>
References: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1436350236-17509-4-git-send-email-pierre-louis.bossart@linux.intel.com>
 <s5hio9uhg16.wl-tiwai@suse.de> <55A1565C.70004@gmail.com>
 <55A1604F.3070108@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com
 [209.85.218.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CED7260506
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 04:11:30 +0200 (CEST)
Received: by oihq81 with SMTP id q81so41387593oih.2
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 19:11:29 -0700 (PDT)
In-Reply-To: <55A1604F.3070108@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "Alexander E. Patrakov" <patrakov@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

>
>
> >>> +   unsigned int max_dma_burst;     /* R: max in-flight bytes,
indicates buffering before hw_ptr */
>
> I'm not sure if we should name fields like dma in the abstract ioctl
> layer. The words in the comment seems more appropriate or just remove
> dma and keep only max_burst.

Why not using hwptr_granularity if the usage is about the hw_ptr update
interval ?

max_dma_brust is confusing for firewire and usb audio
