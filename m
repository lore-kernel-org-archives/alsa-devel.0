From: Glenn Maynard <g_sf@zewt.org>
Subject: Re: problems using select() on alsa pcm.
Date: Thu, 25 Mar 2004 16:44:24 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040325214423.GB13484@zewt.org>
References: <200403250408.i2P48qDC021625@dhin.linuxaudiosystems.com> <003301c41253$919b5c00$161b14ac@boromir> <s5h65ct58md.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h65ct58md.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 25, 2004 at 03:00:58PM +0100, Takashi Iwai wrote:
> > Why is select deprecated?
> 
> because select is just a wrapper of poll in fact (on linux)?

So?  There are a few other operating systems out there, and select() is
very portable.

(select isn't deprecated; it's simply not Linus's API to deprecate. :)

-- 
Glenn Maynard


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
