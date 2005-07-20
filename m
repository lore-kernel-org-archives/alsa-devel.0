From: indigo@bitglue.com (Phil Frost)
Subject: Re: sound application needed...
Date: Wed, 20 Jul 2005 07:36:14 -0400
Message-ID: <20050720113614.GA3597@bitglue.com>
References: <e2033af5050720024951dd4324@mail.gmail.com> <e2033af50507200252492b24ab@mail.gmail.com> <e2033af505072003082d113097@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <e2033af505072003082d113097@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kaushik Kumar <kaukum@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 20, 2005 at 08:08:18PM +1000, Kaushik Kumar wrote:
> I need a simple sound application to test my sound driver which does
> *not* use the  alsa user lib API.

You can cat files to /dev/dsp, like so:

  cat /proc/kcore > /dev/dsp

You can also read from it, then play it again:

  cat /dev/dsp > tmp; cat tmp > /dev/dsp  # hit ^C to stop recording


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
