From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion -- FIXED!
Date: Mon, 12 Apr 2004 11:39:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040412113904.A11076@flint.arm.linux.org.uk>
References: <200404120145.22679.daniel.ritz@gmx.ch> <20040412013949.NJOP1634.smtp3.fuse.net@64BitBadass> <20040412130236.66a86b50@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20040412130236.66a86b50@laptop>; from TimBlechmann@gmx.net on Mon, Apr 12, 2004 at 01:02:36PM +0200
To: Tim Blechmann <TimBlechmann@gmx.net>
Cc: Ivica Ico Bukvic <ico@fuse.net>, 'Thomas Charbonnel' <thomas@undata.org>, daniel.ritz@gmx.ch, ccheney@debian.org, linux-pcmcia@lists.infradead.org, alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 12, 2004 at 01:02:36PM +0200, Tim Blechmann wrote:
> first of all, congratulations that you, ico, got your hdsp working ...

Only the first 0x48 registers are defined by the base specification;
the rest are chip and/or manufacturer specific.

The registers which Ico is changing are specific to the ENE CB1410,
which are a clone of the TI chips.

Your cardbus bridge isn't a clone of TI, so I wouldn't expect the
same fix to work for you.

However, we now have some of the clues, so...

PS, in your first mail I have on this subject, you mentioned someone
called "Timothy" who had the same problem, and was using Red Hat with
a TI bridge.  I don't seem to have any responses from him, and it would
be good to get some feedback from him as well.  Specifically whether
stock 2.6.5 works or exhibits the same problem.

Stock 2.6.5 with TI bridges should already set 0x81 to 0xd0, and they
don't have the other register at 0xc9.  This only leaves the cardbus
bridge latency timer.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
