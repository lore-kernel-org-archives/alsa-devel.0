From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: smix plugin available?
Date: Wed, 27 Nov 2002 17:21:39 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0211271632540.8585-100000@ecabase.localdomain>
References: <E18H2PQ-0005AZ-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18H2PQ-0005AZ-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Jaroslav Kysela <perex@suse.cz>, James Courtier-Dutton <James@superbug.demon.co.uk>, Florian Bomers <Florian.Bomers@sun.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Nov 2002, Paul Davis wrote:

> Let's be totally clear about this. its not just that the callback
> model is suitable - the mserver model will actually not work for
> sample sync between applications. I have always been sure that the

I think this is the critical point. ALSA's smix/mserver doesn't actually
have to provide this. As Jaroslav has described, this simplifies the
implementation of the server code (as it has to provide the full ALSA PCM
API to clients), and as mentioned by Florian, this kind of server
functionality would be generally useful for a wide selection of
applications.

> However, for the class of users i am interested in, the mserver model
> isn't adequate, and thats why jack exists.

Yup, in addition to synchronous execution, JACK also provides interfaces 
for connection and transport management (both of which are important 
but not necessarily interesting to ALSA).

> i see this as more promising than the approach i think you are
> thinking of. you can't avoid the context switching - they *have* to
> happen so that the apps can run!! the question is *when* does it
> happen ... in JACK, they are initiated in a chain when the interface
> interrupts us. in the mserver model and/or the shared mmap'ed buffer
> approach, they just have to happen sometime between interrupts
> (otherwise the buffers are not handled in time). so there is no
> avoiding them, its just a matter of when they happen. the point of
> JACK's design is to force sample sync and to minimize latency - always
> generating and processing audio as close to when it is handled by the
> hardware as possible (hence the default 2 period setting). a model
> that allows the context switching to occur "sometime" between
> interrupts is more relaxed, but loses sample sync and slightly
> increases (some kinds of) latency. that doesn't mean i think its a
> stupid system, just one that lacks certain properties.

That nicely summarizes the whole thing. I think there's room 
for both servers. It should be possible to implement plugins
for both mserver-using-jack and jack-using-mserver scenarios.

> however, i do think that finding a kernel mechanism that would allow
> the mmap'ed buffer to be used the way that shared memory can be used
> is potentially extremely useful. even though data copying on modern
> machines doesn't consume much of the cycles burnt by almost any audio
> software, its still a cost that it would nice to reduce.

Btw; I tend to think the memory bandwidth usage is a secondary issue.
Transferring data over PCI is somewhat problematic, but that's anyway 
done only once per direction. But as for memory bandwidth, today's 
computers supply a _lot_ of it. For instance PC133-SDRAM:1.06GB/s
and DDR333:2.7GB/s. 48 channels of 32bit data at 96kHz is only 17.5MB/s!
Of course, as we only want to spend small fraction of the callback to 
memory transfers it doesn't make sense to directly compare these 
figures, but they do give some perspective to the issue.

The primary issue is fast and reliable user-mode process wake-up.
Once you have that, and have deterministic audio code-paths, 
the rest is just a question of how complex processing tasks you can do 
on a given hardware (... and for once, just buying more hardware 
can solve problems).

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
