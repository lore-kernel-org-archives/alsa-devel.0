From: Tom Watson <sdc695@yahoo.com>
Subject: Recording with V8235 (mic nput)
Date: Tue, 20 Jul 2004 01:43:04 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040720084304.34045.qmail@web60803.mail.yahoo.com>
References: <E1BmktH-0006Os-Bb@sc8-sf-list2.sourceforge.net>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1BmktH-0006Os-Bb@sc8-sf-list2.sourceforge.net>
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

In my zeal to get multi-channel working on the V8235 chip set, I flubbed up the
mixer so that plugging in a mic and attempting to record (arecord) doesn't
work.
Previously I was able to get it operational (so the hardware is good!), but
some secret in 'alsamixer' doesn't connect the mic input to the capture
converter.  Some will yield a short 'wav' file (converter has no input at all,
and isn't triggered), but try as I might I can't get the mic to capture.  I was
able to do this in an earlier version of alsa (0.9.6, maybe 1.0.4), but I am
now running 1.0.5 and wondering if that is the problem.

The motherboard (EIPA-M) has front & rear jacks for the MIC's and I'm using
just the front jack (the rear one is empty).  I've got amplified speakers
connected to the other jacks (line-out, line-in/back).

Is there a simple block diagram of the mixer for this chip that would allow me
to check the mixer controls to see if 'alsamixer' has the proper setup. 
Getting the info that should be in the datasheet is difficult since VIA doesn't
want you to see the data sheet.  I'd use the datasheet to figure out the proper
settings if it were available.

ARRG...
(and I thought this sound stuff was going to be easy...)

=====
-- 
Tom Watson
tsw@johana.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail is new and improved - Check it out!
http://promotions.yahoo.com/new_mail


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
