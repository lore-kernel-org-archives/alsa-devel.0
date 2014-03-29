From: Mark Hills <mark@xwax.org>
Subject: Re: [PATCH] ALSA: usb-audio - Capture and duplex
 support for Digidesign Mbox 1 sound card.
Date: Sat, 29 Mar 2014 22:57:21 +0000 (GMT)
Message-ID: <1403292231190.1294@localhost>
References: <52E5254A.8090308@gmail.com> <52E53D57.3010700@ladisch.de>
 <52E5CC2E.1010000@gmail.com> <5314EDA1.5040101@zonque.org>
 <1403282253300.13982@beth> <5336BC20.1050806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mx.ij.cx [212.13.201.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DD9A8261A9F
 for <alsa-devel@alsa-project.org>; Sat, 29 Mar 2014 23:57:24 +0100 (CET)
In-Reply-To: <5336BC20.1050806@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Zammit <damien.zammit@gmail.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 29 Mar 2014, Damien Zammit wrote:

> On 29/03/14 16:01, Mark Hills wrote:
> > I'm a bit late to this, but I think a more generic quirk is necessary.
> Thanks Mark, I don't know much about other devices, but I have provided
> some comments about my latest code:
> http://mailman.alsa-project.org/pipermail/alsa-devel/attachments/20140329/bab4ce5a/attachment-0001.bin

Thanks. I took a look and I think I have a similar concern to Daniel for 
readability. The code should really be shared with the quirk on a single 
endpoint.

The duplicate code in the patch already has different handling of 
maxpacksize and datainterval -- is that intentional? It's apparent because 
the new code ignores the values given in the quirk.

> > Or does some kind of spec define that these should be applied to the first 
> > endpoint and that all will be affected?
> I used educated guesses to make the Mbox 1 functional:
> 
> I set the altsetting of the interface based on the value provided in the
> first endpoint entry of the quirk, (since they must be all the same for
> a shared interface):
> +		alts = &iface->altsetting[fp[0]->altset_idx];
> 
> This works for any device where the interface is shared across multiple
> endpoints, right?  Otherwise you wouldn't use this new quirk type.
> 
> After reading all the quirk data and adding streams one by one, I went
> on to configure the interface based on the quirk data for the first entry:
> +	usb_set_interface(chip->dev, fp[0]->iface, 0);
> +	snd_usb_init_pitch(chip, fp[0]->iface, alts, fp[0]);
> +	snd_usb_init_sample_rate(chip, fp[0]->iface, alts, fp[0],
> fp[0]->rate_max);
> 
> I assumed that the supported rates for all interfaces was the same and
> that they could be read from the first endpoint entry in the quirk.
> I know, most of the quirk data is ignored, but they share the same
> interface so most of it is redundant anyway, isn't it?

If the data in the quirk is truly redundant, then really it should not be 
present, or have the structure to use it -- it is misleading like this.

The alternative is that the format is guaranteed to be identical between 
the endpoints on the same interface, which is what I attempted in my 
previous patch (however this assumption is incorrect, see below)
 
> I can't see what limitations this multi-endpoint quirk type has that
> might need to be adjusted for other devices.  Can you provide an example
> of a device that uses multiple endpoints within a single interface whose
> supported rates differ between endpoints? 

Yes, I dug out a Novation Twitch here. It uses different number of 
channels (and hence buffer sizes) on the record and playback endpoints. At 
very least other Focusrite devices will have this, too.

> If you can, then I also think we need a better model.  If you can't, is 
> it because it is impossible?
> 
> Damien
> 

Ok so I did further experiments.

One thing was to add more code to my patch that specifically sets 
sample_format etc. directly on the affected endpoint.

It seems the assumption that an enpoint has sole ownership of the 
interface is quite deeply spread in the code. For example, set_format() 
called as part of snd_usb_pcm_prepare().

In my case the result is blocking on one audio stream when the other is 
opened, I didn't look into detail whether this was the driver or hardware.

But I'm suprised your Mbox deals with the prepare step, perhaps it is 
suprisingly tolerant. Did you confirm that you could start and stop a 
recording during playback and that both streams were truly working?

Specifically as snd_usb_pcm_close() shuts down the whole interface. Is 
your Mbox continuing smoothly when this happens on one of the streams?

Thanks

-- 
Mark
