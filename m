From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: documentation - yeah right!
Date: Wed, 21 May 2003 19:39:37 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305211927060.1480-100000@pnote.perex-int.cz>
References: <20030521131643.A24752@loki.cs.umass.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030521131643.A24752@loki.cs.umass.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Richard Cochran <cochran@cs.umass.edu>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 21 May 2003, Richard Cochran wrote:

> On Wed, May 21, 2003 at 07:52:46PM +0300, Kai Vehmanen wrote:
> > > Mixing can be done using a fifo. It would not be hard to shadow the
> > 
> > Simply does not work nor scale if you want low latency and support
> > multichannel configurations.
> 
> One interest of mine is real-time automatic accompaniement by
> computer. I am very interested in low latency for this purpose. I
> cannot imagine that a generic mixing library would reduce latency over
> using a dedicated write to a dsp device! Thus I favor simple access to
> the dsp hardware over using any conversion layers.
> 
> If you want generic mixing, then you must sacrifice latency. The most

Not really. We use a lock-free algorithm inside the dmix plugin which 
ensures that data from all clients are added independently. The latency
is equal as if you use exclusive access. Sure, there is some computing 
overhead.

> efficient mixer can be achieved if the app handles the channels itself.

Yes, that's right.

> Also, regarding latency, can someone point to any benchmarks/studies
> contrasting OSS drivers with the corresponding Alsa drivers?

If you use mmap, the both drivers will have probably same results.
The latency does not depend on used driver (if your application is 
correctly written) but much more on kernel tunning and scheduler 
behaviour.

Our aim is to describe hardware as close as possible in drivers, but in 
userspace, the alsa-lib covers the hardware differences (if required) or 
application may control all hardware features.

In other words: Do you want to play a stereo stream on some multichannel 
device? Yes, it is possible. Do you want to use all channels together?
Yes, it is possible. Do you want to separate multichannel device to mono 
devices? Yes, it is possible. Do you want to run devices from multiple 
cards in sync? Yes, it is possible (when the hardware clock is shared).

We are trying to be flexible as much as possible. I am afraid, that our
documentation is not great. My opinion is that someone other (than code
developers) should write proper documentation, because we ommit the 
fundamental details, because we think that they are obvious. 
(Un)fortunately, it is free software. We cannot force anyone to do it.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
