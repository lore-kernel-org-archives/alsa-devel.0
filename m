From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 0/3] ASoC: Intel: Add Kabylake machine
 driver for RT5663+RT5514+MAX98927
Date: Mon, 12 Jun 2017 10:50:48 +0530
Message-ID: <20170612052047.GE13020@localhost>
References: <1497046734-31753-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C13A5266DCC
 for <alsa-devel@alsa-project.org>; Mon, 12 Jun 2017 07:18:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1497046734-31753-1-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Harsha Priya <harshapriya.n@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 09, 2017 at 03:18:51PM -0700, Harsha Priya wrote:
> This patch set adds a machine driver for Kabylake platform which has RT5663,
> RT5514 and MAX9827 codecs. It also adds the quirk data for the platform driver
> to load the correct machine driver. 
> 
> For this particular machine, 
> 
> *  the RT5663 is a headset codec connected on SSP0
> *  the RT5514 is a dmic codec connected on SSP1
> *  the MAX98987 is a speaker codec connected on SSP1

Looks good to me:

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
