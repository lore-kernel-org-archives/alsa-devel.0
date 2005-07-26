From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Alsa Mixer api documentation. (Damn u C programmers!)
Date: Tue, 26 Jul 2005 15:12:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0507261505340.8190@tm8103-a.perex-int.cz>
References: <29d8345905072416467aa8dc4d@mail.gmail.com>  <1122254407.31270.1.camel@mindpipe>
  <29d8345905072504337b900491@mail.gmail.com>  <Pine.LNX.4.61.0507251508500.8412@tm8103.perex-int.cz>
 <29d8345905072507201fb8d044@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <29d8345905072507201fb8d044@mail.gmail.com>
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

> > Write some docs in doxygen, we'll include it to our repository.
> > 
> > 						Jaroslav
> 
> No probs. I'd be more than willing to write some docs for the mixer
> api, if I could work out how to use it. So can you answer some
> questions about it? I'm confused as to why its necessary to use
> elements, simple elements and a high level control interface to set
> sound levels on the mixer.

Please, choose only one method. You can access directly the universal 
control elements (direct mapping to driver) or use more simple interface 
(snd_mixer_selem* function / defines).

> I have done some mixer programming with OSS, but this is very different. 
> I see the snd_mixer_open function opens an empty mixer, fine, does this 
> imply that a software mixer has to be built from the ground up? As in 
> you add a pcm element, a master element, a cd element depending on what 
> is available on your particular sound card to this empty mixer?

The alsa-lib does all this work. You need only enumerate (see selems() 
function in amixer.c) and write/read values (see sset() function in 
amixer.c) from such elements. Also note that all elements might be dynamic 
(removed / added on the fly).

Basically, you need only to create a connection between driver (universal 
control interface) and the more abstract layer in the initialization 
phase.

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
