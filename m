From: Hannu Savolainen <hannu@opensound.com>
Subject: Implementing ALSA compatibility in OSS
Date: Mon, 15 Nov 2004 12:38:25 +0200 (EET)
Message-ID: <Pine.LNX.4.58.0411151141220.9261@zeus.compusonic.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
List-Id: alsa-devel@alsa-project.org

Hi folks!

We are considering making our OSS software compatible with ALSA. However
there are some serious problems. Maybe somebody on this list could give us
some initial help.

Our initial plan was to implement a version of libasound.so that
implements the required functionality in OSS way. However the problem is
that there are more than 1500 snd_* functions exported by libasound.so
(of alsa-lib-1.0.7rc2). How many of them are actually needed and how many
of them are just helpers used internally by the library.

After checking about 10 or 20 different applications we have found about
220 different routines that have been used by them. In addition there
are 90 routines used by amixer/alsamixer we have decided to leave
unimplemented. Each new program we try adds about 10 to 20 new routines to
the set.

There are about 1200 calls we have not "seen" yet. At this rate we will
need to try at least 60 to 120 programs before we know how many ALSA
routines need to be implemented for good ALSA compatibility. However
it looks like we are running out of programs. Many apps on the applications
list (http://www.alsa-project.org/applications.php) seem to have been
updated last tame in 2002 and they don't work with ALSA 1.0.x any more. Is
this list up to date or do we have just looked at a wrong place.

Is there any other official documentation for the pcm and mixer
interfaces in addition to the DOXYGEN stuff? It's mostly just a function
prototype list and not very helpfull.

Btw, the "Howto use the ALSA API" document
(http://equalarea.com/paul/alsa-audio.html) contains three sample programs
for audio but they are bit out of date. The
snd_pcm_hw_params_set_rate_near() call seems to use some older parameter
passing convention and they don't work with ALSA 1.0.x. Maybe somebody
should fix them.

Is the ALSA library API frozen now or should we wait until the 2.0
version to avoid doing redundant work?

Another alternative is making OSS compatible with the ALSA's device driver
interface /dec/snd/*. This would be the most natural alternative. Is there
any documentation written for it (nothing seems to be available in the net)?


Third alternative might be improving the OSS plugin for Jack. After
browsing the ALSA web site it looks like many pages recommend using Jack
instead of the ALSA library API. However are there any reasons to
implement a new version of libasound.so instead of improving the Jack
plugin?


Anyway we will include a mimimal "Simple ALSA" (SALSA) library in the next
OSS version (in few days) that permits running selected ALSA applications
(mainly esd, xmms and alsaplayer). This is needed because many Linux
distributions have compiled them with OSS support disabled. The first
version of this library implements about 20 or 30 ALSA library routines.
In addtion there are about 200 "stub" routines required to make the loader
happy. The remaining 1300 calls don't have even stubs yet so we do not
claim having full ALSA support yet.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
