From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Effect of CONFIG_SND_PCM_OSS_PLUGINS
Date: Wed, 25 Jul 2007 08:36:38 +0200
Message-ID: <1185345398.10658.1201916763@webmail.messagingengine.com>
References: <92a12cdb0707241530h3703a721md7bceeac2cd3144a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id F28072435F
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jul 2007 08:36:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <92a12cdb0707241530h3703a721md7bceeac2cd3144a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian McMenamin <adrianmcmenamin@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adrian McMenamin wrote:
> Unless CONFIG_SND_PCM_OSS_PLUGINS is set then with my driver the
> userspace (and OSS) app mpg123 doesn't work properly - not outputting
> any sound.

This symbol enables (limited) automatic sample rate/format conversion.

Apparently, your sound device does not support any of mpg123's supported
sample formats.

> Is this likely to be a problem with my driver or with the app?

I would say that the problem is the missing CONFIG_SND_PCM_OSS_PLUGINS.
;-)

Well, your driver does support S16_LE, doesn't it?


Regards,
Clemens
