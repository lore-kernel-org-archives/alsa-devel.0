From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [RFC PATCH] ALSA: hda - add support for
	runtime	power management
Date: Mon, 20 Aug 2012 09:35:58 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F818DAA3@SHSMSX101.ccr.corp.intel.com>
References: <1345195814-2287-1-git-send-email-mengdong.lin@intel.com>
 <s5hsjblvo9s.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F818B4E4@SHSMSX101.ccr.corp.intel.com>
 <s5hd32psbqb.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F818C27C@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B05E265DB0
 for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2012 11:06:15 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F818C27C@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> > - The IRQ reassignment is required for runtime PM?
> 
> I'm not sure if the IRQ reassignment can be removed and I'll double check
> this.

The IRQ reassignment is removed. And the HD-A interrupt handler will ignore IRQ when runtime suspended or during suspending or resuming.
The patch is updated with title [PATCH v2] ALSA: hda - add runtime PM support. Please review.

Thanks
Mengdong
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
