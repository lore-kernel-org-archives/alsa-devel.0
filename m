From: Paul Davis <paul@linuxaudiosystems.com>
Subject: alsa-lib resamping error
Date: Wed, 22 Jan 2003 12:38:31 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301221738.h0MHcVq22269@linuxaudiosystems.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

if you try to play a 22.05kHz stream on hardware that supports 32kHz
and 44.1kHz but not 22.05kHz, alsa-lib's plughw layer chooses to use
32kHz and resamples. this seems like an error to me: it would be much
better to choose 44.1kHz and do simple integer resampling. that is:
the search for the best rate should first try integer multiples and
divisors of the desired rate, not the "closest" rate.

--p


-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
