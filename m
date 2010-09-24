From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: Convert s3c-ac97 to pr_() macros
Date: Fri, 24 Sep 2010 10:32:17 +0100
Message-ID: <1285320737.13240.0.camel@odin>
References: <1285267270-22426-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 987171037F9
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Sep 2010 11:32:19 +0200 (CEST)
Received: by wya21 with SMTP id 21so102517wya.38
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2010 02:32:19 -0700 (PDT)
In-Reply-To: <1285267270-22426-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-09-23 at 19:41 +0100, Mark Brown wrote:
> Could use dev_() but we'd have to remember the struct device somewhere
> and it wouldn't make the logging clearer.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
