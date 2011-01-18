From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: core: Remove dapm_sync call from
 soc_post_component_init
Date: Tue, 18 Jan 2011 14:44:47 +0000
Message-ID: <1295361887.3299.39.camel@odin>
References: <1295358705-17871-1-git-send-email-peter.ujfalusi@nokia.com>
	<20110118162219.5cb1b86f.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 470F210382F
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 15:44:52 +0100 (CET)
Received: by wwi18 with SMTP id 18so3290374wwi.2
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 06:44:51 -0800 (PST)
In-Reply-To: <20110118162219.5cb1b86f.jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-01-18 at 16:22 +0200, Jarkko Nikula wrote:
> On Tue, 18 Jan 2011 15:51:45 +0200
> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
> 
> > snd_soc_dapm_new_widgets will call dapm_power_widgets at
> > the end, so there is no need to call snd_soc_dapm_sync
> > after snd_soc_dapm_new_widgets.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > ---
> >  sound/soc/soc-core.c |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> > 
> fwiw,
> 
> Reviewed-by: Jarkko Nikula <jhnikula@gmail.com

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
