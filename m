From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion -- FIXED!
Date: Mon, 12 Apr 2004 16:38:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040412163854.C12980@flint.arm.linux.org.uk>
References: <20040412082801.A3972@flint.arm.linux.org.uk> <20040412144103.PIXB8029.smtp1.fuse.net@64BitBadass> <20040412155336.B12980@flint.arm.linux.org.uk> <200404121731.20765.daniel.ritz@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200404121731.20765.daniel.ritz@gmx.ch>; from daniel.ritz@gmx.ch on Mon, Apr 12, 2004 at 05:31:20PM +0200
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Ivica Ico Bukvic <ico@fuse.net>, 'Tim Blechmann' <TimBlechmann@gmx.net>, 'Thomas Charbonnel' <thomas@undata.org>, ccheney@debian.org, linux-pcmcia@lists.infradead.org, alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 12, 2004 at 05:31:20PM +0200, Daniel Ritz wrote:
> EnE datasheet says it's also available in EnE 1211, 1225, 1420.
> and since they are TI clones why not for the TI's too?

Because the register supposedly does not exist on TI - it's likely to be
EnE specific.

I'm willing to bet that TI chips will behave as expected without touching
0xc9 at all.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
