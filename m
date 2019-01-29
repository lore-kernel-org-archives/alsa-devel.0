From: Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH] ALSA: hda - Fix suspend/resume calls
Date: Tue, 29 Jan 2019 14:42:52 -0800
Message-ID: <20190129224252.GF4517@intel.com>
References: <20190129212510.31897-1-rodrigo.vivi@intel.com>
 <s5hr2cvdufd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 1730D2674B9
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 23:42:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hr2cvdufd.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 29, 2019 at 10:29:26PM +0100, Takashi Iwai wrote:
> On Tue, 29 Jan 2019 22:25:10 +0100,
> Rodrigo Vivi wrote:
> > 
> > Besides the compilation issue the resume function was calling
> > the force_suspend.
> > 
> > Fixes: d81f8c6b6ced ("ALSA: hda - Record the current power state before suspend/resume calls")
> > Cc: Takashi Iwai <tiwai@suse.de>
> > Cc: Jaroslav Kysela <perex@perex.cz>
> > Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> 
> Erm, sorry for the mess, I merged & pushed out the obviously wrong
> branch, and it's been already corrected later on.  You must have
> fetched the tree in a bad timing before I noticed and corrected.

no problem ;)

I noticed your right version when I tried to push this patch to
topic/core-for-CI and it conflicted with your right one ;)

Anyways, thanks for the quick fix.

Thanks,
Rodrigo.

> 
> 
> Takashi
