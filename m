From: Jordan Breeding <jordan.breeding@attbi.com>
Subject: Problem with alsa in 2.5.33 and xmms using oss emulation
Date: Mon, 09 Sep 2002 21:33:31 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D7D59FB.40204@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sccrmhc02.attbi.com (sccrmhc02.attbi.com [204.127.202.62])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id EAA18253
	for <alsa-devel@alsa-project.org>; Tue, 10 Sep 2002 04:34:11 +0200
Received: from attbi.com ([12.237.16.92]) by sccrmhc02.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020910023330.OXBT25823.sccrmhc02.attbi.com@attbi.com>
          for <alsa-devel@alsa-project.org>;
          Tue, 10 Sep 2002 02:33:30 +0000
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

   I wrote in quite a while back and have tried talking to the xmms 
developers about this but they insist that their must be a bug in my 
hardware or the driver I am using.  My problem is that using alsa as the 
built in kernel sound driver for my SBLive! instead of the oss style 
sound driver I can not control the volume level through the mixer using 
xmms.  The setup is as follows:  build the alsa driver for emu10k1 
directly into the kernel, enable oss emulation, use the oss output 
driver for xmms and enable "use volume instead of pcm".  If I then try 
to use the arrow keys on my keyboard of the scroll wheel on my mouse the 
volume mixer will get stuck in the xmms window in certain ranges 
(usually no more than 15 units total).  If I use my mount to drag the 
volume slider out of the range in question it will work again but will 
now be stuck in a new range.  Alsa seems to work well with everything 
else I have that uses oss besides xmms.  I do not know honestly which 
had the bug and which doesn't but they don't seem to care to much about 
listening to a bug report from me through email or over their message 
board.  Maybe someone on this list knows of a fix, can fix it, or can 
make the xmms people listen?  I sure hope so, thanks for the great sound 
drivers.

Jordan



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
