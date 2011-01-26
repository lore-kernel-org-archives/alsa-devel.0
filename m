From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: Convert bunch of codecs to use
 soc-core interconnect registration
Date: Wed, 26 Jan 2011 15:41:40 +0200
Message-ID: <20110126154140.2fe211bc.jhnikula@gmail.com>
References: <1296043097-11720-1-git-send-email-jhnikula@gmail.com>
	<1296043097-11720-4-git-send-email-jhnikula@gmail.com>
	<20110126132813.GB8501@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 89E1B24571
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 14:40:20 +0100 (CET)
Received: by fxm5 with SMTP id 5so970612fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 05:40:20 -0800 (PST)
In-Reply-To: <20110126132813.GB8501@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 26 Jan 2011 13:28:13 +0000
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Wed, Jan 26, 2011 at 01:58:17PM +0200, Jarkko Nikula wrote:
> 
> >  sound/soc/codecs/wm8993.c         |    3 ++-
> 
> Please avoid doing this for wm8993 and anything else which either
> conditionally builds up the DAPM map or does so in multiple stages - I
> don't actually think there's a problem here but I'd ratehr be as
> cautious as possible.

Oops, yeah. I didn't notice there were this wm_hubs_add_analogue_routes
call... I update the patch.

-- 
Jarkko
