From: Paul Davis <pbd@op.net>
Subject: Re: [Jackit-devel] Multiple cards.
Date: Wed, 12 Jun 2002 09:43:01 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206121341.g5CDf3P19033@post2.fast.net>
References: <3D074B59.6030602@boosthardware.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Wed, 12 Jun 2002 22:23:37 +0900."
             <3D074B59.6030602@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: "jackit-devel@lists.sourceforge.net" <jackit-devel@lists.sourceforge.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Not even if the reason is to allow cueing of a track. I think it may 
>even be possible to allow this to work in sample sync if alsaplayer is 
>the app used to play the file.
>
>Eg1. I could cue the file using my headphones channel on a consumer card 
>and then click a switch in alsaplayer to allow the file to stream 
>through my pro card. As long as the file was paused between switching 
>channels it should retain sample sync because alsaplayer is sample accurate.

this will work already, but not if the 2 cards have different
interleave configurations. you just define a "multi" device, and use
it. either gang a bunch of similar consumer devices (e.g. 16 bit
stereo, interleaved) or use a big enough multichannel card. but not
both, until someone fixes the code (and it will hard to do, because it
messes with some core assumptions that JACK's alsa_driver uses to make
itself efficient).

>Eg2. I could set up three channels in ardour mixer for each alsaplayer 
>gui and then I just fade them in/out depending on what channel I want to 
>hear the file through. This would definitely loose sample sync but could 
>allow for some interesting time effects. Do you fancy the idea of 
>"ardour dub sessions"?

ditto.

--p

_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
