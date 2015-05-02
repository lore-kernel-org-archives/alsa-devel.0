From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ALSA: hda - Add dock support for ThinkPad X250
 (17aa:2226)
Date: Sat, 2 May 2015 15:20:18 +0200
Message-ID: <20150502132018.GA21158@kroah.com>
References: <1428737495-9906-1-git-send-email-corsac@debian.org>
 <1428737495-9906-2-git-send-email-corsac@debian.org>
 <s5hlhhy4rej.wl-tiwai@suse.de>
 <1429468288.4396.7.camel@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429468288.4396.7.camel@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arnaud Ebalard <arno@natisbad.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 19, 2015 at 08:31:28PM +0200, Yves-Alexis Perez wrote:
> On sam., 2015-04-11 at 17:27 +0200, Takashi Iwai wrote:
> > At Sat, 11 Apr 2015 09:31:35 +0200,
> > Yves-Alexis Perez wrote:
> > > 
> > > This model uses the same dock port as the previous generation.
> > > 
> > > Signed-off-by: Yves-Alexis Perez <corsac@debian.org>
> > 
> > Thanks, applied with Cc to stable.
> > But, at the next time, please put maintainers to Cc.
> 
> Hi Greg,
> 
> I noticed a similar patch (f2aa1110 for the ThinkPad T450) was correctly
> included in 3.19.5 (as 3b941649), but this one (c0278669) was not.
> 
> Is there something I'm missing?

It was not in a released kernel from Linus yet.  It now showed up in
4.1-rc1, so it can go into a stable tree.

greg k-h
