From: Timur Tabi <timur@freescale.com>
Subject: Re: Requiring the same sample rate for playback and
 record?
Date: Mon, 23 Jun 2008 07:08:22 -0500
Message-ID: <485F9236.8090801@freescale.com>
References: <485C0042.4050008@freescale.com> <s5h7icg4dsd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FA7E244E7
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jun 2008 14:08:27 +0200 (CEST)
In-Reply-To: <s5h7icg4dsd.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> Right now there is no "elegant" way for this, unfortunately.
> A common way many drivers use is to remember the rate of the first
> stream, then add it to hw_constraint of the secondary streams.
> But, this could be also a bit racy (unavoidable due to its design)
> although practically it seems working.

Ok, thanks.  I assume the same solution applies if I have a sample *format* 
restriction?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
