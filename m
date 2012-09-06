From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Revert 'ASoC: imx-ssi: Remove mono
	support'
Date: Thu, 6 Sep 2012 08:44:28 +0800
Message-ID: <20120906004427.GW10580@opensource.wolfsonmicro.com>
References: <1346891410-4379-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D584F265072
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 02:44:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1346891410-4379-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, Javier Martin <javier.martin@vista-silicon.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 05, 2012 at 09:30:10PM -0300, Fabio Estevam wrote:
> From: Javier Martin <javier.martin@vista-silicon.com>
> 
> Revert 0865a75(ASoC: imx-ssi: Remove mono support).
> 
> The bug this patch is meant to solve doesn't occur in Visstrim_M10 boards.
> Furthermore, after applying this patch sound in Visstrim_M10 is played
> at slower rates.

Applied, thanks.
