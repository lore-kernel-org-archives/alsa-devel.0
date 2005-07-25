From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: Alsa Mixer api documentation.
Date: Mon, 25 Jul 2005 15:11:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0507251508500.8412@tm8103.perex-int.cz>
References: <29d8345905072416467aa8dc4d@mail.gmail.com>  <1122254407.31270.1.camel@mindpipe>
 <29d8345905072504337b900491@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <29d8345905072504337b900491@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chuckles <chuckleberryfinn@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 25 Jul 2005, Chuckles wrote:

> So that's a no then. I had been looking at the source for amixer.c but
> what can I tell ya? Pouring over 1500 lines of uncommented, (mostly)
> static methods written in C is hardly the best way to learn an api now
> is it? (Do linux developers hate c++/oo programming or do they just
> willfully ignore it?) Apart from the opening few lines about the gnu
> gpl there are 3 (count 'em) 3, one line comments in a source file of
> over 1500 lines. But if the alsa developers can't be bothered to write
> the docs I suppose I don't have much choice.

The amixer code cannot be easier, but I agree that C++ programmer will 
have trouble with it, because functions contains more than 10 lines ;-)

Write some docs in doxygen, we'll include it to our repository.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
