From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: amixer issues
Date: Tue, 04 Apr 2006 12:30:39 -0400
Message-ID: <1144168240.26668.6.camel@mindpipe>
References: <1143907666.9228.31.camel@localhost.localdomain>
	 <20060404161719.GB18884@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 69D0121F
	for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2006 18:30:45 +0200 (MEST)
In-Reply-To: <20060404161719.GB18884@turing.informatik.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Adrian McMenamin <adrian@mcmen.demon.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-04-04 at 18:17 +0200, Clemens Ladisch wrote:
> Does /dev/snd/controlC0 exist, and does it point to the control device
> listed in /proc/asound/devices?
> 

Can you please clarify?  How does a device node "point to" something?

$ ls -al /dev/snd/controlC0
crw-rw---- 1 root audio 116, 0 Apr  1 10:06 /dev/snd/controlC0

$ cat /proc/asound/devices 
  0: [ 0]   : control
  1:        : sequencer
  4: [ 0- 0]: hardware dependent
  6: [ 0- 2]: hardware dependent
  8: [ 0- 0]: raw midi
  9: [ 0- 1]: raw midi
 10: [ 0- 2]: raw midi
 11: [ 0- 3]: raw midi
 16: [ 0- 0]: digital audio playback
 18: [ 0- 2]: digital audio playback
 19: [ 0- 3]: digital audio playback
 20: [ 0- 4]: digital audio playback
 24: [ 0- 0]: digital audio capture
 25: [ 0- 1]: digital audio capture
 26: [ 0- 2]: digital audio capture
 28: [ 0- 4]: digital audio capture
 33:        : timer

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
