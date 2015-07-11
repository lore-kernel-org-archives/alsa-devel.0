From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC PATCH 3/4] ALSA: core: add report of max dma
 burst
Date: Sat, 11 Jul 2015 20:28:31 +0200
Message-ID: <55A1604F.3070108@perex.cz>
References: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1436350236-17509-4-git-send-email-pierre-louis.bossart@linux.intel.com>
 <s5hio9uhg16.wl-tiwai@suse.de> <55A1565C.70004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id ADD462605C2
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 20:28:32 +0200 (CEST)
In-Reply-To: <55A1565C.70004@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>>> +	unsigned int max_dma_burst;     /* R: max in-flight bytes, indicates buffering before hw_ptr */

I'm not sure if we should name fields like dma in the abstract ioctl
layer. The words in the comment seems more appropriate or just remove
dma and keep only max_burst.

				Thanks,
					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
