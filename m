From: holger@dehnhardt.org
Subject: Re: MOTU Midi Express XT
Date: Thu, 27 Oct 2016 16:22:44 +0000
Message-ID: <9d5810a657a4fb63805acea778570a49@owncloud.dehnhardt.org>
References: <1bdf9e49-1bbb-4f45-5122-bd0f6f4315bf@ladisch.de>
 <bf3281416a57f2788d4772e9f7926b3a@owncloud.dehnhardt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from punkt-k.de (punkt-k.de [84.200.50.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 885D1266820
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 18:23:02 +0200 (CEST)
In-Reply-To: <1bdf9e49-1bbb-4f45-5122-bd0f6f4315bf@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

27. Oktober 2016 08:42 Uhr, "Clemens Ladisch" <clemens@ladisch.de> schrieb:
> holger@dehnhardt.org wrote:
> 
>> I own a MOTU Midi Express XT 8x8 interface which is connected through the parallel port. Recently
>> I upgraded my system and the new motherboard does not have an ISA parallel port anymore...
>> So I bought a PCI parallel port extension card
> 
> Does it happen to have a name? Is it compatible with the ISA parallel port?
> 
> Regards,
> Clemens

Ok, this is the lspci output for the card:

06:00.0 Parallel controller: MosChip Semiconductor Technology Ltd. Device 9900 (prog-if 03 [IEEE1284])
        Subsystem: Device a000:2000
        Flags: bus master, fast devsel, latency 0, IRQ 10
        I/O ports at b010 [size=8]
        I/O ports at b000 [size=8]
        Memory at fe201000 (32-bit, non-prefetchable) [size=4K]
        Memory at fe200000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Legacy Endpoint, MSI 00
        Capabilities: [100] Virtual Channel
        Capabilities: [800] Advanced Error Reporting

The card is the following:
https://www.conrad.de/de/1-port-serielle-steckkarte-pcie-972542.html

Can such a card be compatible with an ISA-Port?

Holger
