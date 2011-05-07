From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: soc-cache: Allow codec->cache_bypass
 to be used with snd_soc_hw_bulk_write_raw()
Date: Sat, 07 May 2011 18:43:32 +0100
Message-ID: <1304790212.3470.11.camel@odin>
References: <1304601491-22751-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 273FC1037EC
	for <alsa-devel@alsa-project.org>;
	Sat,  7 May 2011 19:43:39 +0200 (CEST)
Received: by wwf26 with SMTP id 26so3466384wwf.20
	for <alsa-devel@alsa-project.org>; Sat, 07 May 2011 10:43:38 -0700 (PDT)
In-Reply-To: <1304601491-22751-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@ti.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-05-05 at 14:18 +0100, Dimitris Papastamos wrote:
> If we specifically want to write a block of data to the hw bypassing the
> cache, then allow this to happen inside snd_soc_hw_bulk_write_raw().
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-cache.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@ti.com>
