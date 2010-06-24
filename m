From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: force snd-usb-audio to use "Vendor Specific Class"
Date: Thu, 24 Jun 2010 12:36:38 +0200
Message-ID: <4C233536.1040205@redhat.com>
References: <1277299765.22499.42.camel@zwerg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 229A61037FF
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jun 2010 12:34:06 +0200 (CEST)
Received: from int-mx05.intmail.prod.int.phx2.redhat.com
	(int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o5OAY56C032294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2010 06:34:05 -0400
Received: from localhost.localdomain (vpn1-6-220.ams2.redhat.com [10.36.6.220])
	by int-mx05.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id o5OAY2vk024328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2010 06:34:04 -0400
In-Reply-To: <1277299765.22499.42.camel@zwerg>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 06/23/2010 03:29 PM, Alexey Fisher wrote:
> Hallo all,
> is there any way to force snd-usb-audio to use some "Vendor Specific
> Class" device?
> i currently got two webcams from my friends to take a look on. They are
> cheep gspca based webcams with Mic. I wont to test if snd-usb-audio can
> use it if i force it. Devices it self do not provide any hints for the
> driver.
>
> lsusb -vd 093a:2468 | grep -i class
>    bDeviceClass          255 Vendor Specific Class
>    bDeviceSubClass       255 Vendor Specific Subclass
>        bInterfaceClass       255 Vendor Specific Class
>        bInterfaceSubClass    255 Vendor Specific Subclass
>        bInterfaceClass       255 Vendor Specific Class
>        bInterfaceSubClass    255 Vendor Specific Subclass
>        bInterfaceClass       255 Vendor Specific Class
>        bInterfaceSubClass    255 Vendor Specific Subclass
>        bInterfaceClass       255 Vendor Specific Class
>        bInterfaceSubClass    255 Vendor Specific Subclass
>        bInterfaceClass       255 Vendor Specific Class
>        bInterfaceSubClass    255 Vendor Specific Subclass
>        bInterfaceClass       255 Vendor Specific Class
>        bInterfaceSubClass    255 Vendor Specific Subclass
>        bInterfaceClass       255 Vendor Specific Class
>        bInterfaceSubClass    255 Vendor Specific Subclass
>        bInterfaceClass       255 Vendor Specific Class
>        bInterfaceSubClass    255 Vendor Specific Subclass
>        bInterfaceClass       255 Vendor Specific Class
>        bInterfaceSubClass    255 Vendor Specific Subclass
>
> regards,
> Alexey
>


Don't bother, AFAIK these devices which are pixart pac207bca
based do not contain any microphone at all. If they do they usually
have 2 plugs at the end of their cable a usb plug and an analog
one for the mic.

Google for pac207bca datasheet to find a useless datasheet, note
that it does contain a listing of the physical pins of the device,
and notice the lack of any pins to connect a microphone too.

If the pac207 supports a microphone (which I strongly believe
it does not) the mic on these cameras is not a usb audio class
compatible device. The pac207 declares only one interface so
audio data ihas to be handled over the same interface
as the video data. So in order to support the MIC you first need to
find out how it works and then glew an alsa driver onto the
gspca pac207 driver (as only one driver can be bound to a single
usb interface).

Regards,

Hans, the pac207 driver maintainer


p.s.

It would have been helpful if you had contacted me about this, I just
happen to be subscribed to the alsa-devel list too.
