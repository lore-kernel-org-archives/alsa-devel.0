From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: [Fwd: usbaudio panic]
Date: Tue, 25 Feb 2003 01:04:17 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E5A4281.6050203@boosthardware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000102080303050708040602"
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

This is a multi-part message in MIME format.
--------------000102080303050708040602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sending on behalf of John

--------------000102080303050708040602
Content-Type: message/rfc822;
 name="usbaudio panic"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="usbaudio panic"

Return-Path: <jsd@monmouth.com>
Received: from www2.webhosting.cx (root@localhost)
	by boosthardware.com (8.11.6/8.11.6) with ESMTP id h1A2Ja618671
	for <pshirkey@boosthardware.com>; Mon, 10 Feb 2003 03:19:37 +0100
X-ClientAddr: 68.37.175.11
Received: from av8n.net (pcp03191463pcs.midltn01.nj.comcast.net [68.37.175.11])
	by www2.webhosting.cx (8.11.6/8.11.6) with SMTP id h1A2JaG18666
	for <pshirkey@boosthardware.com>; Mon, 10 Feb 2003 03:19:36 +0100
Received: (qmail 1563 invoked from network); 10 Feb 2003 02:19:22 -0000
Received: from localhost (HELO monmouth.com) (127.0.0.1)
  by localhost with SMTP; 10 Feb 2003 02:19:22 -0000
Message-ID: <3E470C2A.2080002@monmouth.com>
Date: Sun, 09 Feb 2003 21:19:22 -0500
From: "John S. Denker" <jsd@monmouth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Shirkey <pshirkey@boosthardware.com>
CC: alsa-devel@lists.sourceforge.net
Subject: usbaudio panic
References: <Pine.HPX.4.33n.0212051549290.19058-100000@studcom.urz.uni-halle.de> <3DF0482E.8010109@boosthardware.com>
In-Reply-To: <Pine.HPX.4.33n.0212051549290.19058-100000@studcom.urz.uni-halle.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi --

I'm sorry to bother you, but would you be so kind
as to forward this to the alsa-devel list?
I've tried to mail it there myself without
success;  for details about that see
 
http://sourceforge.net/tracker/?group_id=1&atid=200001&func=detail&aid=683706

=====================

Using linux 2.4.16 -> alsa rc6 -> usbaudio -> extigy ...
While some audio is playing,
power down the extigy using its front-panel switch.

Result:  instant system crash.

I had no trouble reproducing this.
-- Got a kernel panic at interrupt level once
  (something about module 'hotplug').
-- Got no message at all once, possibly because
I was running Xwindows on the console at the time......

If you have trouble reproducing it, let me
know and I'll see if I can provide more information.



--------------000102080303050708040602--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
