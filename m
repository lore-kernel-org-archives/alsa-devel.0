From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ASUS STRIX sound card quiet microphone (like,
	really	quiet ...)
Date: Tue, 5 Jul 2016 11:39:20 +0200
Message-ID: <c69331ff-32e0-e141-92cd-53a6fab01f17@ladisch.de>
References: <f538e10ebefb9bcf292087e30a46d563@inventati.org>
 <e7481e66-a039-9b64-7813-e029ec1d1d2e@ladisch.de>
 <f558bfdc3952e84bbb52bcad3cd9e178@inventati.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 9083D265325
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2016 11:39:30 +0200 (CEST)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by dehamd003.servertools24.de (Postfix) with ESMTPSA id 2114FF5204A4
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2016 11:39:21 +0200 (CEST)
In-Reply-To: <f558bfdc3952e84bbb52bcad3cd9e178@inventati.org>
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

auspicious@inventati.org wrote:
> On 05/07/2016 07:19, Clemens Ladisch wrote:
>> auspicious@inventati.org wrote:
>>> I currently am using an ASUS STRIX RAID DLX sound card. It contains the following processor:
>>> C-Media USB2.0 6632AX High-Definition Sound Processor (Max. 384KHz / 24bit)
>>>
>>> the microphone bit has always been troublesome.
>>> it started working but it is incredibly quiet.
>>
>> You did not mention mixer controls.
>> Does it have any?  (Try alsamixer.)
>
> Attached image in the attachment

That "Input Gain" looks OK.
Does it actually work?  Does it make the mic input quieter?

It's possible that there is some vendor-specific stuff that the
USB audio driver does not know.  Does it work in Windows with
Microsoft's generic USB audio driver, or does it need a custom
driver from Asus?


Regards,
Clemens
