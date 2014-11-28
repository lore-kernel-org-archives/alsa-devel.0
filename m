From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [PATCH 2/2] Signed-off-by: Jurgen Kramer
	<gtmkramer@xs4all.nl>
Date: Fri, 28 Nov 2014 17:37:43 +0500
Message-ID: <54786C97.4050002@gmail.com>
References: <1417177870-5844-1-git-send-email-gtmkramer@xs4all.nl>
 <1417177870-5844-3-git-send-email-gtmkramer@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f46.google.com (mail-la0-f46.google.com
 [209.85.215.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D2BA260467
 for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2014 13:37:45 +0100 (CET)
Received: by mail-la0-f46.google.com with SMTP id q1so707112lam.19
 for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2014 04:37:44 -0800 (PST)
In-Reply-To: <1417177870-5844-3-git-send-email-gtmkramer@xs4all.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jurgen Kramer <gtmkramer@xs4all.nl>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

28.11.2014 17:31, Jurgen Kramer wrote:
> +		case 2: /* DSD mode requested */
> +			err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), 0,
> +					      USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
> +					      1, 1, NULL, 0);
> +			if (err < 0)
> +				return err;
> +			break;
> +		case 1: /* PCM mode requested */
> +			err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), 0,
> +					      USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
> +					      0, 1, NULL, 0);
> +			if (err > 0)
> +				return err;
> +			break;

maybe if (err < 0)?

-- 
Alexander E. Patrakov
