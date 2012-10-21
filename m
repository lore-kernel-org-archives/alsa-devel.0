From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: usb-audio: Reloop Play support (TI TUSB3200AC)
Date: Sun, 21 Oct 2012 16:11:52 +0200
Message-ID: <508402A8.6080905@ladisch.de>
References: <1350652166.5549.8.camel@didier-laptop>	
 <1350743458.25322.16.camel@didier-laptop> <5082CE0E.1010701@ladisch.de>
 <1350826730.5300.2.camel@didier-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 8652A265152
 for <alsa-devel@alsa-project.org>; Sun, 21 Oct 2012 16:13:14 +0200 (CEST)
In-Reply-To: <1350826730.5300.2.camel@didier-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Didier 'Ptitjes' Villevalois <ptitjes@free.fr>
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Didier 'Ptitjes' Villevalois wrote:
> On sam., 2012-10-20 at 18:15 +0200, Clemens Ladisch wrote:
>> Didier 'Ptitjes' Villevalois wrote:
>>>                 .vendor_name = "Reloop",
>>>                 .product_name = "Play",
>>
>> These aren't needed except when they are wrong in the descriptor.
>
> In fact there is nothing appearing when I do lsusb, even when I specify
> them in the quirk. Is this not related ?

Are they wrong when you do not specify them in the quirk?


Regards,
Clemens
