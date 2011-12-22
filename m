From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Declare soc_new_pcm() properly
Date: Thu, 22 Dec 2011 15:43:27 +0000
Message-ID: <1324568607.4138.6.camel@odin>
References: <1324556226-26386-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog110.obsmtp.com (na3sys009aog110.obsmtp.com
	[74.125.149.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FC6C103E3B
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 16:43:31 +0100 (CET)
Received: by mail-wi0-f171.google.com with SMTP id o1so3084732wic.2
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 07:43:29 -0800 (PST)
In-Reply-To: <1324556226-26386-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Thu, 2011-12-22 at 12:17 +0000, Mark Brown wrote:
> Ensure that everything is seeing the same declaration by moving it to
> a header file rather than putting the declaration in soc-core.c
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  include/sound/soc.h  |    1 +
>  sound/soc/soc-core.c |    2 --
>  2 files changed, 1 insertions(+), 2 deletions(-)

Acked-by: Liam Girdwood <lrg@ti.com>
