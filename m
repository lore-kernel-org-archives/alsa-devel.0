From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Move WM2000 to dev_pm_ops
Date: Fri, 25 Feb 2011 12:55:49 +0000
Message-ID: <1298638549.3363.75.camel@odin>
References: <1298636752-11198-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A4B310396B
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 13:55:53 +0100 (CET)
Received: by wyb28 with SMTP id 28so1517889wyb.38
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 04:55:53 -0800 (PST)
In-Reply-To: <1298636752-11198-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Fri, 2011-02-25 at 12:25 +0000, Mark Brown wrote:
> There's a general move to use dev_pm_ops rather than bus specific functions
> in order to facilitate work on the PM core. Do this conversion to WM2000.
> The driver ought to be updated to work better in a multi-component model
> but the mechanical conversion ensures that we avoid blocking PM core work
> until that happens.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm2000.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
