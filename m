From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: start_threshold having no effect
Date: Mon, 20 Oct 2003 18:23:26 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310202223.h9KMNQlC022039@oud.linuxaudiosystems.com>
References: <20031020173030.GC28408@via.ecp.fr>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 20 Oct 2003 19:30:30 +0200."
             <20031020173030.GC28408@via.ecp.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Johan Bilien <jobi@via.ecp.fr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>My second idea was to have a rather big hw buffer (500ms), and then set
>the start_threshold to a low value (32 frames for instance). But whatever
>my parameters were, I always got a playout delay of about the hw buffer
>size.

the output latency is always roughly the size of the hardware
buffer. there is no way to avoid this. the best you could ever do
would be one period, where there are two periods per buffer (i.e half
the buffer size). when i say "the best you could do", the truth is
that you probably can't do it. the very first sample you deliver to
the hardware will have a delay of 1 period, each subsequent sample has
a steadily increasing delay all the way up to the last sample, which
is delayed by the length of the entire hardware buffer (2
periods). this assumes that delivery is basically instaneous:
obviously, if you take time to deliver it, the delay drops, but the
total delay (from when you could have written to when the sound is
audible) is the same.

i don't know what you're doing, but you might to investigate JACK,
which does precisely what you're hoping for, supports the lowest
latencies of any supported hardware (with an appropriate kernel), but
also bundles it all up in an easy to use API. jackit.sf.net. 
if nothing else, you can study JACK's ALSA code to see how it does
it. its not simple.

--p


-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
