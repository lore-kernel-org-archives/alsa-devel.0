From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 01/12] snd-powermac: no
	longer	handle	anything with a layout-id property
Date: Fri, 07 Jul 2006 18:27:41 +1000
Message-ID: <1152260861.9862.59.camel@localhost.localdomain>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130910.156412000@sipsolutions.net>
	<jey7vjiqwv.fsf@sykes.suse.de>
	<s5hac7yvfhe.wl%tiwai@suse.de> <jehd26aa25.fsf@sykes.suse.de>
	<jeu0631xpr.fsf@sykes.suse.de> <1151619973.22380.50.camel@mindpipe>
	<jehd231rjx.fsf@sykes.suse.de>
	<1152250720.9862.32.camel@localhost.localdomain>
	<1152259477.15068.15.camel@localhost>
	<1152260005.9862.53.camel@localhost.localdomain>
	<1152260564.15068.20.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 575B9221
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Jul 2006 10:27:51 +0200 (MEST)
In-Reply-To: <1152260564.15068.20.camel@localhost>
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

On Fri, 2006-07-07 at 10:22 +0200, Johannes Berg wrote:
> On Fri, 2006-07-07 at 18:13 +1000, Benjamin Herrenschmidt wrote:
> 
> > Maybe ... or not... I'd rather not bother. I think Alsa should be able
> > to create softvol if there is no Master volume...
> 
> But how long should it wait for the master volume to become available?
> Thing is, as far as I understand this, the mixer is dynamic and you can
> add and remove things at any time essentially. No one does, but that's
> another story.

Well, when the master volume shows up, softvol can "unplug" itself :)

Ben.



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
