From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Unregister a card from userspace?
Date: Thu, 12 Nov 2015 14:26:15 +0100
Message-ID: <56449377.2050409@metafoo.de>
References: <alpine.DEB.2.02.1511041032180.1465@lnxricardw1.se.axis.com>
 <5639EAFA.9060008@ladisch.de>
 <alpine.DEB.2.02.1511121402000.11990@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-188.synserver.de (smtp-out-229.synserver.de
 [212.40.185.229])
 by alsa0.perex.cz (Postfix) with ESMTP id E00982658B1
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2015 14:26:17 +0100 (CET)
In-Reply-To: <alpine.DEB.2.02.1511121402000.11990@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 11/12/2015 02:07 PM, Ricard Wanderlof wrote:
> 
> On Wed, 4 Nov 2015, Clemens Ladisch wrote:
> 
>> Ricard Wanderlof wrote:
>>> My use case is that I have a card driver I'm working on as a module, and
>>> while insmodding it works fine, I can't rmmod it because once
>>> snd_soc_register_card() has been called, it has a usage count of 2 and
>>> thus cannot be rmmod:ed.
>>
>> soc_probe_component() adds a reference to each component's driver's
>> module.  Maybe putting each component into its own module would help.
> 
> I'd rather not as there's no real gain from it (the constituent drivers 
> cannot be used separately or in any other combination), but perhaps that 
> is the only way to go.
> 
>> Anyway, you should be able to unbind the driver:
>> <https://lwn.net/Articles/143397/>
> 
> Yes, that works. After unbinding the driver, the usage count drops to 0, 
> and I can successfully rmmod it. So at least that's a workable solution.
> 
> It just seems to me that there's something I must have missed, as there 
> should be a mechanism to do this automatically when a module containing a 
> driver is rmmod'ed.

The way it works is that the reference count for the modules of the
individual components is incremented when they are bound to the card to
ensure that they are not removed when still in use. This usually does not
affect the reference count on the module of the card and you can still rmmod
the module of the card which will unregister the card. This again drops the
reference count on the components and you can remove those modules as well.

In your case the components and the card are in the same module and you end
up with a cyclic dependency. The card ensures that the reference count of
the module for the components is incremented, which in this case is also the
cards module, so the cards module reference count is non 0 and you can't
rmmod the card module, which means the card won't be unregistered which
means the references to the module wont be dropped.
