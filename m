From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [for 2.6.34][PATCH] ALSA: pcm_lib - fix xrun
	functionality
Date: Fri, 26 Mar 2010 16:57:41 +0200
Message-ID: <20100326165741.d15c83b9.jhnikula@gmail.com>
References: <1269612445-14245-1-git-send-email-jhnikula@gmail.com>
	<s5hvdcjnokb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f226.google.com (mail-ew0-f226.google.com
	[209.85.219.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 98CAF103821
	for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2010 15:55:18 +0100 (CET)
Received: by ewy26 with SMTP id 26so140217ewy.3
	for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2010 07:55:18 -0700 (PDT)
In-Reply-To: <s5hvdcjnokb.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Pavel@alsa-project.org, Machek <pavel@ucw.cz>
List-Id: alsa-devel@alsa-project.org

On Fri, 26 Mar 2010 15:29:56 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Fri, 26 Mar 2010 16:07:25 +0200,
> Jarkko Nikula wrote:
> > 
> > The commit 4d96eb255c53ab5e39b37fd4d484ea3dc39ab456 broke the interrupt
> > time xrun functionality (stream stop etc.) if the CONFIG_SND_PCM_XRUN_DEBUG
> > is not set. This is because the xrun() is null defined without it.
> > 
> > Fix this by letting the function xrun() to be always defined as it was
> > before.
> 
> Thanks, that's likely the problem Pavel has seen, but never reproduced
> on Jaroslav or my machine.
> 
Yeah, I just tested and my patch is fixing that [1] too :-)


-- 
Jarkko
1.
http://mailman.alsa-project.org/pipermail/alsa-devel/2010-March/026155.html
