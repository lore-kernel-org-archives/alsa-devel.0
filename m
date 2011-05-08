From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 01/12] ASoC: Create codec DAPM widgets
 before calling the codecs probe function
Date: Sun, 08 May 2011 12:16:01 +0100
Message-ID: <1304853361.3246.3.camel@odin>
References: <1304607560-15083-1-git-send-email-lars@metafoo.de>
	<1304791860.3470.15.camel@odin>
	<20110507182115.GB26700@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id D44122437E
	for <alsa-devel@alsa-project.org>;
	Sun,  8 May 2011 13:16:04 +0200 (CEST)
Received: by wyg36 with SMTP id 36so3728741wyg.38
	for <alsa-devel@alsa-project.org>; Sun, 08 May 2011 04:16:04 -0700 (PDT)
In-Reply-To: <20110507182115.GB26700@opensource.wolfsonmicro.com>
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
Cc: device-driver-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 2011-05-07 at 19:21 +0100, Mark Brown wrote:
> On Sat, May 07, 2011 at 07:11:00PM +0100, Liam Girdwood wrote:
> 
> > These look all OK but I'm not fully following your commit message above
> > with moving the call to snd_soc_dapm_new_controls() below. Could you
> > explain why moving the call fixes your issue.
> 
> It means the widgets are present before the codec initialisation
> callbacks get run so the callbacks can use them if they wish to.

Ok, cool. This is a better commit message.

All.

Acked-by: Liam Girdwood <lrg@ti.com>
