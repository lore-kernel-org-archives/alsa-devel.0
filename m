From: Brian Bloniarz <brian.bloniarz@gmail.com>
Subject: Re: [RFC PATCH] theory about CS8247 failed reads
Date: Tue, 18 Jan 2011 10:39:48 -0800
Message-ID: <4D35DE74.6030307@gmail.com>
References: <4D353F23.4020900@gmail.com> <s5hr5cagumg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B5A3103859
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 19:39:54 +0100 (CET)
Received: by pwj4 with SMTP id 4so1362101pwj.38
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 10:39:53 -0800 (PST)
In-Reply-To: <s5hr5cagumg.wl%tiwai@suse.de>
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

On 01/18/2011 06:21 AM, Takashi Iwai wrote:
> Yes, your fix looks sane (and safe).
> I'll queue it up later for 2.6.38 merge.
Sounds great, thanks!

> The retry-code can be kept for a while as it's basically harmless for
> the succeeded case.  We can remove it eventually later, but I doubt we
> can be 100% sure about such a thing ;)
Sure, that makes sense to me.

Thanks,
-Brian
