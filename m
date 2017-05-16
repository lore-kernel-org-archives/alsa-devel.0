From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/3] ASoC: Intel: Skylake: Fix IPC rx_list
	corruption
Date: Tue, 16 May 2017 11:41:11 +0530
Message-ID: <20170516061111.GI15061@localhost>
References: <1494857671-19257-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B065267480
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 08:09:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1494857671-19257-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 15, 2017 at 07:44:29PM +0530, Subhransu S. Prusty wrote:
> From: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
> 
> In SKL+ platforms, all IPC commands are serialised, i.e. the driver sends
> a new IPC to DSP, only after receiving a reply from the firmware for the
> current IPC.
> 
> Hence it seems apparent that there is only a single modifier of the IPC RX
> List. However, during an IPC timeout case in a multithreaded environment,
> there is a possibility of the list element being deleted two times if not
> properly protected.
> 
> So, use spin lock save/restore to prevent rx_list corruption.

Looks good, all three:

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
