From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Re: [PATCH 3/3] Add ALSA driver for Atmel AC97
	controller
Date: Wed, 04 Feb 2009 15:28:51 +0100
Message-ID: <4989A623.5030501@atmel.com>
References: <1233748114-6353-1-git-send-email-hans-christian.egtvedt@atmel.com>	<1233748114-6353-2-git-send-email-hans-christian.egtvedt@atmel.com>	<1233748114-6353-3-git-send-email-hans-christian.egtvedt@atmel.com>	<1233748114-6353-4-git-send-email-hans-christian.egtvedt@atmel.com>	<20090204120045.GB29849@sirena.org.uk>	<20090204131505.380492af@hcegtvedt>	<49898F64.2000107@atmel.com>	<20090204140308.1f850546@hcegtvedt>	<4989940A.9000706@atmel.com>	<20090204142130.2ac2689d@hcegtvedt>
	<s5hskmu8ggp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id B309524412
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 15:29:05 +0100 (CET)
In-Reply-To: <s5hskmu8ggp.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai a =E9crit :
> At Wed, 4 Feb 2009 14:21:30 +0100,
> Hans-Christian Egtvedt wrote:
>> Should I move the AC97C driver to sound/drivers instead then, and then
>> leave it open for you to implement the extra parts for AT91 devices?
> =

> Well, in general, sound/drivers is for generic drivers that aren't
> specific to certain architecture.  I think it's OK to put it in
> sound/atmel.
> =

> =

> Takashi
> =

So I should make a patch to apply on the top of your patch?
I can do that but it will not be this week because I am quite busy =

currently...

Sedji
