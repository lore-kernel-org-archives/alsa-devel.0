From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion -- FIXED!
Date: Mon, 12 Apr 2004 15:53:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040412155336.B12980@flint.arm.linux.org.uk>
References: <20040412082801.A3972@flint.arm.linux.org.uk> <20040412144103.PIXB8029.smtp1.fuse.net@64BitBadass>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20040412144103.PIXB8029.smtp1.fuse.net@64BitBadass>; from ico@fuse.net on Mon, Apr 12, 2004 at 10:40:59AM -0400
To: Ivica Ico Bukvic <ico@fuse.net>
Cc: daniel.ritz@gmx.ch, 'Tim Blechmann' <TimBlechmann@gmx.net>, 'Thomas Charbonnel' <thomas@undata.org>, ccheney@debian.org, linux-pcmcia@lists.infradead.org, alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 12, 2004 at 10:40:59AM -0400, Ivica Ico Bukvic wrote:
> Sorry :-) Mandrake Community 10.0 using the 2.6.3 kernel with a patch to fix
> the freezing when probing for the pcmcia card on this particular notebook
> (see: http://www.muru.com/linux/amd64/).

Pavel's fix isn't really a fix, it's more a work-around.  If we keep
increasing PCIBIOS_MIN_CARDBUS_IO until we hit 0xffff, everyones
system stops working.

The problem there will be that there's some IO registers between 0x4000
and 0x5000 which the BIOS wants access to, but the kernel didn't know
that they existed.

In any case, 2.6.3 does not contain the patches for CB1410, so chances
are that your problem is already half solved in 2.6.5.

Ok, so the action plan is:

- set 0xc9 to 0x04 for CB1410 (and others?)
- find a reasonable solution to the latency timer, maybe just setting it
  to 0xff when we detect the bridge.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
