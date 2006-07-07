From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 01/12] snd-powermac: no
	longer	handle	anything with a layout-id property
Date: Fri, 07 Jul 2006 18:13:24 +1000
Message-ID: <1152260005.9862.53.camel@localhost.localdomain>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130910.156412000@sipsolutions.net>
	<jey7vjiqwv.fsf@sykes.suse.de>
	<s5hac7yvfhe.wl%tiwai@suse.de> <jehd26aa25.fsf@sykes.suse.de>
	<jeu0631xpr.fsf@sykes.suse.de> <1151619973.22380.50.camel@mindpipe>
	<jehd231rjx.fsf@sykes.suse.de>
	<1152250720.9862.32.camel@localhost.localdomain>
	<1152259477.15068.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3B8ED230
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Jul 2006 10:13:31 +0200 (MEST)
In-Reply-To: <1152259477.15068.15.camel@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Johannes Berg <johannes@sipsolutions.net>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Andreas Schwab <schwab@suse.de>, netstar@gatheringofgray.com, linuxppc-dev@ozlabs.org, Lee Revell <rlrevell@joe-job.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-07-07 at 10:04 +0200, Johannes Berg wrote:
> On Fri, 2006-07-07 at 15:38 +1000, Benjamin Herrenschmidt wrote:
> 
> > There is still an issue... wether to enable softvol or not... With
> > snd-aoa, the card name is always the same but wether it has hardware
> > volume control or not (Toonie doesn't) is not known... Alsa should have
> > ways to add softvol automatically if no master volume control exist.
> 
> Hm, good point. I probably need to completely revamp the card handling
> and not create a card object before the codecs are registered. That way,
> I could influence the naming through the codecs.

Maybe ... or not... I'd rather not bother. I think Alsa should be able
to create softvol if there is no Master volume...

Ben.



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
