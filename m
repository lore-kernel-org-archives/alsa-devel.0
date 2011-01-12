From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: soc-cache: Ensure flat compression
 uses a copy of the defaults cache
Date: Wed, 12 Jan 2011 11:14:15 +0000
Message-ID: <1294830855.3303.88.camel@odin>
References: <1294827748-27755-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B60024508
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 12:14:19 +0100 (CET)
Received: by wwe15 with SMTP id 15so458377wwe.20
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 03:14:19 -0800 (PST)
In-Reply-To: <1294827748-27755-1-git-send-email-dp@opensource.wolfsonmicro.com>
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
Cc: Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Takashi@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-01-12 at 10:22 +0000, Dimitris Papastamos wrote:
> With the addition of the cache fallback functionality, it is necessary
> to ensure that if the register defaults cache was marked as __devinitconst
> and the LZO compression is not compiled in the kernel, the fallback to
> flat compression will still use a copy of the defaults cache.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
