From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 0/4] ASoC: twl6040: Gain ramp code
	cleanups
Date: Fri, 30 Sep 2011 13:55:22 +0100
Message-ID: <20110930125522.GJ5366@opensource.wolfsonmicro.com>
References: <1317298957-30366-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A5C1D103B69
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Sep 2011 14:55:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317298957-30366-1-git-send-email-peter.ujfalusi@ti.com>
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

On Thu, Sep 29, 2011 at 03:22:33PM +0300, Peter Ujfalusi wrote:

> Changes since v2:
> - Use cancel_delayed_work_sync to make sure that we do not have pending work,
>   or executing work when modifying the variables used by the ramp code.

Applied all, thanks.
