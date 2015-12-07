From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 0/3] ALSA: fireface: new driver for
 RME Fireface series (MIDI only)
Date: Mon, 7 Dec 2015 10:27:08 +0900
Message-ID: <5664E06C.9080705@sakamocchi.jp>
References: <1449408224-13955-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151206215744.GA6103@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id B9EA3265005
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 02:27:11 +0100 (CET)
In-Reply-To: <20151206215744.GA6103@marvin.atrad.com.au>
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

On Dec 07 2015 06:57, Jonathan Woithe wrote:
> On Sun, Dec 06, 2015 at 10:23:41PM +0900, Takashi Sakamoto wrote:
>> Unfortunately, ffado library can disturb this functionality.
>> In RME::Device::init_hardware() function, the library sends a write transaction
>> to 0x0000801003f4 with invalid value as higher part of address in IEEE 1212 or
>> ISO/IEC 13213. This is a worst case I describe in patch 03.
>
> The number which FFADO writes to this register is not invalid: it is in fact
> the same number which is used in drivers on other operating systems
> (obtained from protocol analysis).

No.

As long as I tested with a debug option to firewire-ohci module, it 
sends write transaction with '01000000'. This value includes invalid 
node ID.

ConfigRom::getNodeId() returns the invalid value. I think there's 
something wrong coding, such like forgetting initialization or update of 
the instance.

>> I think it better that FFADO developers fixes the bug as long as they doesn't
>> support MIDI functionality.
>
> As above, this is not exactly a bug because other systems set that register
> to the value which FFADO uses.  In the interests of interoperability I'm
> willing to remove manipulation of this register from FFADO, but I suggest
> that in time the ALSA driver should consider setting this register as is
> done under other systems or else we could introduce subtle behavioural
> differences down the track - at least until such time as we understand what
> the high part of that register does.


Regards

Takashi Sakamoto
