From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Tools to help install alsa.
Date: Mon, 06 Oct 2003 19:14:10 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F81B0F2.1040600@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

I have been helping a few people on #alsa on freenode.net.
Some points to note: -
1) It seems that alsa does not work when compiled into the kernel, but 
does work as modules.
2) For alsa to work in kernel 2.6, the first item in the OSS menu has to 
be set to M, otherwise module soundcore does not seem to exist. (This is 
unconfirmed, so might just be user error)
3) It would be nice if there was a test tool.
This test tool would test for: -
a) See if the user has loaded the kernel modules, so that a "card" 
exists in /proc/asound.
b) Test the mixer interface is functioning.
c) Display alsa-driver, and alsa-lib version numbers.
d) check access writes to /dev/snd/* are valid from the currently logged 
in user.
e) check /etc/modules.conf contains all the correct alias statements, to 
ensure the sound modules will load up again after a reboot.
f) check /etc/modules.conf is not still trying to load OSS drivers.
g) Make a simple test, by playing some white noise out of each speaker 
in turn, allowing for up to 6 speakers. Let the test go in a loop, so 
that the user can adjust mixer settings until they hear sound.
h) Provide some test so that alsa-lib can detect if interrupts are 
actually reaching the sound card or not. Some bugs in ACPI might mean 
that interrupts are not forwarded correctly.

After these tests, it could produce a nice simple message, telling the 
user what to do next to fix it.

Cheers
James



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
