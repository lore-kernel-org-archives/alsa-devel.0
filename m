From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/5] Enabling ASoC paths over suspend
Date: Mon, 10 May 2010 09:19:18 +0300
Message-ID: <201005100919.18509.peter.ujfalusi@nokia.com>
References: <20100509120741.GA16918@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 654FF246EA
	for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 08:19:33 +0200 (CEST)
In-Reply-To: <20100509120741.GA16918@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>, Laim Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sunday 09 May 2010 15:07:41 ext Mark Brown wrote:
> The following patch series implements support for keeping some paths in
> the audio codec enabled while the system is suspended.  This is
> primarily intended for mobile phones, where the GSM modem is normally
> capable of supporting a voice call with no intervention from the CPU so
> power can be saved by suspending the Linux system.  This is done by
> allowing DAPM nodes to be marked as ignoring suspend.  Any audio paths
> between two widgets set up like this at suspend time will be kept active
> and the CODEC device will not be suspended.
> 
> The existing testing is very light (especially for digital paths), the
> intention is to do more of that get this merged into Takashi's tree
> early next week.
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git
> suspend-enable
> 
> Mark Brown (5):
>       ASoC: Remove unneeded suspend bias managment from CODEC drivers
>       ASoC: Remove unused DAPM suspend flag
>       ASoC: Refactor DAPM suspend handling
>       ASoC: Support leaving paths enabled over system suspend
>       ASoC: Allow active paths from the GSM modem while the GTA02 is
> suspended

I have not tested the actual purpose of this series, but at least it is not 
breaking the twl4030, and tlv320dac33 codec driver normal usage.

Tested-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
