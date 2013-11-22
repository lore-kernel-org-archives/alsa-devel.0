From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: firewire-lib: an issue to generate packet with 'no
 data' in blocking mode
Date: Fri, 22 Nov 2013 12:47:46 +0100
Message-ID: <528F4462.3000909@ladisch.de>
References: <528EF2DE.9060700@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 9CB60261631
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 12:47:48 +0100 (CET)
In-Reply-To: <528EF2DE.9060700@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> I have a question about generate packet with 'no data' in blocking mode.
> I think there is out of specification in current firewire-lib.
>
> In my understanding of IEC 61883-6, there are two ways:
>
> 1. generate 'empty packet' defined in IEC 61883-1
>    - size of packet is 2 quadlets
>    - FDF = sfc
>    - packet includes just CIP headers
>
> 2. generate 'special non-empty packet' defined in IEC 61883-6
>    - size of packet is following to blocking mode
>    - FDF = 0xff ('NO-DATA' code)
>    - packet includes dummy data
>
> But current implementation is a strange combination of them.
>  - size of packet is 2 (way 1)
>  - FDF = 0xff (way 2)

It's an empty NO-DATA packet.  ;-)

I guess I just didn't notice that empty packets don't need to change
their FDF field.  This is a bug.

> If this is a qurk for some devices, I'll prepare patches to switch
> generating mode because BeBoB cannot sound with current firewire-lib. If
> this is a bug, then I want to discuss which is better for firewire-lib.

Empty packets should be fine for all devices.  (NO-DATA packets would
waste DMA bandwidth.)


Regards,
Clemens
