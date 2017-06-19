From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 0/3] ASoC: Intel: Skylake: Add deep
	buffer support
Date: Mon, 19 Jun 2017 13:30:44 +0530
Message-ID: <20170619080043.GH19154@localhost>
References: <1497853761-4778-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 93DAD266DCC
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 09:58:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1497853761-4778-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 19, 2017 at 11:59:18AM +0530, Subhransu S. Prusty wrote:
> Now that we can configure DSP dma buffer size, the device can support deep
> buffer playback. DSP fetches large buffer and can result fewer wakes, which
> helps in power reduction.
> 
> So this series first adds a token in topology to get dma_buffer_size and
> sends to firmware after conversion. Also ads a deepbuffer device to use
> this support.

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
