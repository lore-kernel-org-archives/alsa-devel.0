From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: documentation - yeah right!
Date: Wed, 21 May 2003 12:44:09 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19IWau-0004iJ-00@sc8-sf-list1.sourceforge.net>
References: <20030521120928.C793@loki.cs.umass.edu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 21 May 2003 12:09:28 EDT."
             <20030521120928.C793@loki.cs.umass.edu>
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

>With a name like "Advanced Linux Sound Architecture", I would expect
>to be able to read about:

why? why do you think it is possible to design a system like ALSA
ahead of time? we didn't even know what was necessary at the
beginning. we still don't entirely know that the API is "complete",
but given that we have some fairly sophisticated apps (Rosegarden,
MusE, Ardour) using it, and a wide range of audio interfaces
supported, there is some reasonable level of confidence that its
right. 

If you had been reading alsa-devel during the period of the initial
development of Ardour and then later JACK, you would have seen that
many architectural decisions in ALSA reflect real-world experience
writing audio applications, rather than guessing at what might be
useful in the absence of such applications.

>1. What is advanced (over OSS) in Alsa?

* kernel-space supports only h/w-level capabilities
* multi-thread safe design
* transparent use of plugin architecture to handle
      format,rate,channel cnt and many other conversions
* support for non-interleaved interfaces
* user-space software mixing (dmix)
* user-space "loopback/snoop" capabilities
* merging multiple cards into a single virtual device
* hiding non-ALSA-drivers behind a consistent
     user-space API (e.g. IEEE1394 drivers, or JACK)
* consistent and generic control API for managing h/w controls
* sufficiently flexible mixer architecture to handle modern
     audio interfaces fully (rather than reducing them to 
     a simplistic device)
* consistent support for multiple instances of the same card
* linked operations of multiple cards

and more.

>2. What is the architecture?
>
>Any pointers (white papers, articles, email postings, anything!) to
>material on these questions would be appreciated.

AFAIK, there is no such material. 


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
