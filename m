From: Timur Tabi <timur@freescale.com>
Subject: Re: ASoC and a codec that can't be controlled
Date: Tue, 29 May 2007 14:02:14 -0500
Message-ID: <465C78B6.3000001@freescale.com>
References: <46531097.5040600@freescale.com>	
	<1179934677.12071.30.camel@a10072.wolfsonmicro.main>	
	<46574453.10808@freescale.com>
	<1180354247.5816.30.camel@a10072.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C4C1243CF
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 21:02:19 +0200 (CEST)
In-Reply-To: <1180354247.5816.30.camel@a10072.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:

> Yes, although my feeling is that a codec "driver" would still be needed
> to define the capabilities of your codec within the audio subsystem.

Another question:

Why is it the codec driver that calls snd_soc_new_pcms()?  Shouldn't the PCM driver be 
doing that?

Looking in snd_soc_new_pcms() itself, I see this:

	codec->card = snd_card_new(idx, xid, codec->owner, 0);

Here we create a new "sound card", and we assign it to the

I guess I just don't understand why the codec driver is acting like the "master" driver of 
ASOC.  IMHO, the codec driver should be doing two things:

1) Specifying the capabilities of the codec hardware itself, without any assumption that 
these capabilities dictate the capabilities of the system as a whole (e.g. the codec 
shouldn't assume that the system supports every sampling rate that the codec does).
2) Providing APIs for controlling the codec.

ASOC and the machine driver should then work in tandem to decide which driver will do what 
and which capabilities are *actually* supported.  *Something* needs to look at the entire 
system and say to each device, "Well, yes, I know about this little feature of yours, but 
we're just not going to support that today."

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
