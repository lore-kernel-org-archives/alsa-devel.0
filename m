From: "Adrian McMenamin" <adrianmcmenamin@gmail.com>
Subject: Re: Effect of CONFIG_SND_PCM_OSS_PLUGINS
Date: Thu, 26 Jul 2007 22:00:06 +0100
Message-ID: <92a12cdb0707261400u624be88av154447e7ea5be081@mail.gmail.com>
References: <92a12cdb0707241530h3703a721md7bceeac2cd3144a@mail.gmail.com>
	<1185345398.10658.1201916763@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FFE210381F
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Jul 2007 23:00:07 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so788195wag
	for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2007 14:00:06 -0700 (PDT)
In-Reply-To: <1185345398.10658.1201916763@webmail.messagingengine.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 25/07/07, Clemens Ladisch <cladisch@fastmail.net> wrote:
> Adrian McMenamin wrote:
> > Unless CONFIG_SND_PCM_OSS_PLUGINS is set then with my driver the
> > userspace (and OSS) app mpg123 doesn't work properly - not outputting
> > any sound.
>
> This symbol enables (limited) automatic sample rate/format conversion.
>
> Apparently, your sound device does not support any of mpg123's supported
> sample formats.
>
> > Is this likely to be a problem with my driver or with the app?
>
> I would say that the problem is the missing CONFIG_SND_PCM_OSS_PLUGINS.
> ;-)
>
> Well, your driver does support S16_LE, doesn't it?
>
>
I think so

.formats =
	    (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |
	     SNDRV_PCM_FMTBIT_IMA_ADPCM),
