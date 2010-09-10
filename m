From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix incorrect register cache size
 configuration
Date: Fri, 10 Sep 2010 18:22:21 +0100
Message-ID: <1284139341.3088.340.camel@odin>
References: <1284138896-3789-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 74CF12453A
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 19:22:24 +0200 (CEST)
Received: by wwb22 with SMTP id 22so3006401wwb.20
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2010 10:22:24 -0700 (PDT)
In-Reply-To: <1284138896-3789-1-git-send-email-dp@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-09-10 at 18:14 +0100, Dimitris Papastamos wrote:
> The reg_cache_size is the number of elements in the register cache,
> not the size of the cache itself. This is not a problem if the size
> of each element of the cache is 1 byte but it matters in any other
> case.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Have you checked the other codecs too ?
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
