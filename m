From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: lsusb -v for AKAI's new EIE pro interface
Date: Mon, 02 Apr 2012 10:04:53 +0200
Message-ID: <4F795DA5.1070006@ladisch.de>
References: <CACckToWdWZQFiFS_2GkjR=_0=TDdVApDxfwB0c_3HJ4bvjCejw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id E403F243BD
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Apr 2012 10:01:15 +0200 (CEST)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 640462192F
	for <alsa-devel@alsa-project.org>; Mon,  2 Apr 2012 04:01:23 -0400 (EDT)
In-Reply-To: <CACckToWdWZQFiFS_2GkjR=_0=TDdVApDxfwB0c_3HJ4bvjCejw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Grant Diffey wrote:
> So device is 4 in 4 out with inserts and midi
>
> Composite with 2 interfaces. I can't tell if they're independent midi and
> audio or more essoteric
>
> anyone want to take a punt?
>
>    6.   bDeviceClass          255 Vendor Specific Class
>    7.   bDeviceSubClass       255 Vendor Specific Subclass
>    8.   bDeviceProtocol       255 Vendor Specific Protocol

So far, so bad.

>    38.     Interface Descriptor:
>    51.         bEndpointAddress     0x02  EP 2 OUT
>    53.           Transfer Type            Isochronous
>    61.         bEndpointAddress     0x83  EP 3 IN
>    63.           Transfer Type            Bulk
>    71.         bEndpointAddress     0x04  EP 4 OUT
>    73.           Transfer Type            Bulk

Using bulk endpoints in an interface also used for isochronous
transfers is not supported by the current driver.


Regards,
Clemens
