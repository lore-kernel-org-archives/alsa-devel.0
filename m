From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: echoaudio.c, Revision 1.6
Date: Mon, 14 Mar 2005 09:19:28 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503140909500.15356-100000@studcom.urz.uni-halle.de>
References: <20050312123215.0d9e8d94.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <20050312123215.0d9e8d94.pochini@shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Giuliano Pochini wrote:
> I'm a bit confused about the latest changes to pci/echoaudio/echoaudio.c
>
> The CVS interface says: "Use spin_lock_irqsave() instead of spin_lock() in
> places where we could be interrupted by another hardware interrupt that
> could call the rawmidi trigger callback that could try to take the same
> lock."
>
> But in snd_echo_interrupt() we are running in hard irq context, so we know
> irqs are already disabled.

Only the sound card interrupt itself is disabled.  It is architecture-
specific whether other interrupts are disabled.

> Then: "Additionally, remove locking code that is no longer needed now that
> the trigger callback is no longer called recursively from the rawmidi
> "event" handler."
>
> Your patch does not remove anything.

It removed code in some other files.

> It only replaces spin_lock() in pcm_trigger() which is a stupid
> bug of mine, sorry.

I think this wasn't a bug because the trigger callback is already
called with interrupts disabled, AFAICS.  I'm planning to revert most
of these locking changes when I've proven that it's safe.


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
