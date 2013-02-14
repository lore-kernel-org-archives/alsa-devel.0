From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] compress: add support for gapless playback
Date: Thu, 14 Feb 2013 19:07:27 +0530
Message-ID: <20130214133727.GB29960@intel.com>
References: <1360840971-31409-1-git-send-email-vinod.koul@intel.com>
 <s5h7gmbuo6i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B81A265332
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2013 14:38:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h7gmbuo6i.wl%tiwai@suse.de>
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

On Thu, Feb 14, 2013 at 12:31:33PM +0100, Takashi Iwai wrote:
> At Thu, 14 Feb 2013 16:52:51 +0530,
> Vinod Koul wrote:
> > 
> > From: Jeeja KP <jeeja.kp@intel.com>
> > 
> > this add new API for sound compress to support gapless playback.
> > As noted in Documentation change, we add API to send metadata of encoder and
> > padding delay to DSP. Also add API for indicating EOF and switching to
> > subsequent track
> > 
> > Also bump the compress API version
> > 
> > Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> 
> Thanks, I'm going to apply it to for-next branch.
> Is there any driver requesting this new API for 3.9 kernel?
Thanks, I will send the ASoC and driver update soon. Hopefully they will be
before merge window.

--
~Vinod
