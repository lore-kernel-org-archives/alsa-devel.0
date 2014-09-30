From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC] libhinawa: a light-weight I/O library for
 status/transactions to ALSA FireWire devices
Date: Tue, 30 Sep 2014 11:21:24 +0900
Message-ID: <542A13A4.8080607@sakamocchi.jp>
References: <54215BF6.5090600@sakamocchi.jp>
 <20140930014919.GE5605@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EBD52606AB
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 04:21:30 +0200 (CEST)
In-Reply-To: <20140930014919.GE5605@marvin.atrad.com.au>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ffado-devel@lists.sf.net" <ffado-devel@lists.sf.net>
List-Id: alsa-devel@alsa-project.org

Hi Jonathan,

On Sep 30 2014 10:49, Jonathan Woithe wrote:
> The situation to avoid is the one we had with libraw1394; when the new stack
> came about the preferred way to interact with it switched back to the native
> kernel interface since (as I understand the situation) it was felt that
 > libraw1394 didn't really provide a worthwhile API abstraction.

I'm sorry but I don't understand what you assume. What is 'the new stack'?

> Out of interest, is there any signficance in the library's name "hinawa"?

I require unique name for this shared library. Then, for this RFC, I 
select 'hinawa' as surely-unique name, from Japanese word according to 
my association from 'FireWire'. ('hi' = 'fire', 'nawa' = 'wire').

The 'hinawa' is just my convinience. I don't mind to use another word 
for its name.

>> Dice notification is an actual example. Dice based devices transfer
>> notification to a specific address on host controller. The address space
>> is exclusive resources on an system. For Dice notification, ALSA Dice
>> driver gives a way to utilize it for applications As well as Fireworks
>> situation, some userspace stuffs are needed to use this functionality.
>
> For sure.  One thing to keep in mind is that while this is an issue for DICE
> devices it may not apply to others.  The library API should be structured to
> keep in mind that not all features will be needed across the board.  We
> don't want to burden all subsequent firewire-audio streaming drivers with
> baggage which is only required for a small subset.

My intention of this library is to write applications for device control 
with LL (however currently it's C only...). I have no plan to add other 
functionalities except for helping transactions and notification because 
I want to reduce my maintaining effort.

In short, I have no will to make alternatives of libraw1394, 
libiec61883, libavc1394 and libffado.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
