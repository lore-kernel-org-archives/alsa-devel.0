From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB Audio device syncpipe error
Date: Fri, 10 Sep 2010 09:01:32 +0200
Message-ID: <4C89D7CC.3070605@ladisch.de>
References: <AANLkTinzHSVgsUocCMBTW=+A=b2qc6vzKuq7t9jzgojX@mail.gmail.com>	<AANLkTi=EXqFDPn+a1K+OeLA+G5pnh0yMt6nX2VA_wQDD@mail.gmail.com>	<4C8891D2.1020300@ladisch.de>	<AANLkTingHyn2wyJ50uH9GpjnTg_YsL6Q0gzDoVyArvgv@mail.gmail.com>
	<AANLkTimzCNquUNQapdo4afcwtBYYVHGPH9U-J1xXHqXE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 972372441D
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 09:01:09 +0200 (CEST)
In-Reply-To: <AANLkTimzCNquUNQapdo4afcwtBYYVHGPH9U-J1xXHqXE@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 6275 kson <6275.kson@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

6275 kson wrote:
> Well I basically understand what is wrong.  Usbaudio is expecting the packet
> size to be 4 and the value to be encoded as 16.16 because the device is
> operating at high speed.  I made the change and my device now shows up
> properly as an output device and playback works but the feedback polling
> interval is incorrect.

What interval do you expect in this situation, and what interval do you
actually get?

> Since the feedback endpoint descriptor is not class specific I can see why
> one would expect it to be a usb 2.0 standard endpoint descriptor,

Yes, the UAC 1.0 spec cannot override the USB spec in this regard.

> however, that would mean I should also change my other audio
> streaming endpoint descriptors.

Which other descriptors?  AFAICS, the only other thing that is affected
by high-speed is the packet size and format of the sync endpoint.


Regards,
Clemens
