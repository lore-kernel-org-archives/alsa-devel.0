From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: documentation - yeah right!
Date: Wed, 21 May 2003 13:49:08 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19IXbm-00082w-00@sc8-sf-list1.sourceforge.net>
References: <20030521131643.A24752@loki.cs.umass.edu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 21 May 2003 13:16:43 EDT."
             <20030521131643.A24752@loki.cs.umass.edu>
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

>One interest of mine is real-time automatic accompaniement by
>computer. I am very interested in low latency for this purpose. I
>cannot imagine that a generic mixing library would reduce latency over
>using a dedicated write to a dsp device! Thus I favor simple access to
>the dsp hardware over using any conversion layers.

with all due respect, i don't think you understand what causes
latency. it has much less to do with "code speed" and much more to do
with "code design".

>If you want generic mixing, then you must sacrifice latency. The most
>efficient mixer can be achieved if the app handles the channels
>itself.

you are seem to be using two different definitions of mixing: you
originally talked about using FIFOs in the context of multi-app
mixing, now you appear to be talking about mixing within an
application.

obviously, an app that does its own mixing should do its own
mixing. this is a totally different problem from how to get N apps to
route their output to a given audio interface.

>Also, regarding latency, can someone point to any benchmarks/studies
>contrasting OSS drivers with the corresponding Alsa drivers?

there is no significant difference if the drivers are both written
correctly. thats again because latency isn't about code but the
parameters the device is set up with. 

--p


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
