From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: PCM hw mixing with volume
Date: Wed, 10 Mar 2004 09:53:39 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403101453.i2AErdoQ019308@dhin.linuxaudiosystems.com>
References: <1078929621.18054.256.camel@renegade>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 10 Mar 2004 15:40:21 +0100."
             <1078929621.18054.256.camel@renegade>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ove Kaaven <ovek@transgaming.com>
Cc: Giuliano Pochini <pochini@shiny.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>In any case, most of this can all be handled by software. The only stuff
>the hardware really need is the volume, frequency, direction to sound
>source, and any additional effects (such as reverb). Application
>software can deal with the rest.

i can certainly see the utility of such an API. however, i don't think
it should be part of the PCM API. these things don't really relate to
the basic concepts of handing a PCM-encoded stream of audio data to a
device, they represent much higher level concepts. a different API
would allow a much cleaner implementation and less complications for
developers. 

it would also leave the PCM API clean and its implementation free of
things that have no role to play in software that would never use the
hardware support even if it was there (i.e. music applications). 

i don't know what to call it, but perhaps something more like
snd_audio_*() would be more appropriate.

--p


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
