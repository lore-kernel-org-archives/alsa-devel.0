From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: Alsa handling of spdif bits (was Re: Questions to
 HDSP users)
Date: Fri, 06 Feb 2004 12:22:08 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <402378E0.2060708@undata.org>
References: <f87b1d8ca44251034e552d245dd4da21@essej.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from satellite.undata.org (brln-d9b80d50.pool.mediaWays.net [217.184.13.80])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA28139
	for <alsa-devel@alsa-project.org>; Fri, 6 Feb 2004 12:25:54 +0100
In-Reply-To: <f87b1d8ca44251034e552d245dd4da21@essej.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jesse Chappell <jesse@essej.net>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jesse Chappell wrote :
>  > regarding Jesse's problem:
>  > it looks like RME*.conf are broken.
>  > does the attached patch work?
> 
> Sorry, I had already created a new H-DSP.conf and figured out
> it needed the 'interface PCM'.   I was able to use ac3dec -C to
> open the device, and attempted to stream through it, but nothing
> streamed.  
> 
> Standard PCM streaming and mixing works fine over the spdif. 
> I have a feeling there is some strange interaction with the mixer's
> normal operation and the special spdif modes.
> 

So you should be able to do what you want using this iecset tool
Takashi mentioned :
iecset -c X audio off (where X is your card number)
After this command, when playback will be enabled (remember that with 
the current alsa model those bits are set on playback), the Non-Audio 
bit will be set properly (you should see it checked in hdspconf).
The 'alsa style' iec bits handling code in the driver
seems to be functional.
(BTW Takashi iecset -h says 'audio on' is non-audio and 'audio off' is 
audio but it seems to be the other way round, unless the hdsp driver is 
wrong here...)
The problem I see and I dislike with this is that iec bits are 
associated with playback. This is probably fine with most devices, but 
not with hardware that can do hardware routing, where you may want to 
route signal through the S/PDIF out with a certain bit combination - no 
playback is involved here. I believe a generic iec bits handling 
interface is a good thing, but is should not be affected by the card's 
status. Any comment on this Takashi ?

> An aside: this is also complicated because to open the device, the
> channels item in the slave.pcm section must match the iobox in
> use (multiface or digiface) which have differing channel counts.
> So when we do get this working, it will be a problem to handle
> both cases in a conf file.
> 

Not to mention that there is also a shift in the S/PDIF channels
position when the card changes speed mode...
Can the current configuration mechanism handle this properly ?
Similarly we would need different .conf files for the different hdsp
cards, but seeing Takashi's patch, it seems .conf files are associated
with a card using the generic driver name (here 'H-DSP'). Is there a way
to affect a .conf file to a specific submodel ?

Thomas





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
