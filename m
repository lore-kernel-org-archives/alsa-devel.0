From: Paul Davis <pbd@op.net>
Subject: Re: guitar + sblive + ardour + ladspa effects
Date: Mon, 29 Jul 2002 16:53:05 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17ZHUa-0008M7-00@usw-sf-list1.sourceforge.net>
References: <1027973318.10978.62.camel@insanity>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "29 Jul 2002 21:08:35 BST."
             <1027973318.10978.62.camel@insanity>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Bob Ham <node@users.sourceforge.net>
Cc: ALSA Development Mailing List <alsa-devel@lists.sourceforge.net>, Ardour Devel Mailing List <ardour-dev@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>This is what I want to do: guitar into the line input on the live drive,
>that going into ardour, through a few ladspa effects, and out to the
>speakers.  I can't seem to do this.  The only way I seem to be able to
>get the input into ardour is to have it going through the speakers as
>well so that both the input and the ladspa-processed output can be
>heard.  I only want the ladspa-processed output.  Is this possible? 

sure. assuming we're talking stereo:

add 2 routes (*without* diskstreams)
set the inputs to "in 1" and "in 2" respectively (from the mixer window)
set the outputs to "out 1" and "out 2" respectively (from the mixer window)
add the desired plugins to each route
listen ...

before you do all this, however, you need to have set up the line
input as the capture source. that's an sblive specific issue on which
i have no knowledge whatsoever.

you will also probably want to turn down the line-in level, so that
the direct feed is not audible. that is also an sblive issue. 

ALSA has a correctly designed mixer API to reflect the true
capabilities of various mixing hardware, but the vast differences
between audio interfaces and the lack of a standard ("every card must
provide the following mixer controls if it provides any at all") makes
this stuff much harder than it should be. or so it seems from reading
messages to the list.

>"Capture" device sitting in alsamixer?  What difference does the little
>red "Capture" make above the sliders in alsamixer? 

it controls which sources are being used for capture *by the
hardware*. they should be over the relevant sources in alsamixer.

>If it's not possible to this with only the sblive, I have the
>motherboard's "soundcard" as well but how do I get jackd to deal with
>more that one bit of hardware?  

jackd -d alsa -d hw:N

where N is the relevant card number for the motherboard audio
interface.

--p


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
