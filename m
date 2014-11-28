From: Jurgen Kramer <gtmkramer@xs4all.nl>
Subject: Re: [PATCH 2/2] Signed-off-by: Jurgen Kramer
 <gtmkramer@xs4all.nl>
Date: Fri, 28 Nov 2014 13:40:36 +0100
Message-ID: <1417178436.2994.0.camel@xs4all.nl>
References: <1417177870-5844-1-git-send-email-gtmkramer@xs4all.nl>
 <1417177870-5844-3-git-send-email-gtmkramer@xs4all.nl>
 <54786C97.4050002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb3-smtp-cloud6.xs4all.net (lb3-smtp-cloud6.xs4all.net
 [194.109.24.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BA0826044B
 for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2014 13:40:38 +0100 (CET)
In-Reply-To: <54786C97.4050002@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2014-11-28 at 17:37 +0500, Alexander E. Patrakov wrote:
> 28.11.2014 17:31, Jurgen Kramer wrote:
> > +		case 2: /* DSD mode requested */
> > +			err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), 0,
> > +					      USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
> > +					      1, 1, NULL, 0);
> > +			if (err < 0)
> > +				return err;
> > +			break;
> > +		case 1: /* PCM mode requested */
> > +			err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), 0,
> > +					      USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
> > +					      0, 1, NULL, 0);
> > +			if (err > 0)
> > +				return err;
> > +			break;
> 
> maybe if (err < 0)?
Oops,right. Typo when I cleanup the patch...will resend as v2.

Jurgen
> 
