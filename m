From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa-lib pcm not starting
Date: Sun, 29 Feb 2004 13:31:01 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402291323420.1880@pnote.perex-int.cz>
References: <20040229105343.A28963@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040229105343.A28963@flint.arm.linux.org.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Russell King <rmk+alsa@arm.linux.org.uk>
Cc: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 29 Feb 2004, Russell King wrote:

> Hi,
> 
> Could someone enlighten me about the way alsa-lib / alsa-driver are
> supposed to work when using mmap mode please?  I'm looking at the 1.0.2
> code, along with madplay and Linux 2.6.4-rc1.
> 
> madplay sets the start_threshold to the size of the buffer, and min_avail
> to one period size - in much the same way as the alsa-lib test/pcm.c
> program.

We know about this problem. The start_threshold must be equal or less than
(buffer_size / avail_min) * avail_min in this case. The avail_min
specifies the minimal transfer count (for optimization) so the
start_threshold - in this case - violates the read/write policy. The new
code in alsa-lib does not allow to install this "broken" sw_params
configuration, so application developers can detect this mistake.

Also, alsa-lib/test/pcm.c code was fixed to follow this specification 
(I am sorry - it was my mistake). This fix will be available in 1.0.3 
release.

So, the fault is on the application side.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
