From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: period size
Date: Sat, 3 Apr 2004 10:41:14 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0404031040250.2140@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0403301505490.25443-100000@studcom.urz.uni-halle.de>
 <EB5AA0AA-8258-11D8-88CD-000A95AB8A40@hollingsworth.com.au>
 <Pine.LNX.4.58.0403301729380.1835@pnote.perex-int.cz>
 <A521B1A8-838A-11D8-89F0-000A95AB8A40@hollingsworth.com.au>
 <Pine.LNX.4.58.0404011051250.1843@pnote.perex-int.cz>
 <8436B8CE-84A1-11D8-B350-000A95AB8A40@hollingsworth.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <8436B8CE-84A1-11D8-B350-000A95AB8A40@hollingsworth.com.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tim Hollingsworth <tim@hollingsworth.com.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2 Apr 2004, Tim Hollingsworth wrote:

> Thanks for your help so far Jaroslav.
> 
> I have taken another look at my project and now it's behaving 
> differently!  It still won't go down to a period size of 128.
> 
> I have downloaded the example sine wave generator.  It works with the 
> default settings, which give a period size of 4410.  If I change the 
> period time using the command line, it will successfully go down to 
> 441/10000us.  Any further and I get this error:
> 
> ALSA lib pcm.c:824:(snd_pcm_sw_params) snd_pcm_sw_params: 
> params->avail_min problem for start_threshold
> Unable to set sw params for playback: Invalid argument
> Setting of swparams failed: Invalid argument

Fixed in CVS.

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
