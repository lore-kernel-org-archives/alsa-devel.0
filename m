From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 05/10] ASoC: twl6040: One workqueue should
	be enough
Date: Mon, 26 Sep 2011 15:41:14 +0100
Message-ID: <20110926144114.GM2946@opensource.wolfsonmicro.com>
References: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
	<1317043593-27202-6-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7A45A24507
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 16:41:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317043593-27202-6-git-send-email-peter.ujfalusi@ti.com>
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

On Mon, Sep 26, 2011 at 04:26:28PM +0300, Peter Ujfalusi wrote:
> It is a bit overkill to have three (3) separate
> workqueue for a single driver.
> We can manage things with one workqueue nicely.

Do we even need specific workqueues at all or can we use the system
workqueue?  Looks OK though.
