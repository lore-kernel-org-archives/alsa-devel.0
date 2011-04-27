From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Add dapm_find_widget helper
Date: Wed, 27 Apr 2011 19:42:46 +0100
Message-ID: <1303929766.3429.19.camel@odin>
References: <1303922071-23466-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CA7C510390D
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 20:42:50 +0200 (CEST)
Received: by wwf26 with SMTP id 26so1715385wwf.20
	for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2011 11:42:50 -0700 (PDT)
In-Reply-To: <1303922071-23466-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-04-27 at 18:34 +0200, Lars-Peter Clausen wrote:
> This patch adds a helper function for searching DAPM widgets by name.
> This allows to streamline functions which operate on widgets by name.
> It also allows to get rid of copy'n'pasted code which was added to fallback to
> widgets from other contexts if the widget was not found in the current context.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  sound/soc/soc-dapm.c |  115 +++++++++++++++++++------------------------------
>  1 files changed, 45 insertions(+), 70 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@ti.com>
