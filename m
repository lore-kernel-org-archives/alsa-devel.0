From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [uclinux-dist-devel] [PATCH 3.0]ASoC:
 ad193x: add spi_hw_read, fix sysclk and register definition
Date: Thu, 11 Aug 2011 07:17:37 -0700
Message-ID: <20110811141737.GA14832@kroah.com>
References: <CAHG8p1B2HB61yooEsPwzw+4E60ffM2NUsb98yCsanfPnWD9vgA@mail.gmail.com>
	<DB904C5425BA6F4E8424B3B51A1414D16CA93F826F@NWD2CMBX1.ad.analog.com>
	<20110811133432.GA6067@kroah.com> <s5hpqkc83o2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id C8FC724427
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Aug 2011 16:18:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hpqkc83o2.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Scott Jiang <scott.jiang.linux@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "Zhang,
	Sonic" <Sonic.Zhang@analog.com>, "stable@kernel.org" <stable@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 11, 2011 at 03:43:09PM +0200, Takashi Iwai wrote:
> At Thu, 11 Aug 2011 06:34:32 -0700,
> Greg KH wrote:
> > 
> > On Thu, Aug 11, 2011 at 04:52:18AM -0400, Zhang, Sonic wrote:
> > > 
> > > 
> > > >-----Original Message-----
> > > >From: uclinux-dist-devel-bounces@blackfin.uclinux.org
> > > >[mailto:uclinux-dist-devel-bounces@blackfin.uclinux.org] On
> > > >Behalf Of Scott Jiang
> > > >Sent: Thursday, August 11, 2011 4:27 PM
> > > >To: Greg Kroah-Hartman
> > > >Cc: uclinux-dist-devel@blackfin.uclinux.org;
> > > >alsa-devel@alsa-project.org; stable@kernel.org
> > > >Subject: [uclinux-dist-devel] [alsa-devel][PATCH 3.0]ASoC:
> > > >ad193x: add spi_hw_read, fix sysclk and register definition
> > > >
> > > >asoc cache layer can't support this kind of spi registers, so
> > > >bypass cache and read regiters directly
> > > >
> > > 
> > > This patch is against stable kernel 3.0 only, the ASOC framework in kernel 3.1 and later are different.
> > 
> > Then I need some acks from all of the relevant maintainers before I can
> > apply it to the stable kernel tree.
> > 
> > Is there a corrisponding patch in Linus's tree that does the same thing
> > already?
> 
> Not yet, even neither in sound git tree.
> 
> We're handling the same patch now for 3.1.  As the patch is likely
> applicable to 3.0 as is, putting Cc to stable would be enough, I
> suppose.
> 
> 
> Scott, the patch to stable kernel must have been applied to the
> upstream tree beforehand.  Read Documentation/stable_kernel_rules.txt.

Ok, now dropped from my stable "to-apply" mbox.

I'll wait for the real patch to hit Linus's tree.

greg k-h
