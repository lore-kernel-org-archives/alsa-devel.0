From: drclaw@dogsolitude.org
Subject: Re: HDSP -- linux CardBus issue : further information
Date: Tue, 4 Jun 2002 10:54:01 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020604145401.GA18517@dogsolitude.org>
References: <E17D0bp-0000Og-00@satellite>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from pylon.dogsolitude.org (postfix@map-dsl-134.map.com [208.168.78.134])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA12470
	for <alsa-devel@alsa-project.org>; Tue, 4 Jun 2002 20:40:50 +0200
Content-Disposition: inline
In-Reply-To: <E17D0bp-0000Og-00@satellite>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: thomas@undata.org, ico@fuse.net
List-Id: alsa-devel@alsa-project.org

On Wed, May 29, 2002 at 12:23:13PM +0200, Thomas Charbonnel wrote:
> Hi Paul,
> 
> Here are some new elements that may help you :
> - You said that under windows the bios settings were used to configure the 
> card, thus asked Ico and I to boot using pci=biosirq, which I did, to find 
> that the card was given the same IRQ as before (10)  (I was supposed to have 
> an IO problem, not an IRQ one) . Then I checked under windows, and the card 
> is given 9 as its IRQ, so there may be a problem using the bios settings on 
> my machine under linux.

You might be able to specify IRQ 9 with "cb_pci_irq=9".  Of course this
depends on support of the IRQ router.  There's a ton of useful information
over at http://www.tldp.org/HOWTO/PCMCIA-HOWTO-5.html that is worth checking
out.  

784 - Michael C. Piantedosi - drclaw@dogsolitude.org

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
