From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Sampling PCM data inside driver for DC offset
 correction
Date: Fri, 10 Feb 2006 09:09:08 +0100
Message-ID: <20060210080908.GA7698@ifiu25.informatik.uni-halle.de>
References: <200602100003.k1A03o7Q002863@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200602100003.k1A03o7Q002863@auster.physics.adelaide.edu.au>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jonathan Woithe wrote:
> I am pondering the possibility of adding a DC level correction to ALSA (or
> at least the hda/ALC260 driver).  The ALC260 (among other Realtek codecs)
> suffers from an appreciable DC offset which makes metering somewhat
> confusing.  The problem is that the actual value of the DC offset depends on
> the chip, so a static value programmed into the driver isn't going to work.
> 
> What I was thinking of was to grab a short sample of PCM data during driver
> setup and using this to deduce the nominal DC offset.  This would then be
> applied to outgoing capture data, probably as it's copied to userspace.
> 
> So the questions are:
> 
>  1) does this kind of thing belong in the ALSA driver,

No.  This is something that could be useful for any device.

> or is it something for ALSA lib?

Yes.  This is what the plugin mechanism was designed for.

> Using the plug layer isn't an option since I want the DC correction to
> be active for jack, which uses hw for (AFAIK) performance reasons.

"hw" is just the default name; jack supports plugins just fine.  And it
probably would make sense to use a Jack client for DC level correction.

>  2) if a kernel solution is appropriate, how does one go about capturing
>     a single short buffer of samples within the kernel driver itself?

The intel8x0 driver does something like this to detect the actual clock
rate.

>  3) any other suggestions as to how best to effect such a correction?

IMNSHO Realtek codecs are junk and do not deserve to have their
crappiness hidden by the driver.


Regards,
Clemens


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
