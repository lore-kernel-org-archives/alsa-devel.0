From: Arthur Peters <amp@singingwizard.org>
Subject: ALSA + jack + xrun = kernel crash
Date: 16 May 2003 20:54:01 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1053136440.1197.213.camel@newbie.localnet.local>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa dev list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello, I am experiencing a reletivly hard crash (SysRq works but SysRq-B
prints a message saying it will reboot then doesn't). The crash happens
when jackd xruns. I've been reproducing it using "jackd -d alsa" (other
options don't make a difference) then "ladccad". Once the system crashs
the only way to get any responce is with SysRq. Keys don't echo to the
console and I can't switch VTs.

Generally there is no error message or oops that I can see, even when
debug=full is enable in ALSA. Early on I saw a message from jackd to the
tune of "error write 512 somethings to device", but I have not been able
to reproduce it. I am willing to run any tests that might help. I use
journaling filesystems ;-) 

My hardware is:
Dual PIII 1Ghz with 512M RAM on a Tyan MB.
SoundBlaster Live! Value
ATI Radeon 8500 (using the closed-source ATI drivers; version 2.9.8)

My software is:
ALSA drivers 0.9.3a or current CVS
Linux 2.4.20 (vanilla or gentoo patched)
Jack 0.71.2
Current Gentoo with testing packages enabled (~x86)

Thanks.

-Arthur

PS: I have sporadic hard freezes when I use Xv heavily and I had to
lower the AGP rate from 4x to 2x to prevent a crash when my X server
loaded. This is just in case it might be related. It could be my MB I
guess. [shiver]


-- 
Arthur Peters <amp@singingwizard.org>



-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
