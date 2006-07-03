From: Adrian Bunk <bunk@stusta.de>
Subject: Re: OSS driver removal, 2nd round
Date: Mon, 3 Jul 2006 21:42:44 +0200
Message-ID: <20060703194244.GA26941__14089.2727570192$1151955825$gmane$org@stusta.de>
References: <20060629192128.GE19712@stusta.de>
	<1151927579.13828.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id F27A11A7
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Jul 2006 21:42:44 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <1151927579.13828.6.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, perex@suse.cz, Olaf Hering <olh@suse.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 03, 2006 at 09:52:59PM +1000, Benjamin Herrenschmidt wrote:
> 
> > DMASOUND_PMAC
> > - Olaf Hering regarding regressions in SND_POWERMAC:
> >   Some tumbler models work only after one plug/unplug cycle of
> >   the headphone. early powerbooks report/handle the mute settings
> >   incorrectly. there are likely more bugs.
> 
> dmasound_pmac is crippled with bugs too... We should look at reported
> bug reports on snd-powermac (and snd-aoa which replaces the later for
> recent machines) and kill dmasound-pmac. I'm ok with that. snd-aoa is
> the only one to be properly maintained anyway, we'll add support for
> older machines to it over time and hopefully, it's a much saner codebase
> in the first place so handling weird machines regressions will be
> easier.

Thanks for this information.

I'll include DMASOUND_PMAC in the list of OSS drivers that might be 
removed in this round (if people report regressions in the ALSA drivers, 
this can still be undone (if someone observes such a regression, he 
should send me the bug number in the ALSA BTS (this is also what 
will be written in the help text of the OSS_OBSOLETE_DRIVER option))).

> Ben.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
