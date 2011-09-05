From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: usb: refine delay information with
 USB	frame counter
Date: Mon, 05 Sep 2011 09:53:26 +0200
Message-ID: <4E647FF6.2000205@ladisch.de>
References: <1314642732-8909-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 6DD8A10388D
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Sep 2011 09:53:32 +0200 (CEST)
In-Reply-To: <1314642732-8909-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: sarah.a.sharp@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pierre-Louis Bossart wrote:
> ... This should improve audio/video sync

It does indeed; mplayer's A-V difference gets lowered from up to
nrpacks ms down to at most 1 ms.

> +	est_delay =  subs->last_delay-(frame_diff*rate/1000L);

Why a long dividend?

The spacing around operators is inconsistent; please use checkpatch.

> +		snd_printk(KERN_DEBUG "ALSA usb.c: Delay %d actual delay %d\n",
> +			est_delay, subs->last_delay);

snd_printk already can print the "ALSA" and file name prefixes.
(And it uses the correct file name.  ;-)


Regards,
Clemens
