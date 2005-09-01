From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: hda-intel/ALC260: mixer control issues
Date: Fri, 2 Sep 2005 09:05:13 +0930 (CST)
Message-ID: <200509012335.j81NZEWq023045@auster.physics.adelaide.edu.au>
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

I am currently trying to get ALSA working correctly on a laptop equipped
with an ALC260 hda chip (Fujitsu S7020).  It seems to me that the converters
themselves are working but the mixer controls are slightly amiss.  Playing
something with aplay sends something to the internal speakers, but only
if the control labelled "headphone" is turned up.  No signal is sent to
the "headphone/line out" jack even if every single mixer control is
set to its maximum setting.

There is also a "PCM" control which sometimes affects the PCM output level
(but I haven't been able to work out the circumstances surrounding the
different behaviour yet).  Curiously it's not mutable whereas every other
control is.

On the input side it seems that no signal gets to the ADC from the
mic/line-in jack regardless of what is set as the capture source.  Data is
captured though, suggesting a mixer routing issue again.  The signal which
is captured is noisy, although I haven't yet determined exactly what it 
is - it's clearly unrelated to what's presented at the input jack though.

This is with ALSA as present in the 2.6.13 kernel release (making it 1.0.9
or there abouts I think).  I will try the 1.0.10 release candidates since
there seems to have been some movement in the hda driver since 1.0.9, but
if anyone has other ideas I'm most interested to hear them.

Could it be a case that this laptop maps the ALC260 resources in a strange
way?  If this is true, I'm guessing the first port of call would be the
port/address numbers of the controls defined in hda/patches-realtek.c.

Thanks and regards
  jonathan


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
