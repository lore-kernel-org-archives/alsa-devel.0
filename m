From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 0/3] ALSA: fireface: new driver for
 RME Fireface series (MIDI only)
Date: Mon, 7 Dec 2015 10:52:14 +0900
Message-ID: <5664E64E.7000807@sakamocchi.jp>
References: <1449408224-13955-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151206215744.GA6103@marvin.atrad.com.au> <5664E06C.9080705@sakamocchi.jp>
 <20151207013748.GD6213@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 98FE9265005
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 02:52:18 +0100 (CET)
In-Reply-To: <20151207013748.GD6213@marvin.atrad.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Dec 07 2015 10:37, Jonathan Woithe wrote:
> On Mon, Dec 07, 2015 at 10:27:08AM +0900, Takashi Sakamoto wrote:
>> On Dec 07 2015 06:57, Jonathan Woithe wrote:
>>> On Sun, Dec 06, 2015 at 10:23:41PM +0900, Takashi Sakamoto wrote:
>>>> Unfortunately, ffado library can disturb this functionality.
>>>> In RME::Device::init_hardware() function, the library sends a write transaction
>>>> to 0x0000801003f4 with invalid value as higher part of address in IEEE 1212 or
>>>> ISO/IEC 13213. This is a worst case I describe in patch 03.
>>>
>>> The number which FFADO writes to this register is not invalid: it is in fact
>>> the same number which is used in drivers on other operating systems
>>> (obtained from protocol analysis).
>>
>> No.
>>
>> As long as I tested with a debug option to firewire-ohci module, it sends
>> write transaction with '01000000'. This value includes invalid node ID.
>
> Curious.  Fair enough (although I was confused by the reference to the
> "higher part" in the commit message: it implied the higher part of the
> address in my mind, but in fact the issue with the node ID relates to the
> lower part.  Whatever.  I'll look into it at some point.

In IEEE 1212 (or ISO/IEC 13213), 64 bit addressing is defined. IEEE 1394 
utilize the specification.

Here is a actual example of the 64 bit address:
  * FFC1'FFFF'F000'0904 (oPCR[0] in node FFC1)
  * FFC2'FFFE'0000'0000 (the first address of Private space in node FFC2)
  * FFC3'ECC0'8000'0000 (the address of Echo Fireworks Command in node FFC3)

I mean the 'higher part' is 4 byte in MSB of the address. Drivers 
register the 4 byte to 0x'0000'8010'03f4, then Fireface 400 transfers 
asynchronous transactions to an address including the 4 byte in its MSB.


Regards

Takashi Sakamoto
