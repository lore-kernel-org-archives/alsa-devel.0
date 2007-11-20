From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: [PATCH] Add ASoC WM9713 codec driver.
Date: Tue, 20 Nov 2007 13:02:00 +0100
Message-ID: <1195560120.10785.1222319917@webmail.messagingengine.com>
References: <1195550746-6892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-12-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-13-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-14-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5h7ikdjjee.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 0E533249FC
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 13:02:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h7ikdjjee.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: liam.girdwood@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Marc Mulcahy <marc@levelstar.com>, Graeme Gregory <gg@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Mark Brown wrote:
> > +#define WM9713_PCM_FORMATS \
> > +	(SNDRV_PCM_FORMAT_S16_LE | SNDRV_PCM_FORMAT_S20_3LE | \
> > +	 SNDRV_PCM_FORMAT_S24_LE)
> 
> Is it S24_LE or S24_3LE?  I see S24_LE in other codec drivers, but am
> not pretty sure whether I checked it...

Apparently, these are the formats that an AC'97 controller connected
with this codec can support.

Samples on the AC'97 bus are always MSB-aligned with at most 20 bits.
I don't think it makes much sense to let the codec driver decide what
sample formats the controller should support, because the controller
will have to convert the samples anyway (from/to 16, 24 or 32 bits).
Furthermore, I'm sure there are AC'97 controllers that can handle big-
endian samples on the memory bus.


Regards,
Clemens
