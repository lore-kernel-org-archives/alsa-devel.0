From: Tim Blechmann <TimBlechmann@gmx.net>
Subject: Re: Hammerfall (hdsp) initialization problem
Date: Sat, 24 Jul 2004 10:05:20 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040724100520.26b4ac8f@laptop>
References: <1090607568.17750.7.camel@modemcable182.55-70-69.mc.videotron.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1090607568.17750.7.camel@modemcable182.55-70-69.mc.videotron.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Actually, sometimes it loads fine and sometimes it doesn't. I noticed
> that the sooner I insert the card (after boot), the more likely the
> module is to load (though it's never 100%). I'm running a 2.6.7 kernel
> (don't know what version of the drivers come with it) with the swsusp2
> patches and preempt enabled. I don't think it changes anything, but I
> have two non-standard config options: PAGE_OFFSET=0xb000000 (support
> for 1G of mem without the 4G overhead) and HZ=100.
that's a known problem with the hdsp driver, a lot of continuous memory
has to be allocated, which can more likely be done on a freshly booted
machine ...
the best solution: keep the cardbus interface plugged into the slot all
the time ... if you start the computer, the memory will be allocated

cheers... tim

-- 
mailto:TimBlechmann@gmx.de    ICQ: 96771783

After one look at this planet any visitor from outer space 
would say "I want to see the manager."
				      William S. Burroughs


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
