From: Glenn Maynard <g_sf@zewt.org>
Subject: Re: Detecting runtime ALSA library version
Date: Tue, 6 Apr 2004 17:10:24 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040406211024.GI19477@zewt.org>
References: <20040406203629.GH19477@zewt.org> <200404062104.i36L4Y4c010563@dhin.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200404062104.i36L4Y4c010563@dhin.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 06, 2004 at 05:04:34PM -0400, Paul Davis wrote:
> >I can't find any way to detect the running ALSA version, for diagnostic
> 
> cat /proc/asound/version

That's the driver version, which I'm already logging.  Like I said, I
want the alsa-lib version that's being linked in, which very often has
no relation to the alsa-driver version.

-- 
Glenn Maynard


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
