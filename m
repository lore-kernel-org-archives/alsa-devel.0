From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: xhci: Not enough bandwidth for new device state
Date: Thu, 1 Mar 2018 12:16:37 +0100
Message-ID: <ac4654e7-819d-29d5-d1c0-9f377ee8be83@ladisch.de>
References: <20180228210753.GA3131@waldemar-brodkorb.de>
 <20180301070757.GY12535@waldemar-brodkorb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 1285B267332
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 12:16:09 +0100 (CET)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id BE46155807F4
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 12:16:06 +0100 (CET)
In-Reply-To: <20180301070757.GY12535@waldemar-brodkorb.de>
Content-Language: en-US
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

Waldemar Brodkorb wrote:
>> [  547.352746] usb 3-5.2: 3:1: usb_set_interface failed (-28)
>> [  548.352865] usb 3-5.3: Not enough bandwidth for new device state.
>> [  548.352868] usb 3-5.3: Not enough bandwidth for altsetting 1
>>
>> I have connected a 7-Port USB 3.0 Hub to my machine.
>> I have 6 different Headsets and USB Soundcards connected to the HUB.
>>
>> As soon as I start a C++ application which opens all ALSA devices
>> I get these errors and the USB stopps working correctly.
>>
>> I think the maximum count of USB sound devices, which behave stable
>> is three or four.
>>
>> Is this some miscalculation of the Linux kernel regarding the USB
>> bandwidth usage? How I can determine how much bandwidth the USB
>> sound card driver preallocates?
>>
>> Or are five USB soundcards really too much for an USB 3.0 bus?
>
> There is no webcam involved, which usually uses MaxPacketsize of 1024,
> so why I get the overallocation?

AFAIK on xHCI controllers, the kernel and the controller's firmware
must work together to handle this.

It's possible that a USB 2.0 hub might work better.

Try asking on the linux-usb list.


Regards,
Clemens
