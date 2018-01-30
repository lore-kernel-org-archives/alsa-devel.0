From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/3] Add SPIB Support for Intel Skylake
 platforms
Date: Tue, 30 Jan 2018 17:14:32 +0530
Message-ID: <20180130114432.GV18649@localhost>
References: <1517304986-16847-1-git-send-email-sriramx.periyasamy@intel.com>
 <013428a5-b593-1a7d-5a62-4e838a9fe5d0@sakamocchi.jp>
 <20180130110743.GA26938@subhransu-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id DDA002671F2
 for <alsa-devel@alsa-project.org>; Tue, 30 Jan 2018 12:40:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180130110743.GA26938@subhransu-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: ALSA ML <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "Periyasamy, SriramX" <sriramx.periyasamy@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 30, 2018 at 04:37:44PM +0530, Subhransu S. Prusty wrote:
> On Tue, Jan 30, 2018 at 04:08:39PM +0530, Takashi Sakamoto wrote:
> > Hi,

Hi Takashi Sakamoto,

> > In my opinion, when drivers
> > return appropriate values at implementations of
> > "struct snd_pcm_ops.pointer" and "struct snd_pcm_ops.ack", your aim is
> > satisfied. In short, you can let ALSA PCM core to handle
> > rewinding/forwarding requests from userland for zero number of handled
> > frames in result. So the 'SNDRV_PCM_HW_PARAMS_NO_REWINDS' flag is
> > useless.
> 
> Based on the earlier discussion in v3, this series includes the usage of the
> 'SNDRV_PCM_HW_PARAMS_NO_REWINDS' flag. Please refer to the discussion on
> https://patchwork.kernel.org/patch/9795233/

Also it is worth mentioning that this supports a HW feature which requires
the knowledge of data available in ring buffer to be provided to hardware.
With the feature enabled, we cannot rewind/forward, hence the support is
dependent upon application querying about no rewind capability and setting
it, otherwise this feature is not enabled...

> 
> > 
> > From me, please refer to our previous discussion about this
> > flag[1][2][3], then describe your insistence of this flag. At least,
> > it's not better idea to abandon the old discussion when posting this
> > kind of patches. Additionally you should add 'v4' in title of this
> 
> Yes should have added the reference and v4. Sorry to have missed it.

-- 
~Vinod
