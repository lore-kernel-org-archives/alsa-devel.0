From: 6275 kson <6275.kson@gmail.com>
Subject: Re: USB Audio device syncpipe error
Date: Thu, 9 Sep 2010 16:51:45 -0500
Message-ID: <AANLkTimzCNquUNQapdo4afcwtBYYVHGPH9U-J1xXHqXE@mail.gmail.com>
References: <AANLkTinzHSVgsUocCMBTW=+A=b2qc6vzKuq7t9jzgojX@mail.gmail.com>
	<AANLkTi=EXqFDPn+a1K+OeLA+G5pnh0yMt6nX2VA_wQDD@mail.gmail.com>
	<4C8891D2.1020300@ladisch.de>
	<AANLkTingHyn2wyJ50uH9GpjnTg_YsL6Q0gzDoVyArvgv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 4FD26243F1
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Sep 2010 23:51:48 +0200 (CEST)
Received: by vws20 with SMTP id 20so1802143vws.38
	for <alsa-devel@alsa-project.org>; Thu, 09 Sep 2010 14:51:45 -0700 (PDT)
In-Reply-To: <AANLkTingHyn2wyJ50uH9GpjnTg_YsL6Q0gzDoVyArvgv@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, daniel@caiaq.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Well I basically understand what is wrong.  Usbaudio is expecting the packet
size to be 4 and the value to be encoded as 16.16 because the device is
operating at high speed.  I made the change and my device now shows up
properly as an output device and playback works but the feedback polling
interval is incorrect.

Since the feedback endpoint descriptor is not class specific I can see why
one would expect it to be a usb 2.0 standard endpoint descriptor, however,
that would mean I should also change my other audio streaming endpoint
descriptors.

Unfortunately, I'm not sure the proper way to fix this - any advice would be
appreciated.

Cheers



On Thu, Sep 9, 2010 at 10:04 AM, 6275 kson <6275.kson@gmail.com> wrote:

>
>
> On Thu, Sep 9, 2010 at 2:50 AM, Clemens Ladisch <clemens@ladisch.de>wrote:
>
>> 6275 kson wrote:
>> > cannot submit syncpipe for urb 0, error -90: internal error
>>
>> Documentation/usb/error-codes.txt says:
>> | -EMSGSIZE       (a) endpoint maxpacket size is zero; it is not usable
>> |                     in the current interface altsetting.
>> |                 (b) ISO packet is larger than the endpoint maxpacket.
>> |                 (c) requested data transfer length is invalid: negative
>> |                     or too large for the host controller.
>>
>> So, what is the sync packet size?
>>
>
>>
> The packet size is 3.
>
> The descriptor used for High Speed is essentially the same as the full
> speed descriptor except we have adjusted the endpoint polling rates so they
> match the full speed rate (1ms).
>
> Thanks for your help,
>
>
>
>
