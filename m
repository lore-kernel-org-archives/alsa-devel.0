From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: HDSP 9652 sync problems cause loud noise in Alsa 0.9.6
Date: Tue, 7 Oct 2003 08:26:47 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGGEJIDGAB.mknecht@controlnet.com>
References: <200310071339.h97DdkEw030254@oud>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200310071339.h97DdkEw030254@oud>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> >
> >I agree. It does sound that way, but read the thread please. In my
> >machine's case I am dual boot and in my description I said this does not
> >happen under Windows.
>
> that would suggest that the driver is not setting the clock source
> correctly. sync/lock/nolock is done by the h/w, and if the same config
> works under windows, my guess it that the hardware has not been setup
> under linux the way it is claimed to be.
>
Well, I agree, in the sense that we seem to be stating the obvious.

To the question at hand, how do we solve the problem and get the driver to
set the card up correctly?

Have I not set something up correctly? Is there something I can correct in
my Alsa setup that will fix this?

Or has the driver not correctly comprehended something about the HDSP 9652?

What is strange in my case is that the frequency is actually correct BEFORE
I start playing an mp3, for instance, and then when the mp3 starts playing
the frequency is set incorrectly for a short time, apparently causing the
noise, but it is eventually set back to the right frequency after a while.
In this case the frequency seems to get changed through other settings
before it comes to rest at the right frequency.

In the case of syncing to my 48K AI-3 source it never works, while it will
sync to other ADAT inputs, albeit they are typically at 44.1K.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
