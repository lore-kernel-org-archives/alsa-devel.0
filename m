From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: status pointer's problem with dmix.
Date: Wed, 17 Sep 2003 19:33:29 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F68A8F9.6010605@superbug.demon.co.uk>
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
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Output from sending stereo sound to the "dmix" device.
bash-2.05b# cat status
state: RUNNING
trigger_time: 1063822024.640173000
tstamp      : 1063822060.456968000
delay       : -1719463
avail       : 1731463
avail_max   : 1731463
-----
hw_ptr      : 1719463
appl_ptr    : 0
bash-2.05b#

Output from sending stereo sound to the "front" device.
bash-2.05b# cat status
state: RUNNING
trigger_time: 1063823309.038609000
tstamp      : 1063823320.869677000
delay       : 14161
avail       : 2223
avail_max   : 3586
-----
hw_ptr      : 567983
appl_ptr    : 582144

As you can see, the "front" device acts correctly, with all the pointers 
acting as they should.
But with "dmix", all the pointers are wrong.
This is particularly problematic for me, as I need a properly 
functioning "delay" value for my application.

This is using alsa from 2.6test5 kernel.

Cheers
James



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
