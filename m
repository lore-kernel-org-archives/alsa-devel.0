From: Pavel Roskin <proski@gnu.org>
Subject: Fix for mmap_test, better tests needed
Date: Mon, 12 Aug 2002 15:53:51 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0208121541210.14146-100000@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

I was looking for some tests for the sound driver, and the only thing I
found in ALSA CVS is some stuff in alsa-driver/test.  Before I continue my
search for real tests (any pointers will be appreciated!) let me post a
patch that makes mmap_test.c compile and work.

First of all, mmap_test.c should be converted from DOS to UNIX-style line
ends before my patch is applied.

There is no "smpl" file in the alsa-driver/test directory, but we can 
easily generate a sample.  sin() requires libm, hence the makefile change.

The necessary includes have been added to avoid warnings.  Unused 
variables have been removed for the same reason.  If the "smpl" file 
cannot be loaded, a sound of variable frequency is generated.

SNDCTL_DSP_SETPERIOD is undefined (google search gives 0 hits, I wonder 
if this code ever compiled), but SNDCTL_DSP_SETFRAGMENT seems to do 
exactly what we need.  info.periods has been replaced with info.fragsize 
for the same reason.

Now mmap_test compiles without warnings and produces funky sounds.  
Enjoy!

-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
