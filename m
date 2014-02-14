From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Roland V-Studio 20
Date: Fri, 14 Feb 2014 20:07:56 +0100
Message-ID: <52FE698C.5080501@ladisch.de>
References: <8010247.EC2u5T8PMU@kamdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id E563B265455
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2014 20:08:21 +0100 (CET)
In-Reply-To: <8010247.EC2u5T8PMU@kamdesktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Keith A. Milner" <maillist@superlative.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Keith A. Milner wrote:
> I've recently picked up a cheap Roland V-Studio 20 device. This is described
> in the product spec as supporting 24-bit, but it is appearing as 16-bit only.

How does it appear in /proc/asound/card*/stream0?

> Unfortunately, Roland seem to insist on their own proprietary descriptors,
> which I don't know how to decode, so I'm not sure whether this is genuinely a
> 24-bit interface that isn't being interpreted properly by snd-usb-audio, or
> whether it's marketing spin, and it's actually 16-bit.

> ** UNRECOGNIZED:  0b 24 02 01 02 03 18 01 44 ac 00
                                   ^^ ^^
                                   This is three bytes, 24 bits.


Regards,
Clemens
