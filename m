From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [PATCH] AC97 bus interface for ad-hoc drivers
Date: Fri, 29 Jul 2005 12:20:40 +0100
Message-ID: <1122636040.3117.28.camel@localhost.localdomain>
References: <1121775624.14604.14.camel@cearnarfon>
	 <s5hbr4old2a.wl%tiwai@suse.de>
	 <Pine.LNX.4.63.0507270856510.21762@localhost.localdomain>
	 <1122582399.5371.90.camel@localhost.localdomain>
	 <s5h4qaddh5w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4qaddh5w.wl%tiwai@suse.de>
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
Cc: Nicolas Pitre <nico@cam.org>, alsa-devel@lists.sourceforge.net, Bill Gatliff <bgat@billgatliff.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-07-29 at 12:45 +0200, Takashi Iwai wrote:
> At Thu, 28 Jul 2005 21:26:39 +0100,
> Liam Girdwood wrote:

> > 
> > In this scenario SND_SOME_DRIVER selects SND_AC97_CODEC selects
> > SND_AC97_BUS and I could never get a SND_AC97_BUS=m or otherwise in
> > my .config. I was only ever successful by adding the select SND_AC97_BUS
> > line to SND_SOME_DRIVER.
> 
> Is it a PCI driver?  Since SND_AC97_CODEC and SND_AC97_BUS is in
> pci/Kconfig, it might the case that it's be selected only when
> PCI!=n.
> 
> 

It's an Arm (PXA27x) based driver, hence PCI=n.

You are correct. I had unsuccessfully tried the config SND_AC97_BUS out
with the PCI=n clause. It only works when _both_ SND_AC97_CODEC and
SND_AC97_BUS are out with PCI=n.

If nobody objects, I can resubmit with the SND_AC97_CODEC out with the
PCI=n in sound/pci/Kconfig. Will this cause any problems for other
cards ? 

> > I now don't think that the "select SND_PCM" is having any effect in the
> > AC97_CODEC config, although it still builds fine when remove it.
> 
> Hmm, we didn't have problems with other similar cases...

It was being included by the other Arm drivers.

Liam 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
