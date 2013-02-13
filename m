From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] compress: add support for gapless playback
Date: Tue, 12 Feb 2013 22:35:47 -0800
Message-ID: <20130213063547.GD17659@intel.com>
References: <1360693915-22595-1-git-send-email-vinod.koul@intel.com>
 <s5hobfovijf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id F0B7A26160F
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2013 08:00:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hobfovijf.wl%tiwai@suse.de>
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

On Wed, Feb 13, 2013 at 07:23:32AM +0100, Takashi Iwai wrote:
> At Tue, 12 Feb 2013 10:31:55 -0800,
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
> > ---
> >  v3:
> > - Change back to ioctl struct with padding
> 
> But this makes difficult to know which parameter is unavailable in
> this kernel, as already mentioned in the thread.  You need to add
> another ioctl or add a mask in the struct.  Or, take back to single
> key/value pairs, so user can see the -ENOENT or such error for
> non-existing parameters.
Right, but we have the API version. Wouldnt it be okay to use API version to
find what kernel supports, of course it doesnt scale well as many more params
are added.

--
~Vinod
