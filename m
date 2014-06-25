From: Daniel Mack <daniel@zonque.org>
Subject: Re: snd_usb_endpoint_free
Date: Wed, 25 Jun 2014 12:13:25 +0200
Message-ID: <53AAA0C5.1090506@zonque.org>
References: <alpine.DEB.2.02.1406250824110.2012@localhost6.localdomain6>
 <alpine.DEB.2.02.1406250849550.2012@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id AD0C3261AD0
 for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2014 12:13:37 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1406250849550.2012@localhost6.localdomain6>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia.lawall@lip6.fr>, perex@perex.cz
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Julia,

On 06/25/2014 08:50 AM, Julia Lawall wrote:
> On Wed, 25 Jun 2014, Julia Lawall wrote:
>> The function snd_usb_endpoint_free in sound/usb/endpoint.c is defined as 
>> follows:
>>
>> void snd_usb_endpoint_free(struct list_head *head)
>> {
>>         struct snd_usb_endpoint *ep;
>>
>>         ep = list_entry(head, struct snd_usb_endpoint, list);
>>         release_urbs(ep, 1);
>>         kfree(ep);
>> }
>>
>> I wonder if the final kfree should be list_del?  In practice, this 
> 
> Sorry, the question should be "I wonder if this function should also use 
> list_del", since list_del doesn't subsume kfree.
> 
> julia
> 
>> function is only used from snd_usb_audio_disconnect in sound/usb/card.c 
>> where the entire list is destroyed, but it seems like quite a generic 
>> function that someone may someday want to use for just freeing one entry.

Jup, you're right, a list_del() in there wouldn't harm. However, it
currently wouldn't buy us anything either, and other functions we call
from snd_usb_audio_disconnect() for list members don't kill their own
list entry node themselves.


Thanks,
Daniel
