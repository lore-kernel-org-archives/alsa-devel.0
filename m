From: Alex Riesen <fork0@users.sourceforge.net>
Subject: Re: 2.6.3-rc1: intel8x0 broken
Date: Tue, 10 Feb 2004 21:31:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040210203126.GA1305@steel.home>
References: <20040209214622.GA1944@steel.home> <s5h3c9j2tly.wl@alsa2.suse.de>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h3c9j2tly.wl@alsa2.suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai, Tue, Feb 10, 2004 10:04:25 +0100:
> > I have a Gigabyte GA-I8IPE1000 Pro motherboard with a built-in 82801EB
> > (Intel Corp. 82801EB AC'97 Audio Controller).
> > 
> > The thing stopped produce any sound since Linus' last alsa update.
> > Reverting to the previous state of alsa driver works, of course.
> 
> if your ac97 chip is ALC650 or ALC655/658, the attached patch should
> fix.
> 

ALC658. It did help, of course. Thank you very much.
