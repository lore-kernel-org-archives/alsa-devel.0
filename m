From: Anthony <avan@uwm.edu>
Subject: ice1712 noise
Date: Sat, 31 Jan 2004 00:09:28 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040131060928.GA27876@ice_nine.wi.rr.com>
Reply-To: avan@uwm.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi, I've been hearing for some weeks now a very high
frequency, quiet crackling distortion when using my
delta44 on playback. This is with driver versions
0.9.8 and 1.0.2.

Symptoms:
* It only occurs on playback.
* It is not always present, but once it manifests
  it is consistent.
* I've ruled out external gear by swapping everything
* It cannot be recorded...i.e. if i use jack capture
  while it is happening, and playback on my other
  card I do not hear it
* I have been able to reproduce it with alsaplayer
  using the hardware layer (so not a jack problem).
* shutting down alsa apps and restarting the drivers
  fixes the problem until it reoccurs. It can take
  a long to to resurface.
* Of course, there is no way for me to rule out the
  card itself as being the problem.
* Other than driver changes, my system has been
  a rather stable 2.4.21 kernel.

I wonder if there was significant changes to the driver
that someone might suggest an earlier driver version to
try. TIA.

--ant


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
