From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Quick question
Date: Tue, 03 Jun 2003 20:38:30 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19NMCj-0006SU-00@sc8-sf-list1.sourceforge.net>
References: <1054663089.20856.56.camel@dave.sipquest.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "03 Jun 2003 13:58:08 EDT."
             <1054663089.20856.56.camel@dave.sipquest.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Stuart <dave@sipquest.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Ah, I think you misunderstand me a little bit.. it's not that I am
>trying to do anything different than usual, it's that I'm having trouble
>with the basics. Specifically, the HOW-TOs that I have found all seem to
>have a different way of writing and reading to/from the hardware buffer.

thats because there are multiple ways to do it.

>I have not, as of yet, been able to find a clear description of the core
>concepts around writing and reading to the device. Also some recommend
>one way, and then another HOWTO says not to do it that way.. it's all
>rather confusing.

if you want something that's not confusing, then JACK is your
friend. it was specifically designed to cut away all the complexity
and force you to write a well-designed application (and yes, its me
who gets to define what well-designed means :)

and no, you don't need to modify anything about your stock RH system
to use JACK. the modifications are only needed if you want low
latency, and such modifications would be needed to get this with just
ALSA anyway. a jack client will run just as well as a native ALSA
(better in some senses) when the jack server is run with equivalent
parameters for the audio hardware.

>For instance, I'm really not sure what size my buffer needs to be, if
>there is a difference between the "hardware buffer" and the buffer in my
>program, How "periods" work into all this, what's the difference between
>hw and plughw, etc. Also each of the examples seems to configure the
>hardware differently, which I find also odd..

there are many ways of doing this too.

>So to sum it up, the problem is not only that I'm new to ALSA, but that
>I'm new to sound programming in general. Is there somewhere I can go to
>learn the basics (at least enough to do capture and playback, beyond
>that I'm not as interested)?

if you're trying to learn sound programming, the last thing you want
to be messing with is a hardware abstraction layer that can handle any
audio h/w you can imagine. do yourself a favor and use jack
instead. you can focus on audio programming rather than how to setup
an audio interface. better yet, your application will talk to other
jack-enabled applications if and when you want to.

--p




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
