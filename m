From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] alsa integer control ranges
Date: Wed, 17 May 2006 08:03:43 +1000
Message-ID: <1147817023.6753.5.camel@localhost.localdomain>
References: <1147780945.29795.110.camel@johannes>
	 <s5h7j4m40kf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 651F423A
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2006 00:03:49 +0200 (MEST)
In-Reply-To: <s5h7j4m40kf.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Johannes Berg <johannes@sipsolutions.net>, ALSA development <alsa-devel@alsa-project.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Benjamin Berg <benjamin@sipsolutions.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-05-16 at 14:27 +0200, Takashi Iwai wrote:
> At Tue, 16 May 2006 14:02:20 +0200,
> Johannes Berg wrote:
> > 
> > Apparently all alsa userspace programs including alsamixer suck. Hence,
> > this patch is required to make them work properly. Why is it so hard to
> > do these additions/subtractions in the program or maybe even in the alsa
> > library? The alsa libraries already think they know better and mess up
> > all kinds of things.
> 
> It's a pretty stupid question to ask why you are stupid :)
> 
> I don't think it's alsa-lib that prevents the negative or non-zero
> integer range.  The fact amixer works implies that it's an
> app-specific bug.  But I'm not 100% sure and need more
> inside-looking.

Well, the problem I think is that pretty much all apps but amixer (and
alsamixer whch works too for me at least) are bogus. It would have been
good if Alsa had a more explicit specification that those values are not
to be interpreted in the old OSS range :) In fact, best would have been
to have the control structure carry a "unit" which a set of known units,
one being dB, since the natural way of specifying an attenuation on any
serious audio HW is dB and is negative... 

> > What are your opinions on this? Should this be required? And if so, why
> > do we even have the value.integer.min when we can't use it anyway? 
> 
> Right now, the range 0-max would make your life easier, I guess.
> 
> The min value is an API definition, and implemented and worked once.
> But no drivers used yet.  So, there might be a breakage.  It's of
> course to be fixed.

There is a lack of serious/professional audio drivers in the linux world
unfortunately... 

Ben.




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
