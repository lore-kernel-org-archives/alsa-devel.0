From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Sampling PCM data inside driver for DC offset correction
Date: Fri, 10 Feb 2006 10:33:50 +1030 (CST)
Message-ID: <200602100003.k1A03o7Q002863@auster.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi all

I am pondering the possibility of adding a DC level correction to ALSA (or
at least the hda/ALC260 driver).  The ALC260 (among other Realtek codecs)
suffers from an appreciable DC offset which makes metering somewhat
confusing.  The problem is that the actual value of the DC offset depends on
the chip, so a static value programmed into the driver isn't going to work.

What I was thinking of was to grab a short sample of PCM data during driver
setup and using this to deduce the nominal DC offset.  This would then be
applied to outgoing capture data, probably as it's copied to userspace.

So the questions are:

 1) does this kind of thing belong in the ALSA driver, or is it something
    for ALSA lib?  Using the plug layer isn't an option since I want the DC
    correction to be active for jack, which uses hw for (AFAIK) performance
    reasons.

 2) if a kernel solution is appropriate, how does one go about capturing
    a single short buffer of samples within the kernel driver itself?

 3) any other suggestions as to how best to effect such a correction?

Regards
  jonathan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
