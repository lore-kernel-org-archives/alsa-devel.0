From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] compress: add support for gapless playback
Date: Wed, 13 Feb 2013 22:51:52 +0530
Message-ID: <20130213172152.GB7777@intel.com>
References: <1360771234-13006-1-git-send-email-vinod.koul@intel.com>
 <s5hzjz8upzo.wl%tiwai@suse.de> <20130213170322.GA7777@intel.com>
 <s5hpq04uoca.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 94F6A26524F
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2013 18:23:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hpq04uoca.wl%tiwai@suse.de>
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
Cc: Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 13, 2013 at 06:15:49PM +0100, Takashi Iwai wrote:
> > The stream is created at open. Since it used kzalloc, these variables would be
> > init to false.
> 
> But you can restart the stream after stopping it without closing the
> device, right?
In theory yes. Let me update this in set_params always

--
~Vinod
