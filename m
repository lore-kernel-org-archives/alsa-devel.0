From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: time stamp and dmix
Date: Fri, 17 Jun 2005 08:56:46 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0506170853040.24910-100000@studcom.urz.uni-halle.de>
References: <loom.20050617T020400-431@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <loom.20050617T020400-431@post.gmane.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

jw,Lee wrote:
> Clemens Ladisch <clemens <at> ladisch.de> writes:
>
> > jw,Lee wrote:
> > > when I use "plughw:0,0", my app play sound profectly with
> > > various mp3 file. but If I use "plug:dmixer" some mp3 file
> > > play fast.
> >
> > The "plug:" should automatically convert sample rates.  Which
> > application is this?
>
> --> The application is what I'm making now.. :)
>
> exact_rate = snd_pcm_hw_params_set_rate_near(hPlayback, hw_params,
>                  &frequency_near, &dir);

_set_rate_near() might select another frequency (although this
shouldn't happen with the plug plugin).  What is the value of
frequency_near after the call?


Regards,
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
