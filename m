From: Tom Watson <sdc695@yahoo.com>
Subject: sndstat (oss goodie)
Date: Tue, 1 Apr 2003 13:18:19 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030401211819.57212.qmail@web21508.mail.yahoo.com>
References: <1049224176.18536.20.camel@cmn37.Stanford.EDU>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1049224176.18536.20.camel@cmn37.Stanford.EDU>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

In my poking around I noticed that while /proc/asound/oss/sndstat
exists and works quite well, the file /dev/sndstat (major 14, minor 6)
yields "No such device".

Questions:
Should '/dev/sndstat' be changed from major 14, minor 6 to a link to
'/proc/asound/oss/sndstat' (it appears to have the proper information)?
Or should the OSS emulation provide the information?

I will agree that this isn't the highest in the list of things to do,
not is it "absolutely" necessary, but it would be "a good thing" to do.

=====
-- 
Tom Watson
tsw@johana.com

__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online, calculators, forms, and more
http://platinum.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
