From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ASoC: mmap or read/write?
Date: Fri, 19 Oct 2012 10:58:14 +0200
Message-ID: <50811626.9030100@ladisch.de>
References: <mailman.1.1350554402.30975.alsa-devel@alsa-project.org>
 <5080F434.6040602@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id C39C92625DB
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 10:59:31 +0200 (CEST)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3D65D20323
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 04:59:31 -0400 (EDT)
Received: from [192.168.42.150] (unknown [46.115.34.159])
 by mail.messagingengine.com (Postfix) with ESMTPA id AFD0348259C
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 04:59:30 -0400 (EDT)
In-Reply-To: <5080F434.6040602@topic.nl>
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

Mike Looijmans wrote:
> From: Prasant J <pj0585@gmail.com>
>>> Prasant J wrote:
>>>> I'm writing an alsa application for recording & playing 16 channel audio.
>>
>> I'm working with Beaglebone (ARM Cortex-A8 720 MHz). (Currently
>> failures are for 8 channels 32 bit / 16 bit, but our final target is
>> 16 channels)
>>
>> I have managed to get Audio capture working fine (after certain linux
>> optimizations) but playback is giving under-runs (only when PLAYBACK &
>> CAPTURE run together)
>
> You must be doing something wrong. I'm doing 32-bit, 16-channel input
> at 51.2kHz on a OMAP-L138 (an ARM9 CPU at 450 MHz)

Playback and capture at the same time seems to be harder for certain
embedded devices.  I don't know if this is a driver bug or a hardware
limitation.


Regards,
Clemens
