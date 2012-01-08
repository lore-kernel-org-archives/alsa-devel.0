From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: fix possible hang and
	overflow in parse_uac2_sample_rate_range()
Date: Sun, 8 Jan 2012 07:45:09 -0500
Message-ID: <780588F2-6183-44B3-8EB8-CB82FB3DD8A7@gmail.com>
References: <1325698749-5353-1-git-send-email-xi.wang@gmail.com>
	<s5hehvamuh4.wl%tiwai@suse.de>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DC2D324380
	for <alsa-devel@alsa-project.org>; Sun,  8 Jan 2012 13:45:15 +0100 (CET)
Received: by iaae16 with SMTP id e16so5262922iaa.38
	for <alsa-devel@alsa-project.org>; Sun, 08 Jan 2012 04:45:13 -0800 (PST)
In-Reply-To: <s5hehvamuh4.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org, Daniel Mack <zonque@gmail.com>, Wolfgang Breyha <wbreyha@gmx.net>
List-Id: alsa-devel@alsa-project.org

On Jan 8, 2012, at 4:09 AM, Takashi Iwai wrote:
> As of now, I have little time to evaluate, so I might have missed
> something, but I wonder whether 
> 
> 		/* avoid overflow */
> 		if (nr_rates == KMALLOC_MAX_SIZE / sizeof(int))
> 			break;
> 
> is the best way to check.  This looks ugly to me.
> If we need to limit the number of rates, better to define some proper
> numbers as the upper limit.  And then, it should warn, not only
> breaking loop.

Thanks for looking into this.  Yeah, I agree using something like
MAX_NR_RATES is better.  Is 65535 okay or do we need a larger limit?

- xi
