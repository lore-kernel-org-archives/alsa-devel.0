From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: ALSA: usb-audio: caiaq: endianness bug
Date: Mon, 29 Apr 2013 21:04:31 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1304292103150.7328@xoschi>
References: <alpine.LNX.2.00.1304291957510.6097@xoschi>
 <517EBD14.7030904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f44.google.com (mail-bk0-f44.google.com
 [209.85.214.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 006282616B4
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2013 21:04:35 +0200 (CEST)
Received: by mail-bk0-f44.google.com with SMTP id jk13so713187bkc.17
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2013 12:04:35 -0700 (PDT)
In-Reply-To: <517EBD14.7030904@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Mon, 29 Apr 2013, Daniel Mack wrote:

> On 29.04.2013 20:10, Eldad Zack wrote:
> > 
> > Hi Daniel,
> > 
> > I think I found a endian usage issue in the caiaq driver. I have a patch 
> > to fix it (below), but it assumes that the driver works currently on 
> > little endian CPUs - I don't have a device to test it with.
> 
> I don't currently have any either, but your findings make sense. I just
> know that the driver currently works on LE CPUs.

Thanks for the quick reply and the ack!

I'll update the commit message post a patch soon.

Cheers,
Eldad
