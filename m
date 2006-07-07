From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 01/12] snd-powermac: no
	longer	handle	anything with a layout-id property
Date: Fri, 07 Jul 2006 15:38:40 +1000
Message-ID: <1152250720.9862.32.camel@localhost.localdomain>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130910.156412000@sipsolutions.net>
	<jey7vjiqwv.fsf@sykes.suse.de>
	<s5hac7yvfhe.wl%tiwai@suse.de> <jehd26aa25.fsf@sykes.suse.de>
	<jeu0631xpr.fsf@sykes.suse.de> <1151619973.22380.50.camel@mindpipe>
	<jehd231rjx.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 15E9E248
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Jul 2006 07:38:50 +0200 (MEST)
In-Reply-To: <jehd231rjx.fsf@sykes.suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Andreas Schwab <schwab@suse.de>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, netstar@gatheringofgray.com, linuxppc-dev@ozlabs.org, Lee Revell <rlrevell@joe-job.com>, Johannes Berg <johannes@sipsolutions.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-06-30 at 01:16 +0200, Andreas Schwab wrote:
> Lee Revell <rlrevell@joe-job.com> writes:
> 
> > What is the content of /proc/asound/cards?  The patches must have
> > changed the card name and failed to create a matching config file
> > in /usr/share/alsa/cards.
> 
> Thanks for the hint.  I have added 'AppleOnbdAudio cards.PMac' to
> /usr/share/alsa/cards/aliases.conf, and it works again.

There is still an issue... wether to enable softvol or not... With
snd-aoa, the card name is always the same but wether it has hardware
volume control or not (Toonie doesn't) is not known... Alsa should have
ways to add softvol automatically if no master volume control exist.

Ben.



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
