From: Richard Cochran <cochran@cs.umass.edu>
Subject: Re: documentation - yeah right!
Date: Wed, 21 May 2003 13:16:43 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030521131643.A24752@loki.cs.umass.edu>
References: <20030521115921.B793@loki.cs.umass.edu> <Pine.LNX.4.44.0305211934470.19955-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305211934470.19955-100000@ecabase.localdomain>; from kai.vehmanen@wakkanet.fi on Wed, May 21, 2003 at 07:52:46PM +0300
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

On Wed, May 21, 2003 at 07:52:46PM +0300, Kai Vehmanen wrote:
> > Mixing can be done using a fifo. It would not be hard to shadow the
> 
> Simply does not work nor scale if you want low latency and support
> multichannel configurations.

One interest of mine is real-time automatic accompaniement by
computer. I am very interested in low latency for this purpose. I
cannot imagine that a generic mixing library would reduce latency over
using a dedicated write to a dsp device! Thus I favor simple access to
the dsp hardware over using any conversion layers.

If you want generic mixing, then you must sacrifice latency. The most
efficient mixer can be achieved if the app handles the channels
itself.

Also, regarding latency, can someone point to any benchmarks/studies
contrasting OSS drivers with the corresponding Alsa drivers?

Thanks,
Richard


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
