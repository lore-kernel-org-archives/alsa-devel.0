From: Tom Watson <sdc695@yahoo.com>
Subject: Speaker test and all that
Date: Thu, 24 Jun 2004 15:44:26 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040624224426.43140.qmail@web60804.mail.yahoo.com>
References: <E1BdKj1-00077O-EV@sc8-sf-list2.sourceforge.net>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1BdKj1-00077O-EV@sc8-sf-list2.sourceforge.net>
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

In a previous message I wrote...

> While I have seen .../test/pcm.c I have not seen 'speaker-test.c'.  A
> quick 'find' did not yield it either.  Is this something new??


My error.  I see that 'speaker-test' was introduced in Version 1.05.

While it is a nice program (it helped me find out that on a VIA 8235
the 'Line' control fed the Back channels into the Front channels, at a
lower level), I have a suggestion:

Please call the 'Non-Front' channels the 'BACK' channels.  Having both
'Right' and 'Rear' abbreviated as 'R' can be confusing.  The NQRC
(National Quadraphonic Radio Committee) back in the 70's figured this
out (I was there!) when setting up 4 channel broadcast standards in the
USA.  Note that this is only a documentation change.  I defer to others
the names LFE and Center.

=====
-- 
Tom Watson
tsw@johana.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
