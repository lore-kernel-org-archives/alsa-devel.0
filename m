From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: src pointer parameter in copy operator
Date: Tue, 6 Apr 2004 08:51:52 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0404060851110.3153@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0403301505490.25443-100000@studcom.urz.uni-halle.de>
 <EB5AA0AA-8258-11D8-88CD-000A95AB8A40@hollingsworth.com.au>
 <Pine.LNX.4.58.0403301729380.1835@pnote.perex-int.cz>
 <A521B1A8-838A-11D8-89F0-000A95AB8A40@hollingsworth.com.au>
 <Pine.LNX.4.58.0404011051250.1843@pnote.perex-int.cz>
 <8436B8CE-84A1-11D8-B350-000A95AB8A40@hollingsworth.com.au>
 <Pine.LNX.4.58.0404031040250.2140@pnote.perex-int.cz> <000901c419b7$274ffe80$0403a8c0@win2K>
 <Pine.LNX.4.58.0404041010280.1830@pnote.perex-int.cz> <001801c41b6f$ae2f1ee0$0403a8c0@win2K>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <001801c41b6f$ae2f1ee0$0403a8c0@win2K>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mathieu Rondonneau <mathieu.rondonneau@polymtl.ca>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 5 Apr 2004, Mathieu Rondonneau wrote:

> I don't use aplay to play the wav file but i use:
> dd of=thefile.wav of=/dev/audio0

This is definitely wrong. The /dev/audio devices expect mu-Law
format at 8000Hz.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
