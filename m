From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC] compress: add support for gapless playback
Date: Wed, 6 Feb 2013 06:09:32 -0800
Message-ID: <20130206140932.GJ3143@intel.com>
References: <1360074085-562-1-git-send-email-vinod.koul@intel.com>
 <s5hk3ql8rd5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 159F326523D
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2013 15:34:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hk3ql8rd5.wl%tiwai@suse.de>
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

On Wed, Feb 06, 2013 at 03:11:02PM +0100, Takashi Iwai wrote:
> At Tue,  5 Feb 2013 06:21:25 -0800,
> Vinod Koul wrote:
> > 
> > From: Jeeja KP <jeeja.kp@intel.com>
> > 
> > this add new API for sound compress to support gapless playback.
> > As noted in Documentation change, we add API to send metadata of encoder and
> > padding delay to DSP. Also add API for indicating EOF and switching to
> > subsequent track
> 
> I can understand that the metadata is somehow handled in DSP for
> seamless switching, 
yes for stripping the encoder delay and encoder padding.
> but the operation with partial drain is a bit
> unclear.
> How is the operation flow?  Does it drain until which point?
Right, we want to move from one track to another. And while at this DSP needs to
exhaust the buffers from first track and then we should start writing second
track. When userspace has finsihed wirting first track it sends partial_drain
and DSP decods finsihed off and returns when it is ready to accept second track
data. The userland sends the metadata for this followed by data write.

> In your patch, the runtime state is changed to SETUP after the partial
> drain, so the app is requested to give START again?
Ah, thats a mistake, it should be in running state, no START again :)

--
~Vinod
