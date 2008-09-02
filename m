From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH 1/2] ca0106 playback 44100Hz
 support	to	SPDIF and	playback	format & rate constraints
Date: Tue, 02 Sep 2008 22:18:03 +0100
Message-ID: <48BDAD8B.8060007@superbug.co.uk>
References: <1219415921.32652.254.camel@localhost>	<s5h63ptf48b.wl%tiwai@suse.de>
	<1219502224.15980.32.camel@localhost>	<s5h7ia5dpe0.wl%tiwai@suse.de>
	<1220375467.7459.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net
	[194.217.242.90])
	by alsa0.perex.cz (Postfix) with ESMTP id 133EE24662
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Sep 2008 23:18:10 +0200 (CEST)
In-Reply-To: <1220375467.7459.8.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Stanley <Ben.Stanley@exemail.com.au>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ben Stanley wrote:
> +		/* We only support 44100 to spdif, not to DAC.
> +		   (FIXME WHY?)*/

WHY?  Because the DAC cannot be clocked at 44100, only 48000 and 96000
from the CA0106 chip.
The SPDIF can be clocked at 44100.
It is a hardware limitation.

Kind Regards

James
