From: "Pierre C" <lists@peufeu.com>
Subject: Re: USB Implicit Feedback
Date: Sun, 07 Sep 2014 09:06:14 +0200
Message-ID: <op.xls10oxteorkce@apollo13>
References: <op.xlq6q9vfeorkce@apollo13> <540AF652.8080501@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo68.mail-out.ovh.net (5.mo68.mail-out.ovh.net [46.105.62.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 553AB265114
 for <alsa-devel@alsa-project.org>; Sun,  7 Sep 2014 12:11:27 +0200 (CEST)
Received: from mail138.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo68.mail-out.ovh.net (Postfix) with SMTP id D85D5FFA1D6
 for <alsa-devel@alsa-project.org>; Sun,  7 Sep 2014 09:06:17 +0200 (CEST)
In-Reply-To: <540AF652.8080501@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

>> I'd like to use implicit feedback instead,
>
> Why?

Two reasons :

- The Apple app notes seem to say it's the best way to do things, and I'd  
like it to also work on Macs. But I'm not married to Apple, and it seems  
Macs also support explicit feedback, so this isn't a very important point.

- Implicit feedback would use one less IN endpoint, and that would be  
useful.

>> - Is it actually supported ?
>
> Yes.

OK !

> The usage mask of bmAttributes of the endpoint should be
> USB_ENDPOINT_USAGE_IMPLICIT_FB, along with some other constraints. See
> set_sync_endpoint() in sound/usb/pcm.c

I have read this source code before but I'm not sure what the second  
parameter of "get_endpoint(alts, 1)" really means, does it imply that an  
altsetting has to have 2 endpoints and it takes the second one, but in  
which order ? order of definition in descriptors, endpoint number ?...

But is it bmAttributes in the playback endpoint descriptor, or its buddy  
capture endpoint ? The USB docs are quite vague and I see several possible  
interpretations ... Does the playback AudioStreaming descriptor need to  
have 1 endpoint, or 2 ?... I've tried various combinations with the latest  
stable linux kernel, none worked. Do I need to set bAssocTerminal ?

Thanks ;)
