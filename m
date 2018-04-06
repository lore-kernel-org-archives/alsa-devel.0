From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 06/13] soundwire: Add bank switch routine
Date: Fri, 6 Apr 2018 14:03:22 +0530
Message-ID: <20180406083321.GI6014@localhost>
References: <1522946904-2089-1-git-send-email-vinod.koul@intel.com>
 <1522946904-2089-7-git-send-email-vinod.koul@intel.com>
 <b34d6646-3d3e-bc2a-c59b-fcbe23a868aa@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1898C266E30
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 10:29:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <b34d6646-3d3e-bc2a-c59b-fcbe23a868aa@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 05, 2018 at 06:35:26PM -0500, Pierre-Louis Bossart wrote:

> The structure of the code makes little sense here, it could be
> pre-bank-switch();
> bank-switch();
> post-band-switch();
> in the same routine.

Okay let me restruture this part.

> you need to add information that post-bank will need handled in a specific
> manner with multi-link streams.

Yes we already have that but not in the scope of this series

-- 
~Vinod
