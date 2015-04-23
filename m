From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 0/8] Proc file cleanups
Date: Thu, 23 Apr 2015 17:03:47 +0200
Message-ID: <553909D3.5030201@perex.cz>
References: <1429800570-10153-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id CE10F261B14
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 17:03:47 +0200 (CEST)
In-Reply-To: <1429800570-10153-1-git-send-email-tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Dne 23.4.2015 v 16:49 Takashi Iwai napsal(a):
> Hi,
> 
> here is a series of patches for cleaning up the ALSA proc file
> management code.  The biggest change is the use of seq_file for text
> reads, but all are internal and the API is kept intact.
> 
> The rest are mostly small cleanups and refactoring.
> 
> The patches are found in topic/proc branch of sound git tree.

The changes look good.

Acked-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
