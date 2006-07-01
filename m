From: Adrian Bunk <bunk@stusta.de>
Subject: Re: OSS driver removal, 2nd round
Date: Sat, 1 Jul 2006 18:01:23 +0200
Message-ID: <20060701160123.GB17588@stusta.de>
References: <20060629192128.GE19712@stusta.de>
	<44A54D8E.3000002@superbug.co.uk>
	<20060630163114.GA12874@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id B94F723E
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Jul 2006 18:01:24 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <20060630163114.GA12874@dspnet.fr.eu.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Olivier Galibert <galibert@pobox.com>, James Courtier-Dutton <James@superbug.co.uk>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, perex@suse.cz, Olaf Hering <olh@suse.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 30, 2006 at 06:31:14PM +0200, Olivier Galibert wrote:
> On Fri, Jun 30, 2006 at 05:13:02PM +0100, James Courtier-Dutton wrote:
> > Adrian Bunk wrote:
> > >- ALSA #1735 (OSS emulation 4-channel mode rear channels not working)
> > 
> > As the MAINTAINER of EMU10K1, I am happy for EMU10K1 driver to be 
> > removed from the kernel.
> > 
> > ALSA #1735 is now closed. All the apps the user was trying also support 
> > ALSA natively now, so OSS is not needed.
> 
> Are you joking ?

Besides what was already mentioned in this thread, let me add some 
points:
- most Linux applications already support ALSA
- kernel 2.6.0 with ALSA as default sound system was released in 2003
- the ALSA developers provide an in-kernel OSS emulation
- the ALSA developers provide an alternative user space OSS emulation
- there are many new soundcards without any OSS driver at all [1]

Compatibility is important, and it's nearly always working
(e.g. "aoss audacity" works for me perfectly).

There are only few exotic cornercases like ALSA #1735 where a subset of 
the OSS functionality is not working in the OSS emulation - and I doubt 
it would be worth putting much effort into fixing such cornercases.

>   OG.

cu
Adrian

[1] we are talking about the in-kernel OSS drivers, not the
    commercial OSS

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
