From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: [Openal-devel] Software fallback.
Date: Thu, 08 Jan 2004 01:32:34 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1073539954.32109.28.camel@localhost>
References: <1073270749.4149.35.camel@localhost>
	 <1073320851.18395.109.camel@joe.fatnsoft.com>
	 <1073354941.10064.15.camel@localhost>
	 <1073369731.4993.1.camel@joe.fatnsoft.com>
	 <1073395480.1386.6.camel@localhost>
	 <21540.198.95.32.195.1073502943.squirrel@www.hibyte.com>
Reply-To: manuel.jander@mat.utfsm.cl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <21540.198.95.32.195.1073502943.squirrel@www.hibyte.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm cross posting this from OpenAL, since it may have some relevance to
ALSA.

As some already might know, i'm designing a ALSA - OpenAL interface for
advanced hardware feature support.

As far as i understood, they say that the would prefer to handle any
kind of resource managing and moire specifically "software fallback"
functions inside of each driver. I don't know yet much about the "plug"
extensions, but i remember someone commenting that one can pass PCM data
through LADSPA plugins with this. I was thinking that maybe such a kind
of mechanism could be used to route "software fallback" PCM channels
through appropriate software filters. Could anyone with more knowledge
comment about that ?

Best Regards
 

On Wed, 2004-01-07 at 15:15, Garin Hiebert wrote:
> > OK. I understood. But why is "all hardware sources is good, use hardware
> > sources until you run out and then software" so bad at all ? I think
> > that precisely that should be the most desirable behavior.
> >
> > For example the now dead A3D API includes a resource manager for
> > handling this. So the sources that really need spatialization, they get
> > it in hardware. Other things like ambient sounds and the like get other
> > normal DMA channels. Only if the preset maximal software sources value
> > is crossed, the next sources get "virtual" (no hardware nor software
> > handles them). As soon as a new source is available, the most highest
> > priority "virtual source" takes it place.
> 
> I suppose this would be a good item to put into a FAQ, if we had one (note
> to self...).
> 
> The reason why hardware sources don't "rollover" to software sources is
> that the transition from one to the other would be noticable in a really
> bad way.  If you have a 7.1 speaker setup playing X sources with EAX
> support, you don't want to add one more source and find that it is only
> spatialized into the front two speakers without reverb -- that would just
> sound strange.  On top of that, all of a sudden a game's framerate would
> radically change.  You might be running along at 60 frames per second with
> hardware sources, and then suddenly the game creates five software sources
> and the framerate goes down to 45 fps because of the entirely new
> rendering path being activated.
> 
> At some point, the application should deal with voice management anyways
> -- having an un-constrained number of sources for your application will
> just lead to miserable performance for no good reason (in that there
> probably aren't 758 things you really should be listening to at the same
> time anyways even if they can all be rendered).
> 
> Garin
> 
> 
> 



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
