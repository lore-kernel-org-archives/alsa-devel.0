From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH v2 08/10] ALSA: usb-audio: conditional
 interface altsetting
Date: Thu, 22 Aug 2013 20:00:20 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308221943090.1343@heraclitus>
References: <1377121085-20563-1-git-send-email-eldad@fogrefinery.com>
 <1377121085-20563-9-git-send-email-eldad@fogrefinery.com>
 <5215B730.9020709@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f49.google.com (mail-bk0-f49.google.com
 [209.85.214.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 50C4126087A
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2013 20:00:26 +0200 (CEST)
Received: by mail-bk0-f49.google.com with SMTP id r7so812218bkg.22
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2013 11:00:26 -0700 (PDT)
In-Reply-To: <5215B730.9020709@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org



On Thu, 22 Aug 2013, Clemens Ladisch wrote:

> Eldad Zack wrote:
> > This patch moves all of the alternate setting operations for pcm
> > ops to one function which checks if we can do so.
> 
> > +static int get_cur_altset_idx(struct usb_device *dev, int ifnum)
> > +{
> > +	...
> > +	return altsd->bAlternateSetting;
> 
> Please note that there are two methods to identify alternate settings:
> the number, which is the value in bAlternateSetting, and the index,
> which is the index in the descriptor array.  There might be some wording
> in the USB spec that these two values must be the same, but in reality,
> [insert standard rant about firmware writers], and bAlternateSetting

Yes, the size of mixer_quirks says it all...

> must be treated as a random ID value.
> 
> In struct audioformat, both values are stored in the altsetting and
> altset_idx fields; struct usb_substream has only altset_idx.
> 
> As far as I can see, you code always uses the name altset_idx for the
> number.

You are right of course. I meant the ID - I'll change the name to
"altsetting". And I'll have to change patch #10 as well, because it 
actually wrong there.

Thanks again, Clemens!

Cheers,
Eldad
