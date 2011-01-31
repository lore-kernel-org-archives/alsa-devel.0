From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: need input on USB Audio class device.
Date: Mon, 31 Jan 2011 12:42:28 +0100
Message-ID: <4D46A024.5000901@ladisch.de>
References: <AANLkTi=yA+Ma0zo6HAceOdK1u8gv1hcVcT1dsOapv=Tp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 5F8451038C6
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 14:56:32 +0100 (CET)
In-Reply-To: <AANLkTi=yA+Ma0zo6HAceOdK1u8gv1hcVcT1dsOapv=Tp@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sakthi Subramanian <sakthi.subramaniang@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sakthi Subramanian wrote:
> ...
> I have started capturing the data with the above change,
> and opened the same using Audacity, it says 16 bit PCM Mono channel Little Endian.
> in my opinion, that must show as 8 channel.

What did you open, the device or a file?
In the first case, you have to tell Audacity to use 8 channels.
In the latter case, I'd guess that your application did not write the .wav
header correctly.


Regards,
Clemens
