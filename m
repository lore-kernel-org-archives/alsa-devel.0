From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 24/25] sound: Use static const char arrays
Date: Mon, 13 Sep 2010 13:47:45 -0700
Message-ID: <1284410865.26719.88.camel@Joe-Laptop>
References: <cover.1284406638.git.joe@perches.com>
	 <d0ef4062f24ff95c6f7d44a9123e19c17e712744.1284406639.git.joe@perches.com>
	 <s5h1v8xl73g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h1v8xl73g.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-09-13 at 22:30 +0200, Takashi Iwai wrote:
> At Mon, 13 Sep 2010 12:48:02 -0700,
> Joe Perches wrote:
> > diff --git a/sound/core/misc.c b/sound/core/misc.c
> > -	char tmp[] = "<0>";
> > +	char tmp[sizeof("<0>")];
> Would this case save something really...?

Not really.  It's the same x86 code size with different opcodes.
It's just a stupid checkpatch future warning avoidance change.
Ignore it at your pleasure.

cheers, Joe
