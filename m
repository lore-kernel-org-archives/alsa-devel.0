From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: soc-core: Increment codec and
 platform driver refcounts before probing
Date: Wed, 26 Jan 2011 16:28:01 +0200
Message-ID: <20110126162801.b53e4cdf.jhnikula@gmail.com>
References: <1296043097-11720-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A8AE103A1B
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 15:26:42 +0100 (CET)
Received: by fxm5 with SMTP id 5so1015061fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 06:26:42 -0800 (PST)
In-Reply-To: <1296043097-11720-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Harsha Priya <priya.harsha@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 26 Jan 2011 13:58:14 +0200
Jarkko Nikula <jhnikula@gmail.com> wrote:

> Commit f6c2ed5 "ASoC: Fix the device references to codec and platform drivers"
> moved codec and platform driver refcount increments from soc_bind_dai_link
> to more appropriate places.
> 
> Adjust a little them so that refcounts are incremented before executing the
> driver probe functions.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Harsha Priya <priya.harsha@intel.com>
> ---
> I don't know any regression with this so probably 2.6.39 material.
> ---
Actually I found a regression that I like to fix before this. There's a
try_module_get in soc_probe_aux_dev that the commit f6c2ed5 didn't
remove and for auxialiry devices there will be then two try_module_get
calls since another is in soc_probe_codec.


-- 
Jarkko
