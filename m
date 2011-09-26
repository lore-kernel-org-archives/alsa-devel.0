From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 10/10] ASoC: twl6040: Simplify code in
 out_drv_event for pending work check
Date: Mon, 26 Sep 2011 15:30:19 +0100
Message-ID: <20110926143019.GL2946@opensource.wolfsonmicro.com>
References: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
	<1317043593-27202-11-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CA9E3244F9
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 16:30:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317043593-27202-11-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 26, 2011 at 04:26:33PM +0300, Peter Ujfalusi wrote:
> Check for pending work before the DAPM event switch case, and return,
> if the work is pending.
> This way we can remove the two additional checks in POST_PMU, and
> PRE_PMD for non pending works.

Would it not be easier to just not check at all?  It looks like you're
just deciding if you should schedule the work but schedule_delayed_work
ought to handle rescheduling of an already scheduled work item fine.
