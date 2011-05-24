From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Convert 16x16 write to use
	cpu_to_be16()
Date: Tue, 24 May 2011 10:33:40 +0100
Message-ID: <4DDB7B74.4030302@ti.com>
References: <1306214351-28862-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B448103850
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 11:33:48 +0200 (CEST)
In-Reply-To: <1306214351-28862-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 24/05/11 06:19, Mark Brown wrote:
> Make it clear what we're doing.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-cache.c |   10 ++++------
>  1 files changed, 4 insertions(+), 6 deletions(-)
> 
Acked-by: Liam Girdwood <lrg@ti.com>
