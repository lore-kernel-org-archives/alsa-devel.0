From: Tom Watson <sdc695@yahoo.com>
Subject: Inverted switche(s) on VIA 8235/VT1616i
Date: Tue, 1 Jun 2004 22:20:48 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040602052048.28790.qmail@web60806.mail.yahoo.com>
Reply-To: tsw@johana.com
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
To: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

When I attempt to do a 4 channel output using the aboce chip set, and I
control it with 'alsamixer' I note that when "Alternate Level to
Surround Out" is "[Off]" it is really on.  I really don't know if this
is a fault in 'alsamixer', or the driver.  It appears that these are
reversed in sense.  I don't know if other switches are reversed like
"Downmix LFE and Center to Front" as I haven't tried it.  Also there is
a switch that changes Center/LFE to the Mic connector.  I don't know
exactly what does this.  It may be in tandem with the "Alternate Level
to Surround Out" switch, but I'm not sure.

Can the switches be documented.  They seem to function, just not
exactly the way I thought.  Is this my error??

I'm using 'aplay' if that makes any difference.

=====
-- 
Tom Watson
tsw@johana.com


	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
