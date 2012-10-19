From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 1/3] ALSA: core: keep track of boundary
 wrap-around
Date: Fri, 19 Oct 2012 16:19:45 -0500
Message-ID: <5081C3F1.2070304@linux.intel.com>
References: <1350061537-10166-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <s5hvcebsz59.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id CBE92262607
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 23:19:55 +0200 (CEST)
In-Reply-To: <s5hvcebsz59.wl%tiwai@suse.de>
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


> The new patchset looks almost good to me (except for a still missing
> compat_timespec conversion in patch 2).  But now I already applied
> UAPI patch to move the stuff from include/sound/asound.h to
> include/uapi/sound/asound.h, so your patch conflicts.
>
> Could you rebase your patches with for-next branch of my sound git
> tree (also with the fix for patch 2)?

no problem, will send an update shortly.
Thanks for the review.
-Pierre
