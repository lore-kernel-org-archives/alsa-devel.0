From: Laurent Epinat <l.epinat@free.fr>
Subject: Re: New sound device question
Date: Sun, 26 Dec 2010 21:11:32 +0100
Message-ID: <4D17A174.2020001@free.fr>
References: <4D14A309.9030603@free.fr>
	<1293362435.7496.1412275155@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 029521037EA
	for <alsa-devel@alsa-project.org>; Sun, 26 Dec 2010 21:11:31 +0100 (CET)
In-Reply-To: <1293362435.7496.1412275155@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hello

Thanks for the answer




Le 26.12.2010 12:20, Clemens Ladisch a =E9crit :
> Laurent Epinat wrote:
>> I try to developpe a usb sound driver for a Alesis Multix 8 USB2.0
>>
>> http://www.alesis.com/multimix8usb20
>>
>> The output interface is allready fonctional, but the Input not :-(
>> Because there is 2 end point for it. The first one is on Isochronous
>> mode and the other is on Bulk mode
>>
>> I don't know how to declare the second endpoint in the quirks_table.
>
> There is no predefined quirk for such an endpoint; you'd have to write
> your own code.
>
>> Where can I get a good documentation or help about the alsa USB sound
>> structure.
>
> At the moment, the only documentation is the source code.
>
>> The only informations I have about the devices, are dump from windows
>
> What is the bulk endpoint used for?

I don't know exactly,
I think the Isochrone endpoint is used for control and the bulk one is =

the data, because the size is bigger and the interval is short than the =

isochrone one

on the device you can record 10 inputs channels at the same time

Interface Descriptor:
    bLength                 9
    bDescriptorType         4
    bInterfaceNumber        1
    bAlternateSetting       1
    bNumEndpoints           2
    bInterfaceClass       255 Vendor Specific Class
    bInterfaceSubClass      0
    bInterfaceProtocol      0
    iInterface              0
    Endpoint Descriptor:
       bLength                 7
       bDescriptorType         5
       bEndpointAddress     0x81  EP 1 IN
       bmAttributes            5
         Transfer Type            Isochronous
         Synch Type               Asynchronous
         Usage Type               Data
       wMaxPacketSize     0x0040  1x 64 bytes
       bInterval               4
    Endpoint Descriptor:
       bLength                 7
       bDescriptorType         5
       bEndpointAddress     0x86  EP 6 IN
       bmAttributes            2
         Transfer Type            Bulk
         Synch Type               None
         Usage Type               Data
       wMaxPacketSize     0x0200  1x 512 bytes
       bInterval               1




> Regards,
> Clemens
>


-- =

Salutations
