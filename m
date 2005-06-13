From: Jeremy White <jwhite@codeweavers.com>
Subject: Re: RFC:  Appropriate device detection for Wine  (more
 advice needed)
Date: Mon, 13 Jun 2005 07:23:56 -0500
Message-ID: <42AD7ADC.8090102@codeweavers.com>
References: <Pine.HPX.4.33n.0506130919470.20036-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0506130919470.20036-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> This is the SPDIF output.
> 
> I don't know what the problem is, especially if the PCM output _does_
> work.  Does your machine actually have an SPDIF output?

No, I don't believe it does; it's a Dell Latitude D600 notebook.

> 
> 
>>So I'd like some advice:  Have I just been utterly
>>unrealistic in trying to scan for all PCM devices
>>on all cards?
> 
> 
> No, you cannot do more.  The user has to decide which device to use.

Yah.  I'm feeling a bit stuck; the Wine regression tests require
that all discovered devices pass a very basic set of tests.

So I've made a change that I think is a Good Thing (TM),
but it doesn't pass the regression tests...

> 
> 
>>Is there some way I can detect that this device is psycho and
>>automatically strip it out?
> 
> 
> There are many reason why a device could be temporarily unavailable,
> so Wine shouldn't try to be too intelligent. :-)

Good point :-/.

Thanks,

Jeremy


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
