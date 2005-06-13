From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: RFC:  Appropriate device detection for Wine  (more
 advice needed)
Date: Mon, 13 Jun 2005 09:24:40 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0506130919470.20036-100000@studcom.urz.uni-halle.de>
References: <42ACF2BF.5050603@codeweavers.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42ACF2BF.5050603@codeweavers.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jeremy White <jwhite@codeweavers.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jeremy White wrote:
> But I still have one device on my laptop;
> card 0, device 4, that simply does not work
> (see details below).
> name: Intel 82801DB-ICH4 - IEC958

This is the SPDIF output.

I don't know what the problem is, especially if the PCM output _does_
work.  Does your machine actually have an SPDIF output?

> So I'd like some advice:  Have I just been utterly
> unrealistic in trying to scan for all PCM devices
> on all cards?

No, you cannot do more.  The user has to decide which device to use.

> Is there some way I can detect that this device is psycho and
> automatically strip it out?

There are many reason why a device could be temporarily unavailable,
so Wine shouldn't try to be too intelligent. :-)


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
