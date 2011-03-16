From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ASoC updates for 2.6.39
Date: Wed, 16 Mar 2011 09:44:16 +0000
Message-ID: <1300268656.3432.3.camel@odin>
References: <20110315131842.GA23533@opensource.wolfsonmicro.com>
	<s5hwrk0cp23.wl%tiwai@suse.de>
	<20110315193106.GA5302@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F07A1037F8
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 10:44:23 +0100 (CET)
Received: by fxm6 with SMTP id 6so1376730fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 02:44:22 -0700 (PDT)
In-Reply-To: <20110315193106.GA5302@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-03-15 at 19:31 +0000, Mark Brown wrote:
> On Tue, Mar 15, 2011 at 05:43:16PM +0100, Takashi Iwai wrote:
> 
> > BTW, Mark, Liam, could you guys slowly prepare for whats-new-in-2.6.39
> > notes?
> 
> - Support for registering machine drivers as first class devices rather
>   than using the soc-audio device. Support for the soc-audio device will
>   be removed at some point in the future.
> - Support for ordering widget power changes within widget types, helping
>   with large CODECs and multi-stage amplifiers.
> - Support for waiting for multiple slow events to complete during DAPM
>   sequences, making it easier to handle things like DC offset correction
>   on multiple outputs.
> - CPU support for Intel Medfield and nVidia Tegra2.
> - CODEC support for Cirrus CS4271, Freescale SGTL5000, Maxim MAX8950,
>   National Semiconductors LM4857, TI SN95031 and Wolfson WM8991
> - Machine support for Intel Medfield MID reference platforms, nVidia
>   Harmony, and Visstrim M10.

I would just also add :-

Improvements to RX51 machine support.

Thanks


Liam
