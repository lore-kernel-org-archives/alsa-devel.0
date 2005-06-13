From: Jeremy White <jwhite@codeweavers.com>
Subject: Re: RFC:  Appropriate device detection for Wine  (more
 advice needed)
Date: Mon, 13 Jun 2005 09:00:22 -0500
Message-ID: <42AD9176.10004@codeweavers.com>
References: <Pine.HPX.4.33n.0506130919470.20036-100000@studcom.urz.uni-halle.de>	<42AD7ADC.8090102@codeweavers.com> <s5hpsuqe8p1.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hpsuqe8p1.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> I'd recommend to list up only the card names, and try to use either
> "default:X" or "plughw:X" (the former is preferred, but not available
> in the older version).

Wait; I worry that I misunderstand the use of 'default'.

Is there a thread or FM I should go read to fully understand?

That is, my understanding is that the default key is used
so that an end user just tells his or her sound app
to write to a 'defaults' device, and then Alsa worries
about mapping that to the correct device.

However, in the case of Wine, my fundamental mission
at initialization time is to provide a credible and
useful list of sound devices back to the application,
so the application can pick.  (At the same time, I need
to report which of those choices is the default, and
report that back to the application as well; I try to
do that via the alsa config apis).

But my first misunderstanding was that I thought there
was just one default device, not one that can be
iterated per card.  Does default:X simply get mapped
to one of either 'hw:X' or 'plughw:X' (or whatnot) based
on user preference?

Thanks,

Jeremy


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
