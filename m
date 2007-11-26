From: "Clemens Ladisch" <clemens@ladisch.de>
Subject: Re: [PATCH] add number of periods constraint to
 snd-aoa [try 3]
Date: Mon, 26 Nov 2007 08:28:25 +0100
Message-ID: <1196062105.9290.1223195775@webmail.messagingengine.com>
References: <Pine.LNX.4.64.0711231424280.5270@sbz-30.cs.Helsinki.FI>
	<1195822183.4149.118.camel@johannes.berg>
	<s5h63ztt6uu.wl%tiwai@suse.de>
	<1195849391.4149.154.camel@johannes.berg>
	<s5hsl2wne5m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 1889F24765
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 08:28:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hsl2wne5m.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Johannes Berg <johannes@sipsolutions.net>
Cc: alsa-devel@alsa-project.org, Heikki O Lindholm <holindho@cs.helsinki.fi>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Johannes Berg wrote:
> > On Fri, 2007-11-23 at 14:43 +0100, Takashi Iwai wrote:
> > > Johannes Berg wrote:
> > > > So what I'm not sure on... Why do we see the same behaviour with other
> > > > drivers? Same bug?
> > > 
> > > Which driver?  It should be fixed as well, then.
> > 
> > snd-usb-audio I think.
> 
> Oh that's I didn't know of.  Do you have more detailed information?
> 
> usb-audio also has no integer periods constraint, so it might suffer
> from the same problem, too.

snd-usb-audio uses double buffering and doesn't have any requirements
regarding periods.


Regards,
Clemens
