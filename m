From: Richard Cochran <cochran@cs.umass.edu>
Subject: Re: documentation - yeah right!
Date: Wed, 21 May 2003 11:59:21 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030521115921.B793@loki.cs.umass.edu>
References: <20030521104349.A793@loki.cs.umass.edu> <200305211518.h4LFI2jE027163@mail.cs.umass.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200305211518.h4LFI2jE027163@mail.cs.umass.edu>; from paul@linuxaudiosystems.com on Wed, May 21, 2003 at 11:24:35AM -0400
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

On Wed, May 21, 2003 at 11:24:35AM -0400, Paul Davis wrote:
> >it only to be "more complex". In contrast, the OSS modules work with
> >a simple 'insmod' command. In fairness, I expect this problem to go
> >away with kernel 2.6, now that Alsa is part of the kernel.
> 
> in fairness, that whole paragraph was unfair for exactly that reason.

Unfair, perhaps, yet true. Getting alsa to work with a 2.4.x kernel
today is not exactly easy.

> the i/o side of things, the OSS API for configuring the parameters is
> inadequate, and moreover, one cannot interpose between the app and the
> driver, requiring lots of things to be put into the kernel that don't
> belong there (format conversion, SR conversion, etc. etc.).
> ALSA doesn't look like read/write/open/close: if you use those calls,
> then everything on the other side of them has to be in the kernel.

I don't agree that OSS conversion would have to be in the kernel. You
could simply pipe all of your audio through sox using simple shell
commands! Clunky, yes, but it would work.

More to the point, I can imagine a user library to provide:

  write_conversion(int fd, //open file descriptor
                   void* buf, //samples to write
                   int buflen, //length of buffer
                   sometype fmtin, //format of buffer
                   sometype fmtout, //desired conversion
                   sometype alg //desired conversion algorithm
                   );

  read_conversion() //you get the idea

Mixing can be done using a fifo. It would not be hard to shadow the
OSS ioctl with similar library routines for apps that need to mix with
other apps (like desktop beeps and so forth). Serious audio apps
probably want exclusive DSP access, anyhow.

> >4. I could not find a design document for the Alsa way. "Architecture"
> >is in the name, but what is the architecture? Is it only apparent in
> >the driver sources? Alsa promises to deliver better audio performance
> >and more functionality, but how will the Alsa architecture provide
> >this?
> 
> it already has provided it. it offers generic ways to do things that
> were simply impossible or at best very tricky with OSS. the plug_hw
> layer in ALSA has no equivalent for OSS, anywhere.

Where is this 'it'. Where can I read the document?

I don't know what "plug_hw" is or what it provides. I would _love_ to
read about it. I would like to know what is impossible with OSS that
is easy with Alsa, specifically.

> >figure the design out later" approach is sometimes needed, but for an
> >ambitious idea like Alsa, with long term goals, it would be good to
> >have some kind of design thought out, and spelled out in black and
> >white.
> 
> actually, many people disagree with this. there were many changes to
> the design of ALSA that occured over the last 2 years and were
> prompted by coming to terms with what the requirements actually were,
> which in turn occured because of new types of audio interfaces
> appearing that challenged the assumptions on which OSS and earlier
> versions of ALSA were built.

Yes, sometimes you need to go back to the drawing board. I cannot say
whether Alsa needs this or not. I do find that "ever adapting" the old
code to new problems eventually finds a limit.

> >It seems to me that the main problem with OSS is the uneven quality of
> >the drivers, not the overall design. OSS would only need better
> >drivers and a user space library like alsa-lib, for rate/format
> >conversion and mixing.
> 
> there is no such library, and the programmer would have to use it
> explicitly (because of the lack of redirection i mentioned above),
> rather than implicitly.

The same may be said of Alsa: every app needs to use it. I have no
problem with this idea. I only wonder what the design of Alsa is.

If we have a good, standard, user library, then everyone will use it!

> its the overall design of OSS that is the problem - the quality of
> the drivers is generally very good.

Really? Why does not i810 offer duplex audio, then?

> > Howto use the ALSA API - Paul Davis has also written a brief explanation.
> > http://www.op.net/~pbd/alsa-audio.html
> 
> this link is not broken. it points to the new location (my ISP changed).

I followed the link to the new location, but I could not locate "Howto
use the ALSA API".

Thanks,

Richard




-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
