From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: core: Split the union for
 CODEC/platform in the DAI
Date: Fri, 02 Mar 2012 17:14:32 +0000
Message-ID: <1330708472.13653.0.camel@odin>
References: <1330705151-8316-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog121.obsmtp.com (na3sys009aog121.obsmtp.com
	[74.125.149.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 6CB30245B1
	for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2012 18:14:51 +0100 (CET)
Received: by wgbdt12 with SMTP id dt12so49213wgb.26
	for <alsa-devel@alsa-project.org>; Fri, 02 Mar 2012 09:14:34 -0800 (PST)
In-Reply-To: <1330705151-8316-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-03-02 at 16:19 +0000, Mark Brown wrote:
> There's now core code which falls back to global CODEC operations for
> DAI calls that needs to be able to tell if it's dealing with a CPU or
> CODEC DAI and given the small number of DAIs in a typical system and
> overall memory usage pattern saving a pointer per DAI is really not
> worth the effort.
> 
> Reported-by: Ian Lartey <ian@opensource.wolfsonmicro.com>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Acked-by: Liam Girdwood <lrg@ti.com>
