From: "thewade" <pdman@aproximation.org>
Subject: HDSP-midi, jack and pd
Date: Sun, 3 Oct 2004 19:12:27 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410040112.i941CR6Q020300@sanctuary.aproximation.org>
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

Hello,

I still havent gotten hdspmixer working, but I imagine that the ball
is rolling alread so Im trying to get other things working. For
example:

Ive got jack running and I start pd with, among other flags, 
-mididev 1,2,3 but I cannot see the midi device. I run pd with 
-listdev to see if it can see the mididevices but I get that jack
device listing isint implemented yet.

My question is even thoug Im running jack with the alsa driver, can
I not see midi for some reason? Essentially does use of jackd exclude
use of midi? I dont think so but...

Thanks for the help on all the fronts!
-thewade
p.s. Where do I post problems compiling mingo\'s mm-VP patches?


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
