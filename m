From: Tim Blechmann <TimBlechmann@gmx.net>
Subject: Re: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion
 -- First good news!
Date: Sun, 11 Apr 2004 16:07:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040411160720.41b8c2e7@laptop>
References: <20040403041732.FAYW17964.smtp2.fuse.net@64BitBadass>
	<20040409222552.MLZG22605.smtp2.fuse.net@64BitBadass>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040409222552.MLZG22605.smtp2.fuse.net@64BitBadass>
To: Ivica Ico Bukvic <ico@fuse.net>
Cc: 'A list for linux audio users' <linux-audio-user@music.columbia.edu>, 'Russell King' <rmk+lkml@arm.linux.org.uk>, alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org, 'Thomas Charbonnel' <thomas@undata.org>
List-Id: alsa-devel@alsa-project.org

> It's called "System Explorer v.1.00"
> Screenshot of the pcmcia controller's state while card is
> disconnected:
> http://meowing.ccm.uc.edu/~ico/eMachines/SE-before_suspend.jpg
> Written by Danny Liu (AMI) and it's free (supposedly, haven't looked
> for it on the Internet just yet, too tired right now)
i'm confused ... the bytes that got altered are no members of the pci
configuration space ... could you try to do the same tests with the
hdsp? maybe there's a register in the configuration space of the hdsp
that's getting altered as well...

... and we should try to figure out, what these registers are actually
doing ... cheers...

 Tim                          mailto:TimBlechmann@gmx.de
                              ICQ: 96771783
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac
