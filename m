From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: design suggestions for minimal-latency full-duplex io?
Date: Mon, 03 Feb 2003 11:12:20 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18fj8y-0005Ba-00@sc8-sf-list1.sourceforge.net>
References: <200302031648.48890.Marcus.Blomenkamp@epost.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 03 Feb 2003 16:48:48 +0100."
             <200302031648.48890.Marcus.Blomenkamp@epost.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Marcus Blomenkamp <Marcus.Blomenkamp@epost.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Is it possible to have both stream pointers working on the same physical 
>buffer? A slightly delayed start of playback should then give a nice IO 
>latency. Are there any other approaches viable? Ideally i'd like to get this 
>working while not depending on userspace scheduling heavily.

you have to depend on userspace scheduling unless you write a kernel module.

>Any suggestions/constraints about the following ideas?
>1. traditional blocking read/write in seperate threads
>2. traditional non-blocking read/write in a single thread
>3. asynchronous SIG_IO triggered read/write handling
>4. mmap'ed buffer for read+write

the JACK code for its alsa_driver shows the way to get the lowest
latency and greatest efficiency that i know of without playing "dirty"
tricks.

it uses mmap access, and sleeps using poll(2) to wait for the audio
interface to be ready. read/write access would not change the latency,
it would be just a little less efficient for large numbers of
channels. the code is rather complex, however. there is a simpler
example in my ALSA primer which has links on the ALSA programmers
documenation page at www.alsa-project.org.

personally, i'd just fire up JACK and use a slight, tiny modification
to the jack_simple_client example to do this. you hardly have to write
any code then.

--p


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
