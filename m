From: Thomas Charbonnel <thomas@undata.org>
Subject: Alsa handling of spdif bits (was Re: Questions to HDSP
 users)
Date: Thu, 29 Jan 2004 14:51:34 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40190FE6.5030402@undata.org>
References: <49f18f21d61ee5db3233ab67ef91feb5@essej.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from satellite.undata.org (brln-d514866a.pool.mediaWays.net [213.20.134.106])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA21269
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2004 14:59:37 +0100
In-Reply-To: <49f18f21d61ee5db3233ab67ef91feb5@essej.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jesse Chappell <jesse@essej.net>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jesse Chappell wrote :
> 
> And while I have your attention, i've tried to get iec958 spdif
> passthrough (non-audio AC3) working on the HDSP without success.
> I created a HDSP.conf based on the RME9652.conf and got the device
> properly opened using ac3dec -C , but no stream is passed (using
> ADAT1 optical output, properly set as SPDIF in hdspconf).  Setting
> the non-audio flag doesn't appear to have any effect.
> It works fine as an output for regular PCM spdif operation.
> 
> Any ideas you or the other alsa gurus have would be most welcome.
> 
> jlc
> 
> 

Hi Jesse,

I just had a look and here again there is code in the hdsp driver 
directly inherited form the rme9652 driver. There are two competing 
spdif bits handling mechanisms there, one hdsp specific dealing directly 
with the card registers, and one alsa generic. There clearly is a 
problem in that the spdif bits on the card are cleared on playback where 
they shouldn't. It would be easy to fix, but I guess that the alsa 
generic spdif bits handling code is here for some reason. Jaroslav or 
Takashi, could you explain to me how this is supposed to work with alsa 
? I guess there is a plan for a generic spdif bits control interface, 
but for now there seems to be nothing. Amixer doesn't even seem to 
handle this properly, or does it ?

Thomas




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
