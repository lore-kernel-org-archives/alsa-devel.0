From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: alsa-lib pcm not starting
Date: Sun, 29 Feb 2004 17:47:19 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040229174719.C9081@flint.arm.linux.org.uk>
References: <20040229105343.A28963@flint.arm.linux.org.uk> <Pine.LNX.4.58.0402291323420.1880@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402291323420.1880@pnote.perex-int.cz>; from perex@suse.cz on Sun, Feb 29, 2004 at 01:31:01PM +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 29, 2004 at 01:31:01PM +0100, Jaroslav Kysela wrote:
> On Sun, 29 Feb 2004, Russell King wrote:
> > Could someone enlighten me about the way alsa-lib / alsa-driver are
> > supposed to work when using mmap mode please?  I'm looking at the 1.0.2
> > code, along with madplay and Linux 2.6.4-rc1.
> > 
> > madplay sets the start_threshold to the size of the buffer, and min_avail
> > to one period size - in much the same way as the alsa-lib test/pcm.c
> > program.
> 
> We know about this problem. The start_threshold must be equal or less than
> (buffer_size / avail_min) * avail_min in this case.

I think it's a little more complex than that.  In my case,
buffer_size = 16384, avail_min = 256, so:

	(buffer_size / avail_min) * avail_min = 16384

which is what was being programmed anyway.  However,

	(int(buffer_size / avail_min) - 1) * avail_min = 16128

would make more sense.  Do you agree?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
