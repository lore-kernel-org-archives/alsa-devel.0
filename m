From: Richard Cochran <cochran@cs.umass.edu>
Subject: Re: documentation - yeah right!
Date: Wed, 21 May 2003 10:43:49 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030521104349.A793@loki.cs.umass.edu>
References: <PM.9386.1053461408@pmweb11.uk1.bibliotech.net> <XFMail.20030521093456.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <XFMail.20030521093456.pochini@shiny.it>; from pochini@shiny.it on Wed, May 21, 2003 at 09:34:56AM +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, May 21, 2003 at 09:34:56AM +0200, Giuliano Pochini wrote:
>> doxygen is just an excuse to avoid writing documentation and should be
>> banned from all projects. If I want a list of all the damn globals
>> I'll look in the source code thankyou.

I must agree with the sentiment of the original poster. Even if you
document every last API function, you still have not explained the
API. One would need a written (human language, not source code)
document to describe the goals of the architecture and how to use the
API on the large scale. OSS has a short, readable document that does
this.

I am a talented programmer with some (little) free time to spend on
linux audio drivers/apps. I evaluated Alsa and OSS and concluded that
I would avoid Alsa for the following reasons:

1. After two attempts, I could not get the existing Alsa drivers to
work with my own sound cards at all. The installation seems very
complex, even for linux drivers! For example consider the multitude of
sources (five different tarballs to download) and different kernel
modules. When it comes to linux, I don't give up easily. I tried to
install Alsa because I read that Alsa was "more advanced", but I found
it only to be "more complex". In contrast, the OSS modules work with
a simple 'insmod' command. In fairness, I expect this problem to go
away with kernel 2.6, now that Alsa is part of the kernel.

2. The OSS drivers for my cards lacked some features, but reading the
Alsa sources revealed that the Alsa drivers had the same limitations,
and indeed shared the same code (I'm talking about i810_audio and
usb-audio).

3. The Alsa API seems overly complex. OSS has a pretty straightforward
interface, like other drivers, using open, read, write, and mmap. All
things being equal, I aways prefer the simpler way.

4. I could not find a design document for the Alsa way. "Architecture"
is in the name, but what is the architecture? Is it only apparent in
the driver sources? Alsa promises to deliver better audio performance
and more functionality, but how will the Alsa architecture provide
this?

> Hey, ALSA developers are not your slaves. What about to contribute ?
> Use the sources and the list, and while you learn to use the seq
> interface, you write the documentation.

5. I've gleaned from the list that the Alsa API is still in a state of
flux. Am I correct? If so, then this troubles me. The "code first,
figure the design out later" approach is sometimes needed, but for an
ambitious idea like Alsa, with long term goals, it would be good to
have some kind of design thought out, and spelled out in black and
white.

It seems to me that the main problem with OSS is the uneven quality of
the drivers, not the overall design. OSS would only need better
drivers and a user space library like alsa-lib, for rate/format
conversion and mixing.

I don't mean to flame the good work of the Alsa contributors. I follow
the list, and I would like to learn the Alsa way. I am skeptical,
however, and would like to see a discussion of how Alsa delivers what
OSS cannot.

Thanks in advance for your helpful comments...

Richard

PS I looked (again) at the stuff on the Alsa "documents" page, and I
found two broken links:

 Howto use the ALSA API - Paul Davis has also written a brief explanation.
 http://www.op.net/~pbd/alsa-audio.html

 http://www.alsa-project.org/alsa/cvs/alsa-driver/INSTALL

There does not seem to be an "installation guide" available from the
Alsa site.



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
