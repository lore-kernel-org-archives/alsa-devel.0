From: Itay Ben-Yaacov <nib_maps@yahoo.com>
Subject: resume problems in intel8x0 persist (Inspiron 8200)
Date: Fri, 23 Jan 2004 03:09:59 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040123111000.97123.qmail@web21001.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


AS reported many times before, intel8x0 fails to resume properly with 1.0.1, on my (and according
to some old reports, others') Inspiron 8200 with an ICH3 chipset.

The problem is that codec #0 is not waited for for some reason, and adding a hard-coded waiting
time of HZ/4 solves the problem.
There was a brief time around 1.0.0pre1 when the problem was solved, and it came back in pre2.

Please try and solve this problem, or give me some tips on how to find oout WHY the codec is not
ready (or why it claims it is...)

Thanks,
Itay

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free web site building tool. Try it!
http://webhosting.yahoo.com/ps/sb/


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
