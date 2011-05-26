From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Don't schedule
	deferred_resume_work twice
Date: Thu, 26 May 2011 22:08:25 +0800
Message-ID: <20110526140824.GD15094@opensource.wolfsonmicro.com>
References: <1306354001-5629-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3C40B103888
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 16:08:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1306354001-5629-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, May 25, 2011 at 02:06:41PM -0600, Stephen Warren wrote:
> For cards that have two or more DAIs, snd_soc_resume's loop over all
> DAIs ends up calling schedule_work(deferred_resume_work) once per DAI.
> Since this is the same work item each time, the 2nd and subsequent
> calls return 0 (work item already queued), and trigger the dev_err
> message below stating that a work item may have been lost.

Applied, thanks.
