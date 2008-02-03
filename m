From: Richard Marzan <richardmarzan@optonline.net>
Subject: Sound jack isolations
Date: Sun, 03 Feb 2008 00:09:13 -0500
Message-ID: <1202015353.7069.5.camel@localhost>
References: <1201754941.7685.4.camel@localhost>
	<1201763039.23369.56.camel@razman.gruemaster.com>
	<1201829593.32241.1.camel@localhost>
	<1202014992.7069.3.camel@localhost>
Reply-To: richardmarzan@optonline.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta4.srv.hcvlny.cv.net (mta4.srv.hcvlny.cv.net [167.206.4.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 32B4024638
	for <alsa-devel@alsa-project.org>; Sun,  3 Feb 2008 06:03:36 +0100 (CET)
Received: from [192.168.1.100] (ool-182c9ffc.dyn.optonline.net [24.44.159.252])
	by mta4.srv.hcvlny.cv.net
	(Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
	with ESMTP id <0JVN00G07CPYWC01@mta4.srv.hcvlny.cv.net> for
	alsa-devel@alsa-project.org; Sun, 03 Feb 2008 00:03:34 -0500 (EST)
In-reply-to: <1202014992.7069.3.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2008-01-31 at 20:33 -0500, Richard Marzan wrote:
> > On Wed, 2008-01-30 at 23:03 -0800, Tobin Davis wrote:
> > > Try downloading alsa-driver-1.0.16rc2.  It has some new patches in it.
> > > 
> > > If that doesn't work, please report back with the link generated from
> > > running http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh
> > > 
> > > Tobin
> > > 
> > > 
> > > On Wed, 2008-01-30 at 23:49 -0500, Richard Marzan wrote: 
> > > > I tried googling around but no helpful content so far. I have a laptop
> > > > with built-in sound. It uses the HDA_intel kernel module. My problem is
> > > > that I can't silence the onboard/built-in speakers when I plug in the
> > > > headphones to the machine. Muting sound would lead to all jacks and
> > > > audio ports to be silenced -- not just the built-in speakers, which I
> > > > intend to mute solely leaving sound alive on the headphone jacks. There
> > > > are no channels readily observable to differentiate where sound goes and
> > > > to which port with alsa-mixer. The behavior I would like to achieve is
> > > > one that will allow me to mute onboard speakers while continuing to have
> > > > the headphones receive audio signals. Has anyone ever done this? Any
> > > > pointers to documentation will be appreciated.
> > > > 
> > > > My board has the Conexant CX20549 Codec. I think is uses the ALC268
> > > > module. I checked gmane and saw that a fellow user got snd-hda-intel
> > > > working with the NVidia MCP67 chipset with a patch received from
> > > > linuxant.com. I tried the method and when patching i had encountered
> > > > errors. 


Thanks for the reply. Here is the link http://pastebin.ca/886945
