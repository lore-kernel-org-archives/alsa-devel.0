From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: documentation - yeah right!
Date: Wed, 21 May 2003 11:24:35 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19IVLv-00008b-00@sc8-sf-list1.sourceforge.net>
References: <20030521104349.A793@loki.cs.umass.edu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 21 May 2003 10:43:49 EDT."
             <20030521104349.A793@loki.cs.umass.edu>
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

>I must agree with the sentiment of the original poster. Even if you
>document every last API function, you still have not explained the
>API. 

Nobody disagress with the sentiment of the original poster. At least a
half-dozen to a dozen people have wandered onto this list and said
they would write documentation. It hasn't happened. Why? Its not
because its considered to be useless. It hasn't happened because
nobody has the time or inclination to write it. So far. Thats
all. There is no opposition to higher level documentation, only a lack
of time or motivation.

>it only to be "more complex". In contrast, the OSS modules work with
>a simple 'insmod' command. In fairness, I expect this problem to go
>away with kernel 2.6, now that Alsa is part of the kernel.

in fairness, that whole paragraph was unfair for exactly that reason.

>3. The Alsa API seems overly complex. OSS has a pretty straightforward
>interface, like other drivers, using open, read, write, and mmap. All
>things being equal, I aways prefer the simpler way.

as i was just writing to the guys from 4Front (who get irritated by my
constant complaints about OSS), while OSS may have a simple API for
the i/o side of things, the OSS API for configuring the parameters is
inadequate, and moreover, one cannot interpose between the app and the
driver, requiring lots of things to be put into the kernel that don't
belong there (format conversion, SR conversion, etc. etc.). that's why
ALSA doesn't look like read/write/open/close: if you use those calls,
then everything on the other side of them has to be in the kernel.

>4. I could not find a design document for the Alsa way. "Architecture"
>is in the name, but what is the architecture? Is it only apparent in
>the driver sources? Alsa promises to deliver better audio performance
>and more functionality, but how will the Alsa architecture provide
>this?

it already has provided it. it offers generic ways to do things that
were simply impossible or at best very tricky with OSS. the plug_hw
layer in ALSA has no equivalent for OSS, anywhere.

>5. I've gleaned from the list that the Alsa API is still in a state of
>flux. Am I correct? If so, then this troubles me. The "code first,

no, that's wrong. the API is not 100% frozen, but its definitely in flux.

>figure the design out later" approach is sometimes needed, but for an
>ambitious idea like Alsa, with long term goals, it would be good to
>have some kind of design thought out, and spelled out in black and
>white.

actually, many people disagree with this. there were many changes to
the design of ALSA that occured over the last 2 years and were
prompted by coming to terms with what the requirements actually were,
which in turn occured because of new types of audio interfaces
appearing that challenged the assumptions on which OSS and earlier
versions of ALSA were built.

>It seems to me that the main problem with OSS is the uneven quality of
>the drivers, not the overall design. OSS would only need better
>drivers and a user space library like alsa-lib, for rate/format
>conversion and mixing.

there is no such library, and the programmer would have to use it
explicitly (because of the lack of redirection i mentioned above),
rather than implicitly. its the overall design of OSS that is the
problem - the quality of the drivers is generally very good.

> Howto use the ALSA API - Paul Davis has also written a brief explanation.
> http://www.op.net/~pbd/alsa-audio.html

this link is not broken. it points to the new location (my ISP changed).



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
