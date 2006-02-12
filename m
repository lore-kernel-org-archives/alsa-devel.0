From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Sampling PCM data inside driver for DC offset
Date: Mon, 13 Feb 2006 09:54:15 +1030 (CST)
Message-ID: <200602122324.k1CNOFbv012626@auster.physics.adelaide.edu.au>
References: <20060210080908.GA7698@ifiu25.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060210080908.GA7698@ifiu25.informatik.uni-halle.de> from "Clemens Ladisch" at Feb 10, 2006 09:09:08 AM
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
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > I am pondering the possibility of adding a DC level correction to ALSA (or
> > at least the hda/ALC260 driver).  The ALC260 (among other Realtek codecs)
> > suffers from an appreciable DC offset which makes metering somewhat
> > confusing. ...
> >
> >  1) does this kind of thing belong in the ALSA driver,
> 
> No.  This is something that could be useful for any device.
>
> > or is it something for ALSA lib?
> 
> Yes.  This is what the plugin mechanism was designed for.

No problem.

> > Using the plug layer isn't an option since I want the DC correction to
> > be active for jack, which uses hw for (AFAIK) performance reasons.
> 
> "hw" is just the default name; jack supports plugins just fine.  And it
> probably would make sense to use a Jack client for DC level correction.

Ok.  At some point in the past I seem to recall seeing a jack message when
the plug layer was (probably) in use suggesting the direct hardware access
for performance reasons.  I can't recall the precise situation though and it
was some time ago, so it could well be a moot point these days.

> >  2) if a kernel solution is appropriate, how does one go about capturing
> >     a single short buffer of samples within the kernel driver itself?
> 
> The intel8x0 driver does something like this to detect the actual clock
> rate.

Thanks, I'll check this out for reference/interest.

> >  3) any other suggestions as to how best to effect such a correction?
> 
> IMNSHO Realtek codecs are junk and do not deserve to have their
> crappiness hidden by the driver.

That's a fair comment I think, but sometimes it's all you've got and within
limits they can produce usable results.

Regards
  jonathan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
