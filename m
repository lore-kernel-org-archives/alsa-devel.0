From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Playback open error: Inappropriate ioctl for device
Date: Mon, 19 Jul 2010 13:07:52 +0200
Message-ID: <4C443208.8070202@ladisch.de>
References: <AANLkTiksTz_s2bOJCZbQrJFA4XHifG5vA2mT_IGs5rVt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 187EF103819
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 13:08:04 +0200 (CEST)
In-Reply-To: <AANLkTiksTz_s2bOJCZbQrJFA4XHifG5vA2mT_IGs5rVt@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: john@swajime.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

John Simpson wrote:
> [1|user@Nokia-N810-43-7|~/alsa-lib-1.0.23/test]cc -lasound control.c -o control

These test programs can be compiled with "make check".

> [1|user@Nokia-N810-43-7|~/alsa-lib-1.0.23/test]./control
>   PCM next device error: Inappropriate ioctl for device

On embedded devices, this usually happens when the library is not
compiled with the same machine architecture options as the kernel,
which makes some structures have a different size due to different
sizes for 'long' or different alignment.


Regards,
Clemens
