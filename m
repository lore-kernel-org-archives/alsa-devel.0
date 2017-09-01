From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: Add IPC to configure
 the copier secondary pins
Date: Fri, 1 Sep 2017 16:34:12 +0530
Message-ID: <20170901110411.GB3053@localhost>
References: <1504253173-16647-1-git-send-email-pradeep.d.tewani@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C1B52266B70
 for <alsa-devel@alsa-project.org>; Fri,  1 Sep 2017 13:00:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1504253173-16647-1-git-send-email-pradeep.d.tewani@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pradeep Tewani <pradeep.d.tewani@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 01, 2017 at 01:36:13PM +0530, Pradeep Tewani wrote:
> Copier can support upto 4 output pins. However, only pin 0 is configured
> as a part of copier initialization. Configuring rest of pins require the
> separate IPC to be sent to fw.

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
