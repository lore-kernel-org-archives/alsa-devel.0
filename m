From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 00/14] Refactoring ALSA core device
	management
Date: Mon, 02 Feb 2015 12:01:57 +0100
Message-ID: <54CF5925.7090407@perex.cz>
References: <1422872678-4815-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 5283D2604DB
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 12:01:58 +0100 (CET)
In-Reply-To: <1422872678-4815-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 2.2.2015 v 11:24 Takashi Iwai napsal(a):
> Hi,
> 
> this is a series of relatively small patches for refactoring the ALSA
> core device management.  I experimented a similar thing some time ago
> but didn't merge it in the end due to too intrusive changes.  At this
> time, the approach is rather minimalistic: only the device
> registration part is replaced by embedding the struct device into
> each ALSA device object.

Looks good. Thanks. For all patches:

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
