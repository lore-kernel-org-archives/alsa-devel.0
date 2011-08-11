From: Greg KH <greg@kroah.com>
Subject: Re: [uclinux-dist-devel] [PATCH 3.0]ASoC: ad193x: add
 spi_hw_read, fix sysclk and register definition
Date: Thu, 11 Aug 2011 06:34:32 -0700
Message-ID: <20110811133432.GA6067@kroah.com>
References: <CAHG8p1B2HB61yooEsPwzw+4E60ffM2NUsb98yCsanfPnWD9vgA@mail.gmail.com>
	<DB904C5425BA6F4E8424B3B51A1414D16CA93F826F@NWD2CMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 944E6243DA
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Aug 2011 15:36:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <DB904C5425BA6F4E8424B3B51A1414D16CA93F826F@NWD2CMBX1.ad.analog.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Cc: "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, Scott Jiang <scott.jiang.linux@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "stable@kernel.org" <stable@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 11, 2011 at 04:52:18AM -0400, Zhang, Sonic wrote:
> 
> 
> >-----Original Message-----
> >From: uclinux-dist-devel-bounces@blackfin.uclinux.org
> >[mailto:uclinux-dist-devel-bounces@blackfin.uclinux.org] On
> >Behalf Of Scott Jiang
> >Sent: Thursday, August 11, 2011 4:27 PM
> >To: Greg Kroah-Hartman
> >Cc: uclinux-dist-devel@blackfin.uclinux.org;
> >alsa-devel@alsa-project.org; stable@kernel.org
> >Subject: [uclinux-dist-devel] [alsa-devel][PATCH 3.0]ASoC:
> >ad193x: add spi_hw_read, fix sysclk and register definition
> >
> >asoc cache layer can't support this kind of spi registers, so
> >bypass cache and read regiters directly
> >
> 
> This patch is against stable kernel 3.0 only, the ASOC framework in kernel 3.1 and later are different.

Then I need some acks from all of the relevant maintainers before I can
apply it to the stable kernel tree.

Is there a corrisponding patch in Linus's tree that does the same thing
already?

greg k-h
