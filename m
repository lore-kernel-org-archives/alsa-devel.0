From: Tom Watson <sdc695@yahoo.com>
Subject: Various versions, overruns
Date: Sat, 3 Jul 2004 20:44:34 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040704034434.53070.qmail@web60805.mail.yahoo.com>
References: <E1Bgnm7-00056L-V6@sc8-sf-list2.sourceforge.net>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1Bgnm7-00056L-V6@sc8-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I thought it would be simple (doesn't everybody), but as usual complications
abound.  I'm attempting to write a player program that accepts signals to
pause/resume, and fast fwd/fast rev.  I thought I had it working, but my
version does overruns, and 'aplay' doesn't seem to.  I used the 1.0.5 version
of 'aplay' and stripped lots out.  It all works well, except when I go to play
8 channels.  I get overruns of about .01 ms (a couple of samples).  I'm using
the Version 0.9.6 version of the driver, and when I use its 'aplay' there is no
problem.  I'm attempting to read an eight channel 'wav' file of a CD-Rom, and
I'd like something that would have a large buffer so overruns don't happen.  My
problem is that I don't see an easy way to transfer large chunks from user
space to the driver, then read the CD-Rom, which if you let it might take a
while if you don't keep it "active".  The totally bizarre part is that 'aplay'
veresion 0.9.6 will work.  Others fail in some sort of way.  Arghhhh!!
The audio card is a M-Audio Revolution 7.1 (used in an 8.0 fashon, which works!!)

=====
-- 
Tom Watson
tsw@johana.com


		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
