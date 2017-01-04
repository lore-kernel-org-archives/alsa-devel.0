From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Better support for Focusrite saffire pro 6 usb 1
Date: Wed, 4 Jan 2017 12:26:25 +0100
Message-ID: <9eb4d48c-8d0f-57a6-6a96-bfc79df9ee25@ladisch.de>
References: <VI1PR1001MB10235B43C460301D5231175C82610@VI1PR1001MB1023.EURPRD10.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 77AD9266A31
 for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2017 12:26:48 +0100 (CET)
In-Reply-To: <VI1PR1001MB10235B43C460301D5231175C82610@VI1PR1001MB1023.EURPRD10.PROD.OUTLOOK.COM>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Juho Jokelainen <juho_jokelainen@hotmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Juho Jokelainen wrote:
> +               for (i = 0; i < alts->desc.bNumEndpoints; ++i) {
> +                       if (alts->endpoint[i].desc.bEndpointAddress == fmt->endpoint)
> +                               alts->endpoint[i].enabled = 1;
> +                       else if (need_init)
> +                               alts->endpoint[i].enabled = 0;

This field is set by the USB framework; changing it from other code does
not make sense.

We need to track the state of the interface, not of the endpoint.


Regards,
Clemens
