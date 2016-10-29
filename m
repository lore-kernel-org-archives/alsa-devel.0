From: holger@dehnhardt.org
Subject: Re: MOTU Midi Express XT
Date: Sat, 29 Oct 2016 15:52:15 +0000
Message-ID: <9393708728a54b11ca4bd1edc65d90f8@owncloud.dehnhardt.org>
References: <2e5e4e51f4f2c63ecab719a1937d695f@owncloud.dehnhardt.org>
 <9d5810a657a4fb63805acea778570a49@owncloud.dehnhardt.org>
 <1bdf9e49-1bbb-4f45-5122-bd0f6f4315bf@ladisch.de>
 <bf3281416a57f2788d4772e9f7926b3a@owncloud.dehnhardt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from punkt-k.de (punkt-k.de [84.200.50.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 48CAA266702
 for <alsa-devel@alsa-project.org>; Sat, 29 Oct 2016 17:52:38 +0200 (CEST)
Received: from [84.200.50.24] (port=48453 helo=owncloud.dehnhardt.org)
 by punkt-k.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.84_2) (envelope-from <holger@dehnhardt.org>)
 id 1c0Vvb-0004ne-C9
 for alsa-devel@alsa-project.org; Sat, 29 Oct 2016 17:52:15 +0200
In-Reply-To: <2e5e4e51f4f2c63ecab719a1937d695f@owncloud.dehnhardt.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

28. Oktober 2016 09:51 Uhr, holger@dehnhardt.org schrieb:
> 27. Oktober 2016 18:22 Uhr, holger@dehnhardt.org schrieb:
> 
>> 27. Oktober 2016 08:42 Uhr, "Clemens Ladisch" <clemens@ladisch.de> schrieb:
>> 
>>> holger@dehnhardt.org wrote:
>>> 
>>>> I own a MOTU Midi Express XT 8x8 interface which is connected through the parallel port. Recently
>>>> I upgraded my system and the new motherboard does not have an ISA parallel port anymore...
>>>> So I bought a PCI parallel port extension card
>>> 
>>> Does it happen to have a name? Is it compatible with the ISA parallel port?
>>> 
>>> Regards,
>>> Clemens
>> 
>> Ok, this is the lspci output for the card:
>> 
>> 06:00.0 Parallel controller: MosChip Semiconductor Technology Ltd. Device 9900 (prog-if 03
>> [IEEE1284])
>> Subsystem: Device a000:2000
>> Flags: bus master, fast devsel, latency 0, IRQ 10
>> I/O ports at b010 [size=8]
>> I/O ports at b000 [size=8]
>> Memory at fe201000 (32-bit, non-prefetchable) [size=4K]
>> Memory at fe200000 (32-bit, non-prefetchable) [size=4K]
>> Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>> Capabilities: [78] Power Management version 3
>> Capabilities: [80] Express Legacy Endpoint, MSI 00
>> Capabilities: [100] Virtual Channel
>> Capabilities: [800] Advanced Error Reporting
>> 
>> The card is the following:
>> https://www.conrad.de/de/1-port-serielle-steckkarte-pcie-972542.html
>> 
>> Can such a card be compatible with an ISA-Port?
>> 
>> Holger
> 
> I made a new observation. When loading the driver the PC-port LED blinks. At line 339 function
> snd_mtpav_portscan some bytes are send to the device. This seems to work - which means the
> communication between the PC and the device seems to work.
> 
> But why is the driver loaded but not registered?
> 
> Holger
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

As the driver is loaded and gives no error while loading, is there a way to investigate, why no alsa device is shown? 
Can I provide some more useful information? 

Holger
