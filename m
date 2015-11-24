From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/7] ASoC: Intel: Skylake: Add Resume
 capability in PCM info.
Date: Tue, 24 Nov 2015 08:14:49 +0530
Message-ID: <20151124024449.GV25173@localhost>
References: <1448297789-6524-1-git-send-email-vinod.koul@intel.com>
 <1448297789-6524-2-git-send-email-vinod.koul@intel.com>
 <s5hsi3wblmn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BD3B265850
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 03:40:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hsi3wblmn.wl-tiwai@suse.de>
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

On Mon, Nov 23, 2015 at 07:45:20PM +0100, Takashi Iwai wrote:
> On Mon, 23 Nov 2015 17:56:23 +0100,
> Vinod Koul wrote:
> > 
> > From: Jeeja KP <jeeja.kp@intel.com>
> > 
> > This patch adds pcm capability to support Resume.
> 
> The flag indicates that the driver is capable of the full resume --
> i.e. it must resume everything at the exactly same point to be
> suspended.  Is it really the case?
> 
> If it's not and it's instead a kind of restart of streams, don't add
> this flag.  The lack of the flag doesn't mean that the driver can't
> resume at all.

Yes, with this patch series we are able to resume from previous position.

Here is my test:

# aplay -Dhw:0,0 play.wav
Playing WAVE 'play.wav' : Signed 16 bit Little Endian, Rate 48000 Hz,
Stereo
Suspended. Trying resume. Done.

Thanks
-- 
~Vinod
