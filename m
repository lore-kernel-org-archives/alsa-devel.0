From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: core: Remove dapm_sync call from
 soc_post_component_init
Date: Tue, 18 Jan 2011 16:22:19 +0200
Message-ID: <20110118162219.5cb1b86f.jhnikula@gmail.com>
References: <1295358705-17871-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4ED48103902
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 15:22:28 +0100 (CET)
Received: by fxm5 with SMTP id 5so7292847fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 06:22:28 -0800 (PST)
In-Reply-To: <1295358705-17871-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 18 Jan 2011 15:51:45 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> snd_soc_dapm_new_widgets will call dapm_power_widgets at
> the end, so there is no need to call snd_soc_dapm_sync
> after snd_soc_dapm_new_widgets.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
>  sound/soc/soc-core.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
fwiw,

Reviewed-by: Jarkko Nikula <jhnikula@gmail.com
