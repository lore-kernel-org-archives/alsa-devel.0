From: Philip Thiem <ptt@umr.edu>
Subject: Opl3 Yamaha7xx questions
Date: Sun, 06 Oct 2002 23:25:13 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <9030000.1033964713@werg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

I've been running up again the FM synethesis wall with my aopen card and 
conflicting information, and finally decided to post to the dev group.

>From some skimming of technical documentation for ymf754.  It looks like 
the ymf7xx family has an opl3 capability on the chip, once the nessacary 
information is given to the card through a mapped pci configuration 
register.  Is this correct, so that the card is opl3 compatible once the 
ISA legacy device is told where to "listen" for fm commands?

This all stems from my odessy trying to get fm synth to work on the
YMF744B.  I keep getting the feeling I'm overlooking something simple.  So
if anyone could offer advice or a plan of attack it would be appreciated. 
I've
included a link to copy of my last email with all the gathered information. 
The primary things that have changed is adding this line to my modules.conf
   options snd-ymfpci snd_mpu_port=0x330 snd_fm_port=0x388
I don't think much of the other stuff has changed, but could fetch any 
required information.  Also I don't seem to have any mixer control for a 
synth or fm device.  I have been running a compile of cvs which I checked 
out originally around late-august, tried updating the tree about week 
around but I ran into compiles problems.
Here's that link:
   http://www.icequake.net/~witwerg/ymfpci.txt
Once I get the modules compiled, I wanted to try cleaning out what I have, 
and
reconfiguring with debugging options turned on.

Thankyou
Philip Thiem

GPG Pub Key Archived at wwwkeys.us.pgp.net
Isn't it obvious lumberjacks love traffic lights?




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
