From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Make LZO cache compression optional
Date: Tue, 21 Dec 2010 20:54:32 +0000
Message-ID: <1292964872.3296.66.camel@odin>
References: <1292952017-8232-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id B8A98103A17
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 21:54:36 +0100 (CET)
Received: by wwi18 with SMTP id 18so4405489wwi.2
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 12:54:36 -0800 (PST)
In-Reply-To: <1292952017-8232-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-12-21 at 17:20 +0000, Mark Brown wrote:
> Make LZO cache compression optional as it pulls in the kernel wide LZO
> implementation and rbtree compression is generally more efficient for
> typical register maps, especially in terms of CPU performance.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/Kconfig     |   17 +++++++++++++++--
>  sound/soc/soc-cache.c |    4 ++++
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
