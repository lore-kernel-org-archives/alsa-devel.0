From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: documentation - yeah right!
Date: Wed, 21 May 2003 13:03:54 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19IWu2-0006NQ-00@sc8-sf-list1.sourceforge.net>
References: <20030521115921.B793@loki.cs.umass.edu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 21 May 2003 11:59:21 EDT."
             <20030521115921.B793@loki.cs.umass.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Richard Cochran <cochran@cs.umass.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Unfair, perhaps, yet true. Getting alsa to work with a 2.4.x kernel
>today is not exactly easy.

would you like the two people who work on ALSA to write documentation,
or to work on this aspect of things?

>I don't agree that OSS conversion would have to be in the kernel. You
>could simply pipe all of your audio through sox using simple shell
>commands! Clunky, yes, but it would work.

clunky? i thought you were interested in serious audio programming!

>More to the point, I can imagine a user library to provide:
>
>  write_conversion(int fd, //open file descriptor
>                   void* buf, //samples to write
>                   int buflen, //length of buffer
>                   sometype fmtin, //format of buffer
>                   sometype fmtout, //desired conversion
>                   sometype alg //desired conversion algorithm
>                   );
>
>  read_conversion() //you get the idea

i don't think you don't get the point. this means that you are now
required to use these calls, rather than write() and read(), unless
you first query the device to see what it can do (for example, my
favorite interfaces support *only* 24-in-32-bit non-interleaved
samples. why should you have to know this? why not just write the same
code regardless of what the hardware can do? thats what ALSA allows
for. 

also, you seemed to like the idea of using read and write, and now
you're already moving away from it. where you'll end up with this
approach is probably going to be a lot like snd_pcm_read() and
snd_pcm_write() (although be sure to consider how to handle
interleaved and non-interleaved samples, writing to just one channel, etc).

>Mixing can be done using a fifo. 

no disrespect intended, but you are obviously new to audio
programming. FIFO's hold 5kB of data, which for a 26 channel interface
using 32 bit samples is about 0.5msecs worth of audio. even my
carefully tuned system could not possibly use such a model.

>				  It would not be hard to shadow the
>OSS ioctl with similar library routines for apps that need to mix with

ah, shadowing again. so you end up with snd_pcm_ioctl() ... but what
ioctl calls are there? why should you even care? you have data to
write, you should write it, and let someone/something else care about
the low level details.

>other apps (like desktop beeps and so forth). Serious audio apps
>probably want exclusive DSP access, anyhow.

see http://jackit.sf.net/apps. these are all serious audio apps and
when they use JACK, none of them even know whether there a real audio
interface involved. you can run any number of them at once (within
system-imposed limits).

>> it already has provided it. it offers generic ways to do things that
>> were simply impossible or at best very tricky with OSS. the plug_hw
>> layer in ALSA has no equivalent for OSS, anywhere.
>
>Where is this 'it'. Where can I read the document?

"it" is ALSA. and there is no such document.

>Yes, sometimes you need to go back to the drawing board. I cannot say
>whether Alsa needs this or not. I do find that "ever adapting" the old
>code to new problems eventually finds a limit.

precisely, and thats OSS problem, not ALSA's. ALSA has been
significantly redesigned twice during its development, with much more
change than OSS has seen in its entire life. is that a good feature of
OSS? perhaps, but for most of us, we'd prefer useful functionality
from a capable API, even if we've had to wait for a couple of years to
get it.

>If we have a good, standard, user library, then everyone will use it!

not necessarily. none of my audio apps use ALSA at all. they all route
via JACK ....

>> its the overall design of OSS that is the problem - the quality of
>> the drivers is generally very good.
>
>Really? Why does not i810 offer duplex audio, then?

i said the OSS drivers were generally very good.

>> > Howto use the ALSA API - Paul Davis has also written a brief explanation.
>> > http://www.op.net/~pbd/alsa-audio.html
>> 
>> this link is not broken. it points to the new location (my ISP changed).
>
>I followed the link to the new location, but I could not locate "Howto
>use the ALSA API". 

your browser should have taken you there. unfortunately, there was a
bug in the script that converted all my old HTML documents to the
redirect docs, and i no longer can access files at www.op.net, so the
final link that appears to go to the document doesn't go directly there.

if you did go there (http://equalarea.com/paul/alsa-audio.html), then
we i guess disagree on what a "brief explanation" is.

--p



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
