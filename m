From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: src pointer parameter in copy operator
Date: Sun, 4 Apr 2004 10:10:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0404041010280.1830@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0403301505490.25443-100000@studcom.urz.uni-halle.de>
 <EB5AA0AA-8258-11D8-88CD-000A95AB8A40@hollingsworth.com.au>
 <Pine.LNX.4.58.0403301729380.1835@pnote.perex-int.cz>
 <A521B1A8-838A-11D8-89F0-000A95AB8A40@hollingsworth.com.au>
 <Pine.LNX.4.58.0404011051250.1843@pnote.perex-int.cz>
 <8436B8CE-84A1-11D8-B350-000A95AB8A40@hollingsworth.com.au>
 <Pine.LNX.4.58.0404031040250.2140@pnote.perex-int.cz> <000901c419b7$274ffe80$0403a8c0@win2K>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <000901c419b7$274ffe80$0403a8c0@win2K>
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

On Sat, 3 Apr 2004, Mathieu Rondonneau wrote:

> Hi all,
> 
> I have question according to the src pointer in the copy operator:
> I'm writing an ALSA driver for the cogent CSB337 board. I'm testing the
> driver but there are some problem.
> I'm trying to playback a wav file, but i hear some strange noise, not the
> data corresponding to the wav file.
> I compared the data of the wav file and the data in the copy operator
> (before they sent to the codec). They are different.
> 
> Why the data pointed by the src pointer (parameter of the playback copy
> operator) and the data of the wav file to playback are different?

What prints the 'aplay -v' command?

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
