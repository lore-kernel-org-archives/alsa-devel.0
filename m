From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/6] ALSA: hda: use list macro for parsing
	on cleanup
Date: Tue, 15 Mar 2016 16:24:15 +0530
Message-ID: <20160315105415.GI13211@localhost>
References: <1458035836-1843-1-git-send-email-vinod.koul@intel.com>
 <1458035836-1843-2-git-send-email-vinod.koul@intel.com>
 <s5h7fh4giwa.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D373B2657D2
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 11:49:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h7fh4giwa.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 15, 2016 at 11:00:53AM +0100, Takashi Iwai wrote:
> On Tue, 15 Mar 2016 10:57:11 +0100,
> Vinod Koul wrote:
> > 
> > It is always better to use list_for_each_entry_safe() while doing
> > cleanup. So use this instead of open coding this in list in
> > snd_hdac_stream_free_all()
> > 
> > Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> 
> While this change is fine, we shouldn't trust blindly
> list_for_each_safe() as always safe.  It assumes that the list removal
> is done only for the current item.  But it's not always true.  The
> loop in the current code is one of standard idiom in such a case.

Yes thanks for the warning :)


> 
> In anyway, take my ack when Mark applies it:
>   Acked-by: Takashi Iwai <tiwai@suse.de>

Will add this for v2

>-- 
~Vinod
