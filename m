From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: jerks
Date: Thu, 08 Dec 2005 14:40:30 -0500
Message-ID: <1134070831.3919.28.camel@mindpipe>
References: <1134063707.13439.37.camel@snuk.slsware.lan>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 20F5218D
	for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2005 20:39:16 +0100 (MET)
In-Reply-To: <1134063707.13439.37.camel@snuk.slsware.lan>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Glenn English <ghe@slsware.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-12-08 at 10:41 -0700, Glenn English wrote:
> I'm trying to make a Digital Audio Workstation (DAW) out of a SUN W2100z
> (dual AMD64).
> 
> Every few seconds, at seemingly random times, everything freezes for
> ~50ms. Even the mouse. Sometimes. Reliable at the first card moved in
> Aisle Riot Solitaire and when Jack is running. Often when I'm typing
> email (chars don't get from the keyboard to the screen).
> 
> I know that's not much of a description, but I don't know where to start
> looking for this. I'm assuming interrupts are being disabled entirely
> momentarily. My background says it's time for a bus monitor, but I don't
> have one handy.
> 
> This happens with a 2.6 kernel from the current updated Sarge or a 2.4
> from DeMuDi 1.2.1 distro.
> 
> Anybody have any idea how to begin tracing this down? Or maybe a better
> explanation of what's going on?
> 

Try the -rt kernel and enable latency tracing



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
