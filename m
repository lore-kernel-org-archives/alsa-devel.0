From: Chuckles <chuckleberryfinn@gmail.com>
Subject: Re: Alsa Mixer api documentation. (Damn u C programmers!)
Date: Mon, 25 Jul 2005 16:20:38 +0200
Message-ID: <29d8345905072507201fb8d044@mail.gmail.com>
References: <29d8345905072416467aa8dc4d@mail.gmail.com>
	 <1122254407.31270.1.camel@mindpipe>
	 <29d8345905072504337b900491@mail.gmail.com>
	 <Pine.LNX.4.61.0507251508500.8412@tm8103.perex-int.cz>
Reply-To: Chuckles <chuckleberryfinn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0507251508500.8412@tm8103.perex-int.cz>
Content-Disposition: inline
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> The amixer code cannot be easier, but I agree that C++ programmer will=20
> have trouble with it, because functions contains more than 10 lines ;-)

I can see my eternal damnation now, an eternity sorting through
uncommented C programs in hell's ironic punishment department.  :op

> Write some docs in doxygen, we'll include it to our repository.
>=20
> =09=09=09=09=09=09Jaroslav

No probs. I'd be more than willing to write some docs for the mixer
api, if I could work out how to use it. So can you answer some
questions about it? I'm confused as to why its necessary to use
elements, simple elements and a high level control interface to set
sound levels on the mixer. I have done some mixer programming with
OSS, but this is very different. I see the snd_mixer_open function
opens an empty mixer, fine, does this imply that a software mixer has
to be built from the ground up? As in you add a pcm element, a master
element, a cd element depending on what is available on your
particular sound card to this empty mixer?

Cathal


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
