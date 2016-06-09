From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ALSA: hda - fix whitespaces
Date: Thu, 9 Jun 2016 15:20:24 +0530
Message-ID: <20160609095024.GU16910@localhost>
References: <1465453364-24323-1-git-send-email-vinod.koul@intel.com>
 <s5hh9d2c1lf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id CDAC32608EC
 for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2016 11:43:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hh9d2c1lf.wl-tiwai@suse.de>
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
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 09, 2016 at 08:34:20AM +0200, Takashi Iwai wrote:
> On Thu, 09 Jun 2016 08:22:44 +0200,
> Vinod Koul wrote:
> > 
> > Some trailing whitespaces seems to have crept in the hda_intel.c,
> > so fix them up
> > 
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> 
> Well, this kind of "fix" doesn't improve readability but often makes
> stable backporting harder.  So I'd like to skip it.
> 
> This, of course, depends on the state of the code: for the code that
> is being actively rewritten, it's good to have such fixes.  OTOH, for
> the longly maintained code, it's not clear whether to apply or not.

Okay I dont mind. I noticed these spaces while doing the Kabylake patch, so
thought to send :)

-- 
~Vinod
