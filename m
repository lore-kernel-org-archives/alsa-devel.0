From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/3] ASoC: sn95031: Fix control-less DAPM
	routes
Date: Tue, 3 Mar 2015 21:55:12 +0530
Message-ID: <20150303162512.GK2613@intel.com>
References: <1425042784-727-1-git-send-email-lars@metafoo.de>
 <1425042784-727-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 759422616B9
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2015 17:29:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1425042784-727-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 27, 2015 at 02:13:04PM +0100, Lars-Peter Clausen wrote:
> Routes without a control must use NULL for the control name. The sn95031
> driver uses "NULL" instead in a few places. Previous to commit 5fe5b767dc6f
> ("ASoC: dapm: Do not pretend to support controls for non mixer/mux widgets")
> the DAPM core silently ignored non-NULL controls on non-mixer and non-mux
> routes. But starting with that commit it will complain and not add the
> route breaking the sn95031 driver in the process.
> 
> This patch replaces the incorrect "NULL" control name with NULL to fix the
> issue.
Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
