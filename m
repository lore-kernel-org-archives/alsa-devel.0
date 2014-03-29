Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f46.google.com (mail-pb0-f46.google.com
 [209.85.160.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A5AB2610A0
 for <alsa-devel@alsa-project.org>; Sat, 29 Mar 2014 13:27:54 +0100 (CET)
Received: by mail-pb0-f46.google.com with SMTP id rq2so6186495pbb.33
 for <alsa-devel@alsa-project.org>; Sat, 29 Mar 2014 05:27:53 -0700 (PDT)
Message-ID: <5336BC20.1050806@gmail.com>
Date: Sat, 29 Mar 2014 23:27:12 +1100
From: Damien Zammit <damien.zammit@gmail.com>
MIME-Version: 1.0
References: <52E5254A.8090308@gmail.com> <52E53D57.3010700@ladisch.de>
 <52E5CC2E.1010000@gmail.com> <5314EDA1.5040101@zonque.org>
 <1403282253300.13982@beth>
In-Reply-To: <1403282253300.13982@beth>
Subject: Re: [alsa-devel] [PATCH] ALSA: usb-audio - Capture and duplex
 support for Digidesign Mbox 1 sound card.
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Hills <mark@xwax.org>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <daniel@zonque.org>
List-ID: <alsa-devel@alsa-project.org>

On 29/03/14 16:01, Mark Hills wrote:
> I'm a bit late to this, but I think a more generic quirk is necessary.
Thanks Mark, I don't know much about other devices, but I have provided
some comments about my latest code:
http://mailman.alsa-project.org/pipermail/alsa-devel/attachments/20140329/bab4ce5a/attachment-0001.bin

> Or does some kind of spec define that these should be applied to the first 
> endpoint and that all will be affected?
I used educated guesses to make the Mbox 1 functional:

I set the altsetting of the interface based on the value provided in the
first endpoint entry of the quirk, (since they must be all the same for
a shared interface):
+		alts = &iface->altsetting[fp[0]->altset_idx];

This works for any device where the interface is shared across multiple
endpoints, right?  Otherwise you wouldn't use this new quirk type.

After reading all the quirk data and adding streams one by one, I went
on to configure the interface based on the quirk data for the first entry:
+	usb_set_interface(chip->dev, fp[0]->iface, 0);
+	snd_usb_init_pitch(chip, fp[0]->iface, alts, fp[0]);
+	snd_usb_init_sample_rate(chip, fp[0]->iface, alts, fp[0],
fp[0]->rate_max);

I assumed that the supported rates for all interfaces was the same and
that they could be read from the first endpoint entry in the quirk.
I know, most of the quirk data is ignored, but they share the same
interface so most of it is redundant anyway, isn't it?

I can't see what limitations this multi-endpoint quirk type has that
might need to be adjusted for other devices.  Can you provide an example
of a device that uses multiple endpoints within a single interface whose
supported rates differ between endpoints?  If you can, then I also think
we need a better model.  If you can't, is it because it is impossible?

Damien
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
