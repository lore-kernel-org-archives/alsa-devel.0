From: Ken McMillan <mcmillan@cadence.com>
Subject: Re: Some problems with 0.9beta11 drivers
Date: Sun, 24 Mar 2002 19:06:54 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0203241858150.9245-100000@mcmillan.cadence.com>
References: <200203250234.VAA24057@renoir.op.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <200203250234.VAA24057@renoir.op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@Op.Net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Oh -- thanks a lot for the quick answer! But then I guess I'll
rephrase the question: Why would I get xruns with "plughw", but not
with "hw"?

The -EPIPE occurs deterministically after 3584 frames (7 fragments)
are processed. I don't seem to get any -EPIPE errors with "hw".

	Thanks -- Ken

On Sun, 24 Mar 2002, Paul Davis wrote:

> >1) The device "pcm.hw:0" seems to work fine, but when I use
> >"pcm.plughw:0", I get "Broken pipe" from snd_pcm_writei. This happens
> >even with stop_threshold set to UINT_MAX (i.e., this shouldn't
> >be caused by underruns). 
> 
> no, setting the stop threshold to this value just prevents the driver
> from stopping the device when an xrun happens. it doesn't stop the
> reporting of xruns via -EPIPE.
> 
> >Finally, an API question: if I set stop_threshold to UINT_MAX, can I
> >still find out after stoping the device if there have been any
> >underruns?  Or do I need to monitor for this during the run?
> 
> see above.
> 
> --p
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
