From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] hda: ALC260 test model implementation
Date: Tue, 7 Feb 2006 10:10:02 +1030 (CST)
Message-ID: <200602062340.k16Ne2En016500@auster.physics.adelaide.edu.au>
References: <1139268392.2041.10.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1139268392.2041.10.camel@mindpipe> from "Lee Revell" at Feb 06, 2006 06:26:30 PM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > I guess this is why Realtek recommend using drivers provided by the
> > card/laptop manufacturer rather than the generic drivers - they have
> > no control over what gets connected to what.
> 
> IIRC the spec requires that this info be available from the BIOS, but
> the problem is many vendors don't set it up correctly, as they can fall
> back to vendor supplied drivers.

True, and the info in /proc/asound/card0/codec#0 is reasonably complete on
our laptop at least - so there is hope.  However, there are still some
oddities: for example, some pins with input capability aren't flagged as
such and jacks are reported as present (right down to having a location) and
yet they are nowhere to be seen.  I think part of this latter point is that
allowance is made for the docking station, but in reality just blindly using
all these "jacks" will just fill the mixer with controls which most users
could never use.  Hopefully things like this info will stabilise in time
and help us keep the number of distinct models low.

Regards
  jonathan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
