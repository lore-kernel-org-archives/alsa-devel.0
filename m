From: Lance Blisters <geoff@hurl.ugcs.caltech.edu>
Subject: Re: 16-channel recording w/ LAYLA, ALSA, JACK, ARDOUR
Date: Fri, 14 Apr 2006 09:19:38 -0700
Message-ID: <20060414161938.GA3997@hurl.ugcs.caltech.edu>
References: <20060412200957.GA4090@hurl.ugcs.caltech.edu> <1144873089.27496.22.camel@mindpipe> <1144878001.27496.33.camel@mindpipe> <20060413031705.GA9160@hurl.ugcs.caltech.edu> <1144898970.10666.139.camel@localhost.localdomain> <20060414082632.GA21247@hurl.ugcs.caltech.edu> <Pine.LNX.4.64.0604141743180.5335@denise.shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604141743180.5335@denise.shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> >I also discovered that during testing the LAYLA would get into
> >bad states where even simple access no longer worked, and would
> >have to reboot to get it working.
> 
> Hrm :-/    More details ?

Unfortunately not much at hand.  It was a long, late night in 
which I was trying many permutations of .asoundconf definitions 
and JACK arguments.  When I reached a dead end, I would undo my
changes back to a stable point.  Several times, I would try to
run JACK with the simplest, 2-out direct hw acess config which
had always worked.  On these times, it would fail.  Restarting
the ALSA init script, the LAYLA driver would not load (didn't 
look deep into it, but wasn't listed under /proc/asound/) and 
trying cardctl eject/insert to reload the card and driver would 
hang - at least once, it hung my whole system including mouse 
input and keyboard input and I had to force a hard reboot.  
After a hard or soft reboot, card would come back, and the 
simplest config would work again.

This is using one of the recent CCRMA lowlat kernels on FC4.  I'm 
at my day job now and can't pull up further info but if you have
specific questions I can look into it (might not be till next
weekend, as i'm scrambling with music gigs, day job, travel, and
trying to get the ALSA/JACK/LAYLA setup resolved before a
big public event at a Texas festival next week).

  -geoff



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
