From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: smix plugin available?
Date: Wed, 27 Nov 2002 08:42:56 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18H2PQ-0005AZ-00@sc8-sf-list1.sourceforge.net>
References: <Pine.LNX.4.33.0211270949140.532-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 27 Nov 2002 10:29:28 +0100."
             <Pine.LNX.4.33.0211270949140.532-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, Florian Bomers <Florian.Bomers@sun.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Ok, it's only simple example, that there are more solutions than Paul 
>suggests. I fully agree, that the callback model is suitable for the 
>perfect synchronization among more applications. 

Let's be totally clear about this. its not just that the callback
model is suitable - the mserver model will actually not work for
sample sync between applications. I have always been sure that the
mserver model will work well as a replacement for things like esd and
artsd. if that's all that we needed, i would never have started work
on jack but would have put my work into the mserver model.

However, for the class of users i am interested in, the mserver model
isn't adequate, and thats why jack exists.

>						  Also, imagine that
>mserver is not using a soundcard as output device, but jackd. So, 
>applications using r/w can use benefits of jackd

precisely. this is one the main reasons i'd like to see the mserver
stuff working.

>In my brain, there is also totaly different solution with the zero context 
>switching overhead - sharing the soundcard DMA buffer among more 
>applications. 

i have been thinking about this from a different perspective
recently. i recently modified ardour's internals so that the total
data flow for an audio interface looks like:

    hardware buffer 
        -> JACK ALSA driver output port buffer 
               -> ardour output port buffer
                    -> hardware buffer

it keeps occuring to me that there is no technical reason why we have
the two intermediate copies. it would be amazing to find a way to
export the mmap'ed hardware buffer up into user space as shared
memory, tell JACK to use this for the port buffers of the ALSA jack
client, and then we can skip the copy. JACK will need some minor
modifications to its internals to permit just a single step, but i can
see how to do that. without that fix, it would still be better:

    hardware buffer == JACK ALSA driver output port buffer
       -> ardour output port buffer
            -> JACK ALSA driver input port buffer == hardware buffer

i see this as more promising than the approach i think you are
thinking of. you can't avoid the context switching - they *have* to
happen so that the apps can run!! the question is *when* does it
happen ... in JACK, they are initiated in a chain when the interface
interrupts us. in the mserver model and/or the shared mmap'ed buffer
approach, they just have to happen sometime between interrupts
(otherwise the buffers are not handled in time). so there is no
avoiding them, its just a matter of when they happen. the point of
JACK's design is to force sample sync and to minimize latency - always
generating and processing audio as close to when it is handled by the
hardware as possible (hence the default 2 period setting). a model
that allows the context switching to occur "sometime" between
interrupts is more relaxed, but loses sample sync and slightly
increases (some kinds of) latency. that doesn't mean i think its a
stupid system, just one that lacks certain properties.

however, i do think that finding a kernel mechanism that would allow
the mmap'ed buffer to be used the way that shared memory can be used
is potentially extremely useful. even though data copying on modern
machines doesn't consume much of the cycles burnt by almost any audio
software, its still a cost that it would nice to reduce.

--p


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
