From: Zenaan Harkness <zen@getsystems.com>
Subject: Syncing rme9652 with yamaha 01v
Date: 10 Oct 2002 20:40:14 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1034242814.492.83.camel@zen8100a>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I want to know how to set the sync options in the rme9652 (the manual
says it "can be configured to use the following clock sources: external
input signal (AutoSync), internal clock (Master), or external word clock
signal (Wordclock).

I think the first is the one I want - the 01v has an adapter card that
provides two-only ADAT interfaces - one input, one output, which gives
me 8 tracks each way between the 01v and the rme.

My longer-term goal is to record something into ardour (via jackd). I
can run jackd and ardour, but first I need to be able to play just a wav
file through the desk (as a simple test).

The main problem is sync error - the desk has two options - auto, and
external (ADAT) - choosing either results in ongoing sync pops and
dropouts, etc.

Should aconnectgui help me?

If a new app is needed, I am happy to start writing one (I would write
it in C++/GTKmm) - it's a bit hard to work on anything (eg. Ardour,
mixer app) when I can't actually get the devices talking properly -
well, no fun anyway.

TIA
zen


-- 
Mr Zenaan Harkness, Manager, VIDC
Phone: +678 25 151  Fax: +678 25 178  Mobile: +678 45 179
Please respect the confidentiality of this email.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
