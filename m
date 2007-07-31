From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2] ASoC CS4270 codec device driver
Date: Tue, 31 Jul 2007 08:36:55 -0500
Message-ID: <46AF3AF7.10905@freescale.com>
References: <11858269303921-git-send-email-timur@freescale.com>
	<s5hodhsvki1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E88C243A3
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Jul 2007 15:35:29 +0200 (CEST)
In-Reply-To: <s5hodhsvki1.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> Better now.  But, I found that your patch can't be applied cleanly to
> the latest ALSA tree.  Could you regenerate it for mm tree (or
> perex/alsa.git mm branch)?

I'll use perex/alsa.git, since I my corporate firewall doesn't block kernel.org.

> 
> Another thing I noticed is that the comment style.  /** is used for
> JavaDoc style comments, which are processed via kerneldoc.  Normal
> comments should use simply /* instead.

Ok, I'll fix that.  My editor has special features for handling /** comments, which is why I prefer them.
