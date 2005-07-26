From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA and event notification schemas
Date: Tue, 26 Jul 2005 09:17:24 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507260913110.8285-100000@studcom.urz.uni-halle.de>
References: <0416c7e824e16a44987863eda70d4199@vida-software.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <0416c7e824e16a44987863eda70d4199@vida-software.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alfredo <alfredo@vida-software.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Alfredo wrote:
> Hello, I'm involved in a development project consisting of a
> multimedia/networked component using event driven model in a C++ Linux
> environment (1 thread than manages all the events using an event loop).
>
> The events that the component must handle are:
>
> 1. Sockets events.
>
> 2. Timer events.
>
> 3. Audio events ( event = when the next buffer is filled with audio from
> the user, notify the component. Then the component will transfer the
> audio buffer using a udp socket to another distributed component).
>
> 4. Key press and release events (Push To Talk key)
>
> What is the best way to handle all this events in a Linux environment?

poll()

> I have found that libevent is a very interesting library:
> http://www.monkey.org/~provos/libevent/
>
> "The libevent API provides a mechanism to execute a callback function
> when a specific event occurs on a file descriptor or after a timeout has
> been reached".
>
> This resolves the sockets and timer events. I'm not sure if this
> approach works well with ALSA (for audio events).

The above page says that libevent supports poll().

> Another question: Does ALSA support AMR or GSM codecs?

There is no such built-in codec.


HTH
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
