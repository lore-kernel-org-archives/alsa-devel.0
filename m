From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v9 0/3] HDA: add extended HDA
Date: Thu, 11 Jun 2015 22:15:10 +0530
Message-ID: <20150611164510.GA28601@localhost>
References: <1434012109-20164-1-git-send-email-vinod.koul@intel.com>
 <s5h7fral6w5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id CF46826657D
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 18:44:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h7fral6w5.wl-tiwai@suse.de>
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

On Thu, Jun 11, 2015 at 03:19:22PM +0200, Takashi Iwai wrote:
> I took all three patches (with a fix I mentioned in the early post) to
> for-next branch now.
Thank You Takashi,

While generating the patch series, I did the removal of
snd_hdac_ext_bus_map_codec_to_link last and missed removing the function
declartion. Sorry about that. I have sent you a patch for this, please apply
that or fold it, either way is fine

Thanks
-- 
~Vinod
