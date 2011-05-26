From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Patch series for Fast Track Ultra mixer quirks
Date: Thu, 26 May 2011 09:11:39 +0200
Message-ID: <4DDDFD2B.4060003@showlabor.de>
References: <1306307343-3247-1-git-send-email-zonque@gmail.com>	<s5hoc2r2pnw.wl%tiwai@suse.de>	<BANLkTi=4cTqUFkpHWw1RLGBbySFkpHCD1A@mail.gmail.com>
	<BANLkTimPmOc46+Qthh9QJNt9n+BLu9+hYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203]) by alsa0.perex.cz (Postfix) with ESMTP id 1A75824378
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 09:11:45 +0200 (CEST)
In-Reply-To: <BANLkTimPmOc46+Qthh9QJNt9n+BLu9+hYA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Am 26.05.2011 03:08, schrieb Grant Diffey:
>
> The remaining mixer controls and switches (dsp/reverb sends and setting and
> internal/external clock controls)  now we have a framework for the mixer
> support adding the remaining controls should be straightforward the big
> challenge imho was how to integrate into the quirk code.

I already have most controls working for the DSP section in my private 
tree. The only thing missing is the switch to control which reverb style 
is used. I will send a patch soon.

Internal/external clock setting is a different beast. I've got no idea 
how to implement it. I don't even have a 2nd device to use as an 
external clock so I can't test anything. Chances are this will be 
relatively easy once Daniel gets his hands on a FTU.

--Felix
