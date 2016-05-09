From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 1/3] ALSA: hdac: add link pm and ref
	counting
Date: Mon, 9 May 2016 13:54:02 +0530
Message-ID: <20160509082402.GC2274@localhost>
References: <1462428071-30248-1-git-send-email-vinod.koul@intel.com>
 <1462428071-30248-2-git-send-email-vinod.koul@intel.com>
 <20160509044100.GX2274@localhost> <s5hvb2nrax3.wl-tiwai@suse.de>
 <20160509075823.GB2274@localhost> <s5hbn4fd52q.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BB1226067D
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 10:17:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hbn4fd52q.wl-tiwai@suse.de>
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

On Mon, May 09, 2016 at 10:10:53AM +0200, Takashi Iwai wrote:
> 
> You need to check whether there is any link, not the number of links,
> right?  Then it'd be like:

Yes thinking it from other way, I do agree with this.
Will change it

> 
> 	link_up = false;
> 	list_for_each_entry(hlink, &ebus->hlink_list, list) {
> 		if (hlink->ref_count) {
> 			link_up = true;
> 			break;
> 		}
> 	}
> 
> 	if (!link_up) {
> 		cmd_io_off();
> 	}
> 
> 

-- 
~Vinod
