From: John Covici <covici@ccs.covici.com>
Subject: 2.5.24 rmmod of sndtimer causes system crash
Date: Tue, 25 Jun 2002 14:16:17 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m3wusnz0jy.fsf@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

I am using kernel 2.5.24 and when I try to shutdown the alsa drivers
I get unable to handle kernel paging exception ... 

Upon further investigation, the problem is that sndtimer cannot be
deleted the rmmod of this module causes the problem.  I am using the
via8233 sound card if that makes any difference.

If I build the alsa in the kernel, it works, but always calls the
card card0 is there anywhere I can specify something different so I
can keep my same asound.state file?


-- 
         John Covici
         covici@ccs.covici.com


-------------------------------------------------------
This sf.net email is sponsored by: Jabber Inc.
Don't miss the IM event of the season | Special offer for OSDN members! 
JabConf 2002, Aug. 20-22, Keystone, CO http://www.jabberconf.com/osdn
