From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2/2] ASoC: Make pmdown_time runtime
 configurable
Date: Fri, 12 Feb 2010 14:22:31 +0000
Message-ID: <1265984551.3231.10.camel@odin>
References: <1265974819-25151-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1265974819-25151-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 47CE42452E
	for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2010 15:22:34 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id e12so246395fga.2
	for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2010 06:22:33 -0800 (PST)
In-Reply-To: <1265974819-25151-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-02-12 at 11:40 +0000, Mark Brown wrote:
> Provide a sysfs file allowing userspace to inspect and change the
> pmdown_time setting at runtime.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-core.c |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Btw, I wonder if we should make this configurable via alsa-lib in the
future (probably could be part of a QoS API). It's on my todo list now. 

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
