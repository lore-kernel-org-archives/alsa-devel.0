From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH RFC 09/10] ALSA: usb-audio: clarify
 implicit fb quirk for Roland
Date: Sat, 20 Jul 2013 18:54:13 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1307201852120.1001@xoschi>
References: <1374258210-14486-1-git-send-email-eldad@fogrefinery.com>
 <1374258210-14486-10-git-send-email-eldad@fogrefinery.com>
 <51EA9102.1040500@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f50.google.com (mail-ee0-f50.google.com [74.125.83.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C9BB260857
 for <alsa-devel@alsa-project.org>; Sat, 20 Jul 2013 18:54:20 +0200 (CEST)
Received: by mail-ee0-f50.google.com with SMTP id d49so2912539eek.23
 for <alsa-devel@alsa-project.org>; Sat, 20 Jul 2013 09:54:19 -0700 (PDT)
In-Reply-To: <51EA9102.1040500@ladisch.de>
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



On Sat, 20 Jul 2013, Clemens Ladisch wrote:

> Eldad Zack wrote:
> > Move the vendor ID check to the outside and also propogate
> > the error code.
> 
> > -	if (...
> > -         search_roland_implicit_fb(subs->dev, altsd->bInterfaceNumber + 1,
> > -				      altsd->bAlternateSetting,
> > -				      &alts, &ep) >= 0) {
> > -		goto add_sync_ep;
> 
> > +			int err = search_roland_implicit_fb(subs->dev, altsd->bInterfaceNumber + 1,
> > +							altsd->bAlternateSetting,
> > +						        &alts, &ep);
> > +			if (err < 0)
> > +				return err;
> > +
> > +			goto add_sync_ep;
> 
> The error code change is not a refactoring, but a logic change.
> 
> In this case, a nonexistent feedback endpoint should not be considered a fatal error.

Right, thanks!
I'll change it to return 0.

Cheers,
Eldad
