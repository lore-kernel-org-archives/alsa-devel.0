From: Jesse Chappell <jesse@essej.net>
Subject: Re: Questions to HDSP users
Date: Wed, 28 Jan 2004 14:22:37 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <49f18f21d61ee5db3233ab67ef91feb5@essej.net>
References: <4017D54D.2020502@undata.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from test.essej.net (pilabs.com [4.21.76.131])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA24068
	for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2004 20:23:11 +0100
In-Reply-To: <4017D54D.2020502@undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thomas Charbonnel wrote on Wed, 28-Jan-2004:

 > In the process of debuging the problems some hdsp users are 
 > experiencing, I reviewed almost every single line of code in the hdsp 
 > driver, and there are things in there that were inherited from the old 
 > rme9652 driver and that don't seem relevant anymore for the hdsp 
 > (particularly now that hdspmixer is there).
 > * Does anyone use the passthru control ? If not I would gladly remove it 
 > as it interferes with hdspmixer. Anyway everything it did can be done 
 > with hdspmixer or the Mixer control using a shell script.
 > * The current behaviour is that the driver cancels any 1:1 input to 
 > output routing when playback or capture is enabled. Not only this 
 > interferes with hdspmixer, but I find it rather confusing. Any objection 
 > to a change here also ?

I never use it.... ++vote to get rid of it.  

And by the way, my hardware/software works completely fine (no
problems whatsoever):
  IBM ThinkPad A31  1.8 P4-M
  Cardbus HDSP/Multiface  rev 0xb
  kernel 2.4.21 , alsa 0.9.8

And while I have your attention, i've tried to get iec958 spdif
passthrough (non-audio AC3) working on the HDSP without success.
I created a HDSP.conf based on the RME9652.conf and got the device
properly opened using ac3dec -C , but no stream is passed (using
ADAT1 optical output, properly set as SPDIF in hdspconf).  Setting
the non-audio flag doesn't appear to have any effect.
It works fine as an output for regular PCM spdif operation.

Any ideas you or the other alsa gurus have would be most welcome.

jlc


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
