From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: oss-redir/libaoss doesn't set blocked IO correctly
 [PATCH]
Date: Sat, 19 Mar 2005 16:11:36 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0503191611240.1760@pnote.perex-int.cz>
References: <423C3CC0.80307@mxtelecom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <423C3CC0.80307@mxtelecom.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Matthew Hodgson <matthew@mxtelecom.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 19 Mar 2005, Matthew Hodgson wrote:

> Hi,
> 
> I'm investigating switching videolan's OSS-style audio-capture (used to 
> complement streaming from a v4l source) to use the alsa-oss oss-redir 
> abstraction layer.  Whilst writing the patch, I came up against the 
> quirk that
> 
> i_fd = oss_pcm_open(devname, O_RDONLY | O_NONBLOCK)
> 
> doesn't return a non-blocking file descriptor.  This is a bit of a 
> showstopper, as vlc relies on the fd being nonblocking in order for the 
> thread to yield to allow interleaved video capture to occur.
> 
> The problem appears to be a typo in alsa-oss/alsa/pcm.c:oss_dsp_open(), 
> where the mode parameter rather than the oflags parameter is checked for 
> the O_NONBLOCK flag.  I've included a trivial patch to fix it.

Applied. Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
