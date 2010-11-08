From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [PATCH 2/2] add API to allow disabling period
	interrupt
Date: Mon, 8 Nov 2010 14:58:59 -0600
Message-ID: <AANLkTik0XRtw78aekfBw2q8HU2kUFGQ35A=NFL=4O+uM@mail.gmail.com>
References: <1288649614-31581-1-git-send-email-pierre-louis.bossart@intel.com>
	<1288649614-31581-2-git-send-email-pierre-louis.bossart@intel.com>
	<4CCFCA6A.8010803@ladisch.de>
	<alpine.LNX.2.00.1011020935550.29422@eeebox2.perex-int.cz>
	<4CCFD40F.1010407@ladisch.de>
	<alpine.LNX.2.00.1011021018591.29422@eeebox2.perex-int.cz>
	<AANLkTi=31_11GndkDYdGXiuM-LJ4cTbMNRMa0FaCZfCa@mail.gmail.com>
	<alpine.LNX.2.00.1011030825250.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E022243E4
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2010 21:58:59 +0100 (CET)
Received: by iwn2 with SMTP id 2so6900902iwn.38
	for <alsa-devel@alsa-project.org>; Mon, 08 Nov 2010 12:58:59 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1011030825250.29422@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

> I see two ways:
>
> 1) leave set/get functions with this semantics:
> =A0 - application tries to set the no period update behaviour for hw_para=
ms
> =A0 =A0 - alsa-lib should check if nonblock flag is set at this moment
> =A0 - snd_pcm_hw_params() call
> =A0 - application reads back the no period update state and if the flag is
> =A0 =A0 not set, it will use standard period updates
> 2) create new optional snd_pcm_open flag
> =A0 - application opens device with nonblock and no period update flags
> =A0 - snd_pcm_hw_params() call
> =A0 - application reads back the no period update state and if the flag is
> =A0 =A0 not set, it will use standard period updates
>
> Note that we can even implement both methods together like for handling t=
he
> nonblock behaviour.

I re-implemented the first solution and checked if the mode is indeed
non-blocking. This solution assumes that the apps cannot go back to
blocking mode at a later stage. Is it a valid asumption, or can the
blocking mode be enabled/disabled at any time with snd_pcm_nonblock()?
-Pierre
