From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: core: Don't schedule
	deferred_resume_work twice
Date: Thu, 26 May 2011 11:56:46 +0100
Message-ID: <4DDE31EE.1030209@ti.com>
References: <1306354001-5629-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 01E6C103823
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 12:56:49 +0200 (CEST)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 25/05/11 21:06, Stephen Warren wrote:
> For cards that have two or more DAIs, snd_soc_resume's loop over all
> DAIs ends up calling schedule_work(deferred_resume_work) once per DAI.
> Since this is the same work item each time, the 2nd and subsequent
> calls return 0 (work item already queued), and trigger the dev_err
> message below stating that a work item may have been lost.
> 
> Solve this by adjusting the loop to simply calculate whether to run the
> resume work immediately or defer it, and then call schedule work (or not)
> one time based on that.
> 
> Note: This has not been tested in mainline, but only in chromeos-2.6.38;
> mainline doesn't support suspend/resume on Tegra, nor does the mainline
> Tegra ASoC driver contain multiple DAIs. It has been compile-checked in
> mainline.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  sound/soc/soc-core.c |   19 ++++++++++---------
>  1 files changed, 10 insertions(+), 9 deletions(-)

This looks fine for 2.6.41. 

Acked-by: Liam girdwood <lrg@ti.com>
