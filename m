From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add ASoC WM9713 codec driver.
Date: Wed, 21 Nov 2007 16:16:00 +0000
Message-ID: <20071121161600.GB18228@sirena.org.uk>
References: <1195550746-6892-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-12-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-13-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-14-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5h7ikdjjee.wl%tiwai@suse.de>
	<1195560120.10785.1222319917@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F75D24C5A
	for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2007 17:16:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1195560120.10785.1222319917@webmail.messagingengine.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, liam.girdwood@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Marc Mulcahy <marc@levelstar.com>, Graeme Gregory <gg@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 20, 2007 at 01:02:00PM +0100, Clemens Ladisch wrote:
> Takashi Iwai wrote:

> > Is it S24_LE or S24_3LE?  I see S24_LE in other codec drivers, but am
> > not pretty sure whether I checked it...

I think it's correct but I'll double check before resubmitting.

> Apparently, these are the formats that an AC'97 controller connected
> with this codec can support.

This define is not used for the AC'97 interface of the chip - it is only
used for the PCM interface which the chip supports in addition to its
AC'97 interface.
