From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/4] ALSA: hdac: add codec driver support
Date: Fri, 21 Aug 2015 16:20:11 +0530
Message-ID: <20150821105011.GS13546@localhost>
References: <1440152263-24156-1-git-send-email-vinod.koul@intel.com>
 <s5hoai13p23.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 73BF92604D8
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2015 12:48:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hoai13p23.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 21, 2015 at 12:37:24PM +0200, Takashi Iwai wrote:
> On Fri, 21 Aug 2015 12:17:39 +0200,
> Vinod Koul wrote:
> > 
> > This patch adds the core framework support for adding hdac extended devices
> > and drivers. We introduce a minimal hdac extended device and driver and APIs
> > for registration
> > This series also ads extended device cleanup API and refresh sysfs tree API
> > 
> > Vinod Koul (4):
> >   ALSA: hdac: Add API for removing hdac extended device
> >   ALSA: hdac: add hdac extended device
> >   ALSA: hdac: add extended device driver registration
> >   ALSA: hdac: add snd_hdac_refresh_widget_sysfs()
> 
> I applied them now, but the last patch had trivial coding style
> problems.  Please do run checkpatch.pl once before submission at the
> next time.

Thanks a bunch, I usually do run it but missed it this time. my bad :(

-- 
~Vinod
