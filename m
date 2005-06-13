From: Jeremy White <jwhite@codeweavers.com>
Subject: Re: RFC:  Appropriate device detection for Wine  (more
 advice needed)
Date: Mon, 13 Jun 2005 10:01:03 -0500
Message-ID: <42AD9FAF.6050501@codeweavers.com>
References: <Pine.HPX.4.33n.0506130919470.20036-100000@studcom.urz.uni-halle.de>	<42AD7ADC.8090102@codeweavers.com>	<s5hpsuqe8p1.wl@alsa2.suse.de>	<42AD9176.10004@codeweavers.com> <s5hhdg2e3ou.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhdg2e3ou.wl@alsa2.suse.de>
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

> Yes.  It's a new feature introduced since ALSA 1.0.8 (or 7?).
> You can pass the card number to the "default" PCM.
> Also, default:X automatically introduces the dmix for many hardwares
> without multi-playback capability, while plughw doesn't.
> This works unless user redefines the default in his ~/.asoundrc.

Okay, I think I begin to understand, although you're right, the
naming is rather unfortunate.

So it sounds like the right approach is to try default:X,
and if that fails, to fallback to plug:hw:X.

Does that sound rational?

Cheers,

Jeremy


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
