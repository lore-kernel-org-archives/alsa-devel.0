From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] Fix the device references to codec and
 platform drivers
Date: Wed, 05 Jan 2011 09:59:02 +0000
Message-ID: <1294221543.3473.0.camel@odin>
References: <1294207491-17789-1-git-send-email-priya.harsha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B689C10386B
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 10:59:06 +0100 (CET)
Received: by wyi11 with SMTP id 11so14974987wyi.38
	for <alsa-devel@alsa-project.org>; Wed, 05 Jan 2011 01:59:06 -0800 (PST)
In-Reply-To: <1294207491-17789-1-git-send-email-priya.harsha@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-01-05 at 11:34 +0530, Harsha, Priya wrote:
> From: Harsha Priya <priya.harsha@intel.com>
> 
> The soc-core takes the platform and codec driver reference during probe. Few of
> these references are not released during remove. This cause the platform and
> codec driver module unload to fail.
> 
> This patch fixes by the taking only one reference to platform and codec module
> during probe and releases them correctly during remove. This allows load/unload
> properly
> 
> Signed-off-by: Vinod Koul<vinod.koul@intel.com>
> Signed-off-by: Harsha Priya <priya.harsha@intel.com>
> ---
>  sound/soc/soc-core.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
