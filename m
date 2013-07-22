From: Mike Dyer <mike.dyer@md-soft.co.uk>
Subject: Re: Samsung S5PV210 I2S DMA
Date: Mon, 22 Jul 2013 08:33:29 +0100
Message-ID: <1374478409.1874.2.camel@localhost>
References: <1365334565.5261.4.camel@localhost> <51D7EFEA.6040901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 by alsa0.perex.cz (Postfix) with ESMTP id EB3BA261785
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 09:33:32 +0200 (CEST)
Received: by mail-wi0-f170.google.com with SMTP id ey16so2362746wid.1
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 00:33:32 -0700 (PDT)
In-Reply-To: <51D7EFEA.6040901@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexey Galakhov <agalakhov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 2013-07-06 at 16:22 +0600, Alexey Galakhov wrote:
> Hi,
> 
> > The DMA engine emits a lot of messages complaining of (I think) a read
> > fault:
> 
> > dma-pl330 dma-pl330.0: Reset Channel-0 CS-20000f FTC-40000
> > dma-pl330 dma-pl330.0: Reset Channel-0 CS-20000f FTC-40000
> 
> I'm debugging the same error right now. FTC-40000 means "Read error",
> i.e. invalid address of the DMA source block.
> 
> Regards,
> Alex

In my case it turned out the TZPC hadn't been configured properly by the
bootloader.  I had to modify to the bootloader to make sure the I2S was
non secured (it's secure by default).

Hope this helps,
Mike
