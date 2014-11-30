From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] sound: use enum names instead of magic numbers
Date: Sun, 30 Nov 2014 11:26:12 -0800
Message-ID: <1417375572.818.10.camel@perches.com>
References: <1417201196-12392-1-git-send-email-KyleChamberlin@project20million.org>
	 <s5h7fydbv6w.wl-tiwai@suse.de> <1417294692.818.3.camel@perches.com>
	 <s5h1tolaxmc.wl-tiwai@suse.de> <1417337732.818.8.camel@perches.com>
	 <s5hwq6d9hze.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hwq6d9hze.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2014-11-30 at 10:04 +0100, Takashi Iwai wrote:
> At Sun, 30 Nov 2014 00:55:32 -0800, Joe Perches wrote:
> > On Sun, 2014-11-30 at 09:41 +0100, Takashi Iwai wrote:
> > > At Sat, 29 Nov 2014 12:58:12 -0800, Joe Perches wrote:
> > > > There's an enum defined for these magic numbers,
> > > > might as well use it.
> > > > 
> > > > Miscellanea:
> > > > o Use ##__VA_ARGS__
[]
> > Write it as you chose.  It is pretty trivial.
> 
> ... trivial for anyone ;)

The other option is simply to remove the enum
as the values are unused.
