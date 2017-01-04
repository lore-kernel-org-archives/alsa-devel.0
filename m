From: Juho Jokelainen <juho_jokelainen@hotmail.com>
Subject: Re: Better support for Focusrite saffire pro 6 usb 1
Date: Wed, 4 Jan 2017 20:10:18 +0000
Message-ID: <VI1PR1001MB102389B2FC5A3FF379296AB182610@VI1PR1001MB1023.EURPRD10.PROD.OUTLOOK.COM>
References: <VI1PR1001MB10235B43C460301D5231175C82610@VI1PR1001MB1023.EURPRD10.PROD.OUTLOOK.COM>,
 <9eb4d48c-8d0f-57a6-6a96-bfc79df9ee25@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from COL004-OMC3S12.hotmail.com (col004-omc3s12.hotmail.com
 [65.55.34.150]) by alsa0.perex.cz (Postfix) with ESMTP id 07BD626759E
 for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2017 21:10:22 +0100 (CET)
In-Reply-To: <9eb4d48c-8d0f-57a6-6a96-bfc79df9ee25@ladisch.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Clemens Ladisch
>Juho Jokelainen wrote:
>> +               for (i = 0; i < alts->desc.bNumEndpoints; ++i) {
>> +                       if (alts->endpoint[i].desc.bEndpointAddress == fmt->endpoint)
>> +                               alts->endpoint[i].enabled = 1;
>> +                       else if (need_init)
>> +                               alts->endpoint[i].enabled = 0;
>
>This field is set by the USB framework; changing it from other code does
>not make sense.
>
>We need to track the state of the interface, not of the endpoint.
>
>
>Regards,
>Clemens

Is there anyone willing to take this code and make it into a feasible patch?
If not, would someone give me a rough estimate how much work I should
assume this to be, and possibly some contact where I can ask stupid 
questions about kernel and alsa.
I know if I'm to refactor this code there will be plenty of those, and I don't
think this mailing list is the right place for them.

- Juho
