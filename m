From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: snd_usb_endpoint_free
Date: Wed, 25 Jun 2014 08:50:33 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1406250849550.2012@localhost6.localdomain6>
References: <alpine.DEB.2.02.1406250824110.2012@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by alsa0.perex.cz (Postfix) with ESMTP id 36E38261691
 for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2014 08:50:34 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1406250824110.2012@localhost6.localdomain6>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On Wed, 25 Jun 2014, Julia Lawall wrote:

> The function snd_usb_endpoint_free in sound/usb/endpoint.c is defined as 
> follows:
> 
> void snd_usb_endpoint_free(struct list_head *head)
> {
>         struct snd_usb_endpoint *ep;
> 
>         ep = list_entry(head, struct snd_usb_endpoint, list);
>         release_urbs(ep, 1);
>         kfree(ep);
> }
> 
> I wonder if the final kfree should be list_del?  In practice, this 

Sorry, the question should be "I wonder if this function should also use 
list_del", since list_del doesn't subsume kfree.

julia

> function is only used from snd_usb_audio_disconnect in sound/usb/card.c 
> where the entire list is destroyed, but it seems like quite a generic 
> function that someone may someday want to use for just freeing one entry.
> 
> julia
> 
