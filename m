From: "thewade" <pdman@aproximation.org>
Subject: Re: Alsa and hdspmixer segfault
Date: Fri, 1 Oct 2004 12:33:54 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410011833.i91IXsMn001748@sanctuary.aproximation.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > Lastly, what is the best way to determine the latency of my pesent
> > kernel?
>
> What is the smallest period size you can use without xruns?

256 is too small, 512 works fine. I cant seem to set the period to
anything between that, proabably because its not a 2^2 value. I tried
360 and 384 but jackd wouldn acecpt those. So just over 10ms I guess...
(512/48000 sec)

What is the typical latency with the mm+VP patch installed?

Thanks again,
-thewade


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
