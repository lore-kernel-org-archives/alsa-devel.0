From: "Piotr Makowski" <oponek@gmail.com>
Subject: Re: ESI MAYA44 PCI datasheet request
Date: Tue, 21 Aug 2007 22:17:56 +0200
Message-ID: <87988a970708211317v37407183tf3f18efc69eb1bf0@mail.gmail.com>
References: <20070821184839.AEC90102FE@ws1-3.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 326E11038C5
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Aug 2007 22:17:59 +0200 (CEST)
Received: by el-out-1112.google.com with SMTP id r27so273170ele
	for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2007 13:17:58 -0700 (PDT)
In-Reply-To: <20070821184839.AEC90102FE@ws1-3.us4.outblaze.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ash Willis <ashwillis@programmer.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I decided to send a changed letter (thank's for your comments) and if ESI
refuses to give the datasheet to all of the ALSA developers, we will start
to look for the best programmer. I changed the firmware demand and added
info about GPL license. Changed letter:

Dear Sir/Madam,

In reply to the letter sent 14.07.2007:

2007/8/14, ESI UK Support <uksupport@esi-audio.com>:

Dear Piotr

ESI do not provide and have no plans for Linux drivers for our products
However
ESI are happy to provide /share information to an Individual developer
within the Linux community
That is able and capable to develope drivers
and wishes to develope drivers

Regards

UK Support
ESI Auditechnik



I would like to ask you to share the information about ESI MAYA44 PCI card
needed to write drivers on behalf of the ALSA development team. ALSA team
needs all the information that you give your programmers to create drivers
for the device. We would like to ask you for:

- a full datasheet containing IO port layout, register descriptions and
commands,
- source code for current windows drivers would be very helpful but isn't
essential,
- ESI MAYA44 PCI firmware (if needed) and the permission for the firmware to
be distributed with ALSA.

There are many peope that are willing to write the driver for MAYA44 and
because of the way Open-Source software and drivers are developed, in the
interest of it's quality, it is important that the information about the
card are accesable for all of the ALSA developers. We ask for your permision
to place that information on the ALSA server for developers. Thanks to that
any qualified person will have acces to it. Many other companies provided
that kind of information to us this way before:
http://www-old.alsa-project.org/alsa/ftp/datasheets/

I also would like to inform you that the driver that we hope to produce will
be open-sourced and licensed under the GNU GPL as the whole ALSA project.

I am sure that adding this card to the list of the suported cards under the
linux operating system will cause the number of satisfied ESI card users to
increase. Thank you for your co-operation.

-- 
Best Regards,
Piotr Makowski


2007/8/21, Ash Willis <ashwillis@programmer.net>:
>
> Hi Piotr,
>
> In general, I think this is good. Some points though...
>
> * I don't think you should demand firmware source. Asking for that
> might be seen as quite invasive. It might be a bonus to have, but
> I don't see anyone hacking on it. Their firmware works, It's a
> driver that we need. Does this card even use firmware? I guess...
>
> * Linking to a mirror probably isn't too smart if they think their
> infos are going to distributed all over the web. Sorry, that was
> my fault. I'm an idiot. I think the correct link should be
> http://www-old.alsa-project.org/alsa/ftp/datasheets/
>
> * I would offer a fall back. I would propose that the approach you
> have mentioned is in their best interest however if they are
> unwilling to distribute the information freely, then the next best
> thing would be to find one developer that is able, willing and
> possesses the hardware. That's not ideal. I would prefer the second
> approach to no driver at all, as would you, I'm sure. However, I
> don't speak for anyone else when I say that.
>
> * I'm sure they know the ins and outs of open source but you should
> confirm with them the terms of this arrangement. NDAs are basically
> incompatible with this whole thing because, usually, releasing the
> source will breach the NDA. Make sure they know that the driver
> being produced is open source and licensed under the GNU GPL.
>
>
> Ash
>
