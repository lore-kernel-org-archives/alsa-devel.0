From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [RFC 01/12] snd-powermac: no
	longer	handle	anything with a layout-id property
Date: Thu, 29 Jun 2006 18:26:12 -0400
Message-ID: <1151619973.22380.50.camel@mindpipe>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130910.156412000@sipsolutions.net>
	<jey7vjiqwv.fsf@sykes.suse.de>
	<s5hac7yvfhe.wl%tiwai@suse.de> <jehd26aa25.fsf@sykes.suse.de>
	<jeu0631xpr.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 6815A2A8
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jun 2006 00:26:15 +0200 (MEST)
In-Reply-To: <jeu0631xpr.fsf@sykes.suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>, alsa-devel@alsa-project.org, netstar@gatheringofgray.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-06-29 at 23:03 +0200, Andreas Schwab wrote:
> Andreas Schwab <schwab@suse.de> writes:
> 
> > Takashi Iwai <tiwai@suse.de> writes:
> >
> >> At Mon, 26 Jun 2006 22:49:04 +0200,
> >> Andreas Schwab wrote:
> >>> 
> >>> Johannes Berg <johannes@sipsolutions.net> writes:
> >>> 
> >>> > This patch removes from snd-powermac the code that check for the layout-id
> >>> > and instead adds code that makes it refuse loading when a layout-id property
> >>> > is present, nothing that snd-aoa should be used.
> >>> 
> >>> Can we get snd-powermac back as long as snd-aoa is lacking all those
> >>> features from snd-powermac?
> >>
> >> What functions are missing?
> >
> > Sound on PowerMac7,2, DRC on TAS, probably more.
> 
> Another problem is that the sound device can only be opened once.
> 

What is the content of /proc/asound/cards?  The patches must have
changed the card name and failed to create a matching config file
in /usr/share/alsa/cards.

Lee



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
