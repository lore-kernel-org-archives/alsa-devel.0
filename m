From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [linux-audio-user] snd-hdsp+cardbus=distortion -- the sagacontinues (cardbus driver=culprit?) UPDATE: 99.9% sure it is the cardbus driver yenta_socket
Date: Tue, 30 Mar 2004 09:00:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040330090053.A3956@flint.arm.linux.org.uk>
References: <20040329235823.04bacef4@laptop> <20040330055204.UUGL2042.smtp1.fuse.net@64BitBadass>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20040330055204.UUGL2042.smtp1.fuse.net@64BitBadass>; from ico@fuse.net on Tue, Mar 30, 2004 at 12:52:11AM -0500
To: Ivica Ico Bukvic <ico@fuse.net>
Cc: 'A list for linux audio users' <linux-audio-user@music.columbia.edu>, alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 30, 2004 at 12:52:11AM -0500, Ivica Ico Bukvic wrote:
> 6) Pester alsa-dev, lau, and kernel/pcmcia people to death begging for help
> :-)
> 
> IN-PROGRESS :-)

What needs to happen is that the card driver author needs to investigate
what is going on, and, if it seems related to the core PCMCIA core or
the socket driver, we need to get involved.

IOW, linux-pcmcia people don't debug card drivers.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
