From: "Ivica Bukvic" <ico@fuse.net>
Subject: RE: question regarding latest CS4205 laptop    soundcard driver
Date: Wed, 27 Feb 2002 01:00:01 -0500
Message-ID: <a5hsv1$fpm$1@quimby2.netfonds.no>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.44.0202261906010.21337-100000@sasami.anime.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: 'Dan Hollis' <goemon@anime.net>
Cc: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > *There is esd, which is outdated and simply crappy.
> > *There is artsd, which is better, but not good enough, and again,
the
> > app must be made to be aware of it in order to utilize it.
> > *There is JACK project which has a huge potential but none of its
> > effects are again universal, nor backwards-compatible with already
> > released software.
> > *There is Gstreamer, but I do not honestly know enough about it.
> 
> Then make them better.

While I would like to thank you for your prompt response, I want to
point out that I find your above statement rather discouraging. Not
everyone is a low-level programmer, and not everyone should be one. Yet,
with such statement you are implying exactly that: "for one to use Linux
for multimedia, one has to be prepared to be able to do low-level coding
in an environment that inherently suffers from lack of documentation."

Although I've provided my humble coding contributions to the Linux
community, I am by no means an adept programmer who is capable of
dealing with the low-level stuff such as this (needless to say I have no
clue where to start since documentation is less than sparse). Besides, I
would love to help any of these projects to reach their "ripeness," but
find most of them to be focused on things that need less urgent
attention (i.e. JACK, as I understand it, focuses on inter-app audio
communication in a highly efficient manner, requiring app-side
implementation for any kind of dsp resource sharing, thus meaning there
is currently no planned backwards-compatibility, unless the older apps
are adapted to its architecture, which in itself is a rather far-fetched
assumption that the other application developers will be willing to
adapt their apps to this yet-and-if-to-be-established-standard).

Majority of the older, but still maintained apps, access the /dev/dsp
resources in an OSS fashion. Since my understanding is that Alsa is
already capable of fooling these through its OSS emulation (that, if I
am not mistaken, already transparently exists between the actual dsp
resource and the app), wouldn't it be a rather easy step to make it also
be capable of accepting multiple queries and down-mixing them before
sending them to the actual dsp?

Finally, why not merge the efforts of all these different
groups/projects into one concise solution, rather than a dozen
half-working ones?

Sincerely,

Ico



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
