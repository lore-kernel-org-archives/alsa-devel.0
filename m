From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3] ALSA: core: let low-level driver or
 userspace disable rewinds
Date: Mon, 19 Jun 2017 13:33:47 +0530
Message-ID: <20170619080347.GI19154@localhost>
References: <1497853357-2931-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 291F9266DCC
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 10:01:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1497853357-2931-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, Ramesh Babu <ramesh.babu@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 19, 2017 at 11:52:37AM +0530, Subhransu S. Prusty wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Add new hw_params flag to explicitly tell driver that rewinds will never
> be used. This can be used by low-level driver to optimize DMA operations
> and reduce power consumption. Use this flag only when data written in
> ring buffer will never be invalidated, e.g. any update of appl_ptr is
> final.
> 
> Note that the update of appl_ptr include both a read/write data
> operation as well as snd_pcm_forward() whose behavior is not modified.

Reviewed-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
