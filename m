From: Paul Davis <pbd@op.net>
Subject: Re: Procedures in coding MIDI player
Date: Thu, 09 May 2002 20:31:50 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205100031.g4A0VI901767@post2.fast.net>
References: <Pine.OSF.4.21.0205101007270.264606-100000@yoyo.its.monash.edu.au>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Fri, 10 May 2002 10:18:58 +1000."
             <Pine.OSF.4.21.0205101007270.264606-100000@yoyo.its.monash.edu.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Victor Yee <pertuan@yoyo.its.monash.edu.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I'm new to the list and ALSA programming.  I am currently writing a
>program for streaming interactive MIDI over the internet.  I would like to
>be able to play the MIDI signals on the receiver side using
>ALSA.  However, I have no idea what procedure to take to play those MIDI
>signals or access the synth.  I have looked at the documentation but there
>seems to be a lack of it for the synth.  I have looked at pMIDI but it
>uses its own routines.  

your question is a little confused, as many related questions
are. lets separate out:

     * delivery of MIDI data to a destination of some kind
     * using a software synth
     * using a host-controlled internal hardware synth
     * using a native MIDI controlled internal hardware synth
     * using an MIDI controlled external synth

these are all quite different issues (though obviously interelated). 

the first point has two basic options:

    * delivery to a raw MIDI port
    * delivery to an ALSA sequencer port

these two use entirely different functions and an entirely different
approach to each other. the sequencer is generally a slightly more
flexible option, but the raw MIDI port is simpler to use.
    
for a software synth, you would need to define the problem more
precisely by telling us which synth.

for host-controlled hardware synths, we would again need to know which
one. however, many of these devices in ALSA make themselves visible
via the sequencer interface.

for native MIDI controlled internal hardware synths, there should be a
corresponding raw MIDI port and/or sequencer port (if you're using the
sequencer) and you just send the data there with no other action at
all.

for external synths, you need to know which raw MIDI port they are
connected to, and deliver the data there (you can use the sequencer,
or use the raw MIDI port directly).

the documentation page at www.alsa-project.org has a link to a HOWTO
that describes basic ALSA sequencer programming and has some very
useful examples.

Let us know when you have more specific questions (and have read the
HOWTO). 

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
