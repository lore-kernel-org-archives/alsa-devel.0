From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: latency.c: some feature requests
Date: Sun, 28 Nov 2004 13:49:05 -0500
Message-ID: <1101667746.18348.14.camel@krustophenia.net>
References: <1101617894.21427.9.camel@krustophenia.net>
	 <Pine.LNX.4.58.0411281232540.11615@pnote.perex-int.cz>
	 <1101667038.18348.4.camel@krustophenia.net>
	 <Pine.LNX.4.58.0411281942520.6878@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0411281942520.6878@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2004-11-28 at 19:44 +0100, Jaroslav Kysela wrote:
> > Noninterleaved devices are not supported at all.  The access method is
> > hardcoded to interleaved.
> 
> Yes, but alsa-lib will do the necessary conversion.

OK, thanks.  One other thing I noticed is that latency.c doesn't mmap.
This would cause higher latencies compared to testing with JACK,
correct?

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
