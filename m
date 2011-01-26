From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2.6.38] ASoC: Fix module refcount for
 auxiliary devices
Date: Wed, 26 Jan 2011 20:11:49 +0000
Message-ID: <1296072709.3298.45.camel@odin>
References: <1296052777-3890-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C6B121037F5
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 21:11:53 +0100 (CET)
Received: by wyi11 with SMTP id 11so1303414wyi.38
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 12:11:53 -0800 (PST)
In-Reply-To: <1296052777-3890-1-git-send-email-jhnikula@gmail.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Brown <broonie@opensource.wolfsonmicro.com>, Harsha Priya <priya.harsha@intel.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-01-26 at 16:39 +0200, Jarkko Nikula wrote:
> Commit f6c2ed5 "ASoC: Fix the device references to codec and platform drivers"
> moved codec driver refcount increments from soc_bind_dai_link into
> soc_probe_codec.
> 
> However, the commit didn't remove try_module_get from soc_probe_aux_dev so
> the auxiliary device reference counts are incremented twice as the
> soc_probe_codec is called from soc_probe_aux_dev too.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Harsha Priya <priya.harsha@intel.com>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
